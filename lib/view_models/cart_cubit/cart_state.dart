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

// final class CartDiscountApplied extends CartState {
//   final List<AddToCartModel> cartItems;
//   final double subtotal;
//   final double discount;
//   final double total;

//   const CartDiscountApplied({
//     required this.cartItems,
//     required this.subtotal,
//     required this.discount,
//     required this.total,
//   });
// }
