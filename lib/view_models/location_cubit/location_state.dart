part of 'location_cubit.dart';

sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationFetching extends LocationState {}

final class LocationFetched extends LocationState {
  final List<LocationItemModel> locations;

  LocationFetched({required this.locations});
}

final class LocationFetchingError extends LocationState {
  final String message;

  LocationFetchingError(this.message);
}

final class LocationAdding extends LocationState {}

final class LocationAdded extends LocationState {}

final class LocationAddingError extends LocationState {
  final String message;

  LocationAddingError(this.message);
}

final class LocationSelected extends LocationState {
  final LocationItemModel chosenLocation;

  LocationSelected({required this.chosenLocation});
}

final class LocationConfirming extends LocationState {}

final class LocationConfirmed extends LocationState {}

class LocationConfirmingError extends LocationState {
  final String message;

  LocationConfirmingError(this.message);
}
