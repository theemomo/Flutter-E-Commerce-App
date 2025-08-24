part of 'cart_cubit.dart';

sealed class CartState {
  const CartState();
}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartLoaded extends CartState {
  final List<AddToCartModel> cartItems;
  final double subtotal;

  const CartLoaded({required this.cartItems, required this.subtotal});
}

final class CartError extends CartState {
  final String message;

  const CartError(this.message);
}

final class CartQuantityUpdated extends CartState {
  final String productId;

  const CartQuantityUpdated({required this.productId});
}
