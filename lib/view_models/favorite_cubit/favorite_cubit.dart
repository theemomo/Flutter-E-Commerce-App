import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/favorite_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit() : super(FavoriteInitial());
  final _authServices = AuthServicesImpl();
  final _favoriteServices = FavoriteServicesImpl();

  Future<void> getFavoriteProducts() async {
    emit(FavoriteLoading());
    try {
      final favoriteProducts = await _favoriteServices.getFavorite(
        _authServices.getCurrentUser()!.uid,
      );
      emit(FavoriteLoaded(favoriteProducts));
    } catch (e) {
      emit(FavoriteLoadingError(e.toString()));
    }
  }

  Future<void> removeFavorite(String productId) async {
    emit(FavoriteRemoving(productId));
    try {
      await _favoriteServices.removeFavorite(_authServices.getCurrentUser()!.uid, productId);
      emit(FavoriteRemoved(productId));
    } catch (e) {
      emit(FavoriteRemovingError(e.toString()));
    }
  }
}
