import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/promo_code_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  double get _subtotal =>
      dummyCart.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);

  double promoCodeDiscount = 0.0;

  void getCartItems(String? promoCode) {
    emit(CartLoading());
    if (promoCode != null) {
      final PromoCodeModel promo = promoCodes.firstWhere(
        (promo) => promo.code == promoCode,
        orElse: () => PromoCodeModel(code: '', discount: 0.0),
      );
      promoCodeDiscount = promo.discount;
      Future.delayed(const Duration(milliseconds: 500), () {
        emit(CartLoaded(cartItems: dummyCart, subtotal: _subtotal, discount: promo.discount));
      });
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        emit(CartLoaded(cartItems: dummyCart, subtotal: _subtotal, discount: 0.0));
      });
    }
  }

  void incrementCounter(String productId) {
    final selectedItem = dummyCart.firstWhere((item) => item.product.id == productId);
    final updatedItem = selectedItem.copyWith(quantity: selectedItem.quantity + 1);

    // replace the old item with updated item
    final index = dummyCart.indexOf(selectedItem);
    dummyCart[index] = updatedItem;

    emit(CartLoaded(cartItems: dummyCart, subtotal: _subtotal, discount: promoCodeDiscount));
  }

  void decrementCounter(String productId) {
    final selectedItem = dummyCart.firstWhere((item) => item.product.id == productId);

    if (selectedItem.quantity > 1) {
      final updatedItem = selectedItem.copyWith(quantity: selectedItem.quantity - 1);
      final index = dummyCart.indexOf(selectedItem);
      dummyCart[index] = updatedItem;
    } else {
      dummyCart.remove(selectedItem);
    }

    emit(CartLoaded(cartItems: dummyCart, subtotal: _subtotal, discount: promoCodeDiscount));
  }

  
}
