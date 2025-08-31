part of 'user_data_cubit.dart';


sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

final class GetUserDataLoading extends UserDataState {}

final class GetUserDataLoaded extends UserDataState {
  final String username;
  final String email;
  GetUserDataLoaded(this.username, this.email);
}

final class GetUserDataLoadingError extends UserDataState {
  final String message;
  GetUserDataLoadingError(this.message);
}
