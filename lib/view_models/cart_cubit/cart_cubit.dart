import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  void getCartItems() {
    emit(CartLoading());
    // Simulate a network call
    Future.delayed(Duration(seconds: 1), () {
      final subtotal = dummyCart.fold(
        0.0,
        (sum, item) => sum + item.product.price * item.quantity,
      );
      emit(CartLoaded(cartItems: dummyCart, subtotal: subtotal));
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

    // first emit a temporary update state (optional, useful for animations)
    emit(CartQuantityUpdated(productId: productId));
    final subtotal = dummyCart.fold(
      0.0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
    // then emit the full cart state so UI rebuilds correctly
    emit(CartLoaded(cartItems: dummyCart, subtotal: subtotal));
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
    final subtotal = dummyCart.fold(
      0.0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
    emit(CartLoaded(cartItems: dummyCart, subtotal: subtotal));
  }
}
