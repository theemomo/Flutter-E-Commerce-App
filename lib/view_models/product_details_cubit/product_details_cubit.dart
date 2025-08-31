import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/product_details_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  ProductSize? selectedSize;
  late int quantity = 1;
  final _productDetailsServices = ProductDetailsServicesImpl();
  final _authServices = AuthServicesImpl();

  void getProductDetailsPage(String id) async {
    emit(ProductDetailsLoading());
    try {
      final ProductItemModel selectedProduct = await _productDetailsServices.fetchProductDetails(
        id,
      );
      emit(ProductDetailsLoaded(product: selectedProduct));
    } catch (e) {
      emit(ProductDetailsError(e.toString()));
    }
  }

  // ! counter section

  void incrementCounter(String productId) {
    quantity++;
    emit(QuantityCounterLoaded(value: quantity));
  }

  void decrementCounter(String productId) {
    quantity--;
    emit(QuantityCounterLoaded(value: quantity));
  }

  // ! size section

  void selectSize(ProductSize size) {
    selectedSize = size;
    emit(SizeSelected(size: size));
  }

  // ! add to cart section

  Future<void> addToCart(String productId) async {
    emit(ProductAddingToCart());

    try {
      final ProductItemModel selectedProduct = await _productDetailsServices.fetchProductDetails(
        productId,
      );
      final AddToCartModel cartItem = AddToCartModel(
        id: DateTime.now().toIso8601String(),
        product: selectedProduct,
        size: selectedSize!,
        quantity: quantity,
      );
      _productDetailsServices.addToCart(cartItem, _authServices.getCurrentUser()!.uid);
      emit(ProductAddedToCart(id: productId));
    } catch (e) {
      emit(ProductAddingToCartError(e.toString()));
    }
  }
}
