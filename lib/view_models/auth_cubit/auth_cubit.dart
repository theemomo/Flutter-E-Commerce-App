import 'package:e_commerce/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices authServices = AuthServicesImpl();

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final result = await authServices.loginWithEmailAndPassword(email, password);
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("Login failed"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> register({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final result = await authServices.registerWithEmailAndPassword(email, password);
      if (result) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure("Registration failed"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void checkAuthStatus() {
    final user = authServices.getCurrentUser();
    if (user != null) {
      emit(AuthSuccess());
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> logout() async {
    emit(AuthLoggingOut());
    await Future.delayed(const Duration(seconds: 2));
    try {
      await authServices.logout();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthErrorLoggingOut(e.toString()));
    }
  }

  Future<void> authWithFacebook() async {
    emit(FacebookAuthLoading());
    try {
      final result = await authServices.authWithFacebook();
      if (result) {
        emit(FacebookAuthSuccess());
      } else {
        emit(AuthFailure("Facebook authentication failed"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}


// Future<void> authenticateWithFacebook() async {
//     emit(const FacebookAuthenticating());
//     try {
//       final result = await authServices.authenticateWithFacebook();
//       if (result) {
//         emit(const FacebookAuthDone());
//       } else {
//         emit(const FacebookAuthError('Facebook authentication failed'));
//       }
//     } catch (e) {
//       emit(FacebookAuthError(e.toString()));
//     }
//   }