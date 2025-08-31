import 'package:e_commerce/models/user_data.dart';
import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utils/api_paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthServices authServices = AuthServicesImpl();
  final firestore = FirestoreServices.instance;

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

  Future<void> _saveUserData({required String email, required String username}) async {
    final currentUser = authServices.getCurrentUser();

        final UserData userData = UserData(
          id: currentUser!.uid,
          email: email,
          username: username,
          createdAt: DateTime.now().toString(),
        );

        await firestore.setData(
          path: ApiPaths.users(userId: currentUser.uid),
          data: userData.toMap(),
        );
  }


  Future<void> register({
    required String email,
    required String password,
    required String username,
  }) async {
    emit(AuthLoading());
    try {
      final result = await authServices.registerWithEmailAndPassword(email, password);
      if (result) {
        await _saveUserData(email: email, username: username); 

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
