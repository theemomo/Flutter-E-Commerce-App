import 'package:e_commerce/services/auth_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit() : super(UserDataInitial());
  final _authServices = AuthServicesImpl();

  void getUserData() {
    emit(GetUserDataLoading());
    final String username = _authServices
        .getCurrentUser()!
        .email
        .toString()
        .split("@")
        .first
        .toUpperCase();
    final String email = _authServices.getCurrentUser()!.email.toString();

    emit(GetUserDataLoaded(username, email));
  }
}
