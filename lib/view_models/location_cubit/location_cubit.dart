import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/models/location_item_model.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit() : super(LocationInitial());

  void fetchLocations() async {
    emit(LocationFetching());
    await Future.delayed(const Duration(seconds: 1));
    emit(LocationFetched(locations: dummyLocations));
  }

  void addLocation(String location) async {
    emit(LocationAdding());
    await Future.delayed(const Duration(seconds: 1));
    final city = location.split(', ').first;
    final newLocation = LocationItemModel(
      city: city,
      country: location,
      id: DateTime.now().toIso8601String(),
    );
    dummyLocations.add(newLocation);
    emit(LocationAdded());
    emit(LocationFetched(locations: dummyLocations));
  }

  String selectedLocationId = dummyLocations.first.id;

  void selectLocation(String locationId) async {
    selectedLocationId = locationId;
    final chosenLocation = dummyLocations.firstWhere((item) => item.id == selectedLocationId);
    emit(LocationSelected(chosenLocation: chosenLocation));
  }

  void confirmLocation() async {
    emit(LocationConfirming());
    await Future.delayed(const Duration(seconds: 1));
    
    var chosenLocation = dummyLocations.firstWhere((item) => item.id == selectedLocationId);
    var previousLocation = dummyLocations.firstWhere(
      (item) => item.isChosen == true,
      orElse: () => dummyLocations.first,
    );
    previousLocation = previousLocation.copyWith(isChosen: false);
    chosenLocation = chosenLocation.copyWith(isChosen: true);

    final previousLocationIndex = dummyLocations.indexWhere((element) => element.id == previousLocation.id);
    final chosenLocationIndex = dummyLocations.indexWhere((element) => element.id == chosenLocation.id);

    dummyLocations[previousLocationIndex] = previousLocation;
    dummyLocations[chosenLocationIndex] = chosenLocation;

    emit(LocationConfirmed());
  }
}
