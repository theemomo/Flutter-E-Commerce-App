import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/promo_code_model.dart';
import 'package:e_commerce/services/cart_services.dart';
import 'package:e_commerce/services/discount_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  final _cartServices = CartServicesImpl();
  final _discountServices = DiscountServicesImpl();

  double promoCodeDiscount = 0.0;
  late List<AddToCartModel> cart;

  void getCartItems(String? promoCode) async {
    emit(CartLoading());
    try {
      final List<AddToCartModel> cartItems = await _cartServices.fetchCartItems();
      cart = cartItems;
      final subtotal = cartItems.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);
      final promoCodes = await _discountServices.fetchPromoCodes();
      

      if (promoCode != null) {
        final PromoCodeModel promo = promoCodes.firstWhere(
          (promo) => promo.code == promoCode,
          orElse: () => PromoCodeModel(code: '', discount: 0.0),
        );
        promoCodeDiscount = promo.discount;
        emit(CartLoaded(cartItems: cartItems, subtotal: subtotal, discount: promo.discount));
      } else {
        emit(CartLoaded(cartItems: cartItems, subtotal: subtotal, discount: 0.0));
      }
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> incrementCounter(AddToCartModel cartItem) async {
    final updatedCartItem = cartItem.copyWith(quantity: cartItem.quantity + 1);
    await _cartServices.setCartItem(updatedCartItem);
    final subtotal = cart.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);

    emit(CartLoaded(cartItems: cart, subtotal: subtotal, discount: promoCodeDiscount));
  }

  Future<void> decrementCounter(AddToCartModel cartItem) async {
    final updatedCartItem = cartItem.copyWith(quantity: cartItem.quantity - 1);
    await _cartServices.setCartItem(updatedCartItem);
    final subtotal = cart.fold(0.0, (sum, item) => sum + item.product.price * item.quantity);

    emit(CartLoaded(cartItems: cart, subtotal: subtotal, discount: promoCodeDiscount));
  }
}
