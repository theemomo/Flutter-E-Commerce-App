import 'package:e_commerce/models/location_item_model.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utils/api_paths.dart';

abstract class LocationServices {
  Future<List<LocationItemModel>> fetchLocations(String userId);
  Future<LocationItemModel> fetchLocation(String userId, String locationId);
  Future<void> setLocation(String userId, LocationItemModel location);
  Future<void> deleteLocation(String userId, String locationId);
}

class LocationServicesImpl implements LocationServices {
  final _firestoreServices = FirestoreServices.instance;
  @override
  Future<List<LocationItemModel>> fetchLocations(String userId, [bool chosen = false]) async {
    final result = await _firestoreServices.getCollection(
      path: ApiPaths.locations(userId),
      builder: (data, documentId) => LocationItemModel.fromMap(data),
      queryBuilder: chosen ? (query) => query.where('isChosen', isEqualTo: true) : null,
    );
    return result;
  }

  @override
  Future<void> setLocation(String userId, LocationItemModel location) async {
    await _firestoreServices.setData(
      path: ApiPaths.location(userId, location.id),
      data: location.toMap(),
    );
  }

  @override
  Future<LocationItemModel> fetchLocation(String userId, String locationId) async {
    final result = await _firestoreServices.getDocument(
      path: ApiPaths.location(userId, locationId),
      builder: (data, documentId) => LocationItemModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<void> deleteLocation(String userId, String locationId) async {
    await _firestoreServices.deleteData(path: ApiPaths.location(userId, locationId));
  }
}
