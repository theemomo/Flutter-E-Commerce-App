import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/home_carousel_item_model.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/favorite_services.dart';
import 'package:e_commerce/services/home_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  final HomeServices _homeServices = HomeServicesImpl();
  final _authServices = AuthServicesImpl();
  final _favoriteServices = FavoriteServicesImpl();

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      // all products
      final products = await _homeServices.fetchProducts();
      final carouselItems = await _homeServices.fetchCarouselItems();
      // only favorite products
      final favoriteProducts = await _favoriteServices.getFavorite(
        _authServices.getCurrentUser()!.uid, 
      );

      // if the product is in the "favoriteProducts" and also in the "products" make this product.isFav = true
      final List<ProductItemModel> finalProducts = products.map((product) {
        final isFavorite = favoriteProducts.any((item) => item.id == product.id);
        return product.copyWith(isFav: isFavorite);
      }).toList();

      emit(HomeLoaded(products: finalProducts, carouselItems: carouselItems));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  Future<void> getCategoriesData() async {
    emit(CategoryLoading());
    try {
      final categories = await _homeServices.fetchCategories();
      emit(CategoryLoaded(categories));
    } catch (e) {
      emit(CategoryLoadingError(e.toString()));
    }
  }

  Future<void> setFavorite(ProductItemModel product) async {
    emit(SetFavLoading(product.id));
    try {
      final List<ProductItemModel> favoriteProducts = await _favoriteServices.getFavorite(
        _authServices.getCurrentUser()!.uid,
      );
      final isFavorite = favoriteProducts.any((item) => item.id == product.id);

      if (isFavorite) {
        // set unfavorite
        await _favoriteServices.removeFavorite(_authServices.getCurrentUser()!.uid, product.id);
      } else {
        // set favorite
        await _favoriteServices.addFavorite(_authServices.getCurrentUser()!.uid, product);
      }

      emit(SetFavSuccess(!isFavorite, product.id));
    } catch (e) {
      emit(SetFavError(e.toString(), product.id));
    }
  }
  

}
