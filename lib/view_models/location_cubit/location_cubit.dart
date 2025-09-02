import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/location_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/models/location_item_model.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());
  final _authServices = AuthServicesImpl();
  final _locationServices = LocationServicesImpl();
  String? selectedLocationId;
  LocationItemModel? selectedLocation;

  Future<void> fetchLocations() async {
    emit(LocationFetching());
    try {
      final locations = await _locationServices.fetchLocations(_authServices.getCurrentUser()!.uid);

      if (locations.isEmpty) {
        selectedLocation = null;
        selectedLocationId = null;
        emit(LocationFetched(locations: []));
        return;
      }

      for (LocationItemModel location in locations) {
        if (location.isChosen) {
          selectedLocation = location;
          selectedLocationId = location.id;
        }
      }
      selectedLocationId ??= locations.first.id;
      selectedLocation ??= locations.first;
      emit(LocationFetched(locations: locations));
      emit(LocationSelected(chosenLocation: selectedLocation!));
    } catch (e) {
      emit(LocationFetchingError(e.toString()));
    }
  }

  Future<void> addLocation(String location) async {
    emit(LocationAdding());
    try {
      final city = location.split(', ').first;
      final country = location.split(', ').last;
      final newLocation = LocationItemModel(
        city: city,
        country: country,
        id: DateTime.now().toIso8601String(),
      );
      await _locationServices.setLocation(_authServices.getCurrentUser()!.uid, newLocation);
      final locations = await _locationServices.fetchLocations(_authServices.getCurrentUser()!.uid);
      emit(LocationAdded());
      emit(LocationFetched(locations: locations));
    } catch (e) {
      emit(LocationAddingError(e.toString()));
    }
  }

  Future<void> selectLocation(String locationId) async {
    selectedLocationId = locationId;
    try {
      final chosenLocation = await _locationServices.fetchLocation(
        _authServices.getCurrentUser()!.uid,
        locationId,
      );
      selectedLocation = chosenLocation;
      emit(LocationSelected(chosenLocation: chosenLocation));
    } catch (e) {
      null;
    }
  }

  Future<void> confirmLocation() async {
    emit(LocationConfirming());
    try {
      final currentUser = _authServices.getCurrentUser();
      final previousChosenLocation = (await _locationServices.fetchLocations(
        currentUser!.uid,
        true,
      ));
      if (previousChosenLocation.isNotEmpty) {
        final previousLocation = previousChosenLocation.first.copyWith(isChosen: false);
        await _locationServices.setLocation(currentUser.uid, previousLocation);
      }

      final currentLocation = selectedLocation!.copyWith(isChosen: true);
      await _locationServices.setLocation(currentUser.uid, currentLocation);
      emit(LocationConfirmed());
    } catch (e) {
      emit(LocationConfirmingError(e.toString()));
    }
  }

  Future<void> deleteLocation(String locationId) async {
    try {
      await _locationServices.deleteLocation(_authServices.getCurrentUser()!.uid, locationId);
      final locations = await _locationServices.fetchLocations(_authServices.getCurrentUser()!.uid);
      emit(LocationFetched(locations: locations));
    } catch (e) {
      emit(LocationFetchingError(e.toString()));
    }
  }
}
