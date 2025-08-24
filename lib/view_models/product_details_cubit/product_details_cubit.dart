import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());
  ProductSize? selectedSize;
  late int quantity = 1;

  void getProductDetailsPage(String id) {
    emit(ProductDetailsLoading());

    Future.delayed(Duration(seconds: 1), () {
      final selectedProduct = dummyProducts.firstWhere((item) => item.id == id);
      emit(ProductDetailsLoaded(product: selectedProduct));
    });
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

  void addToCart(String productId) {
    emit(ProductAddingToCart());
    final AddToCartModel cartItem = AddToCartModel(
      id: productId,
      product: dummyProducts.firstWhere((item) => item.id == productId),
      size: selectedSize!,
      quantity: quantity,
    );
    Future.delayed(Duration(seconds: 1), () {
      dummyCart.add(cartItem);
      emit(ProductAddedToCart(id: productId));
    });
  }
}
