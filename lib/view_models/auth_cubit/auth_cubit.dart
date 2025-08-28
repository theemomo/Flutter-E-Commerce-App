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
}
