import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  double get _subtotal => dummyCart.fold(
        0.0,
        (sum, item) => sum + item.product.price * item.quantity,
      );

  void getCartItems() {
    emit(CartLoading());

    Future.delayed(const Duration(seconds: 1), () {
      emit(CartLoaded(cartItems: dummyCart, subtotal: _subtotal));
      // emit(SubTotalUpdated(subtotal: _subtotal));
    });
  }

  void incrementCounter(String productId) {
    final selectedItem = dummyCart.firstWhere(
      (item) => item.product.id == productId,
    );
    final updatedItem = selectedItem.copyWith(
      quantity: selectedItem.quantity + 1,
    );

    // replace the old item with updated item
    final index = dummyCart.indexOf(selectedItem);
    dummyCart[index] = updatedItem;

    emit(CartQuantityUpdated(productId: productId));
    emit(CartLoaded(cartItems: dummyCart, subtotal: _subtotal));
  }

  void decrementCounter(String productId) {
    final selectedItem = dummyCart.firstWhere(
      (item) => item.product.id == productId,
    );

    if (selectedItem.quantity > 1) {
      final updatedItem = selectedItem.copyWith(
        quantity: selectedItem.quantity - 1,
      );
      final index = dummyCart.indexOf(selectedItem);
      dummyCart[index] = updatedItem;
    } else {
      dummyCart.remove(selectedItem);
    }

    emit(CartQuantityUpdated(productId: productId));
    emit(CartLoaded(cartItems: dummyCart, subtotal: _subtotal));
  }



}
