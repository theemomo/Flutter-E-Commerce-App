part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartItems;
  final double subtotal;
  final double discount;

  const CartLoaded({required this.cartItems, required this.subtotal, required this.discount});
}

final class CartError extends CartState {
  final String message;

  const CartError(this.message);
}




final class PromoCodeApplied extends CartState {
  final String code;
  final double discount;

  const PromoCodeApplied({required this.code, required this.discount});
}
