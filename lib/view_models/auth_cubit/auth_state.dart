part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}

final class AuthLoggingOut extends AuthState {}

final class AuthLoggedOut extends AuthState {}

final class AuthErrorLoggingOut extends AuthState {
  final String error;

  AuthErrorLoggingOut(this.error);
}

final class FacebookAuthLoading extends AuthState {}

final class FacebookAuthSuccess extends AuthState {}

final class FacebookAuthFailure extends AuthState {
  final String error;

  FacebookAuthFailure(this.error);
}

final class UpdatePasswordSuccessfully extends AuthState {}

final class UpdatingPassword extends AuthState {}

final class UpdatingPasswordFailure extends AuthState {
  final String message;
  UpdatingPasswordFailure(this.message);
}

final class DeletingAccount extends AuthState {}

final class AccountDeleted extends AuthState {}

final class ErrorDeletingAccount extends AuthState {
  final String message;
  ErrorDeletingAccount(this.message);
}
