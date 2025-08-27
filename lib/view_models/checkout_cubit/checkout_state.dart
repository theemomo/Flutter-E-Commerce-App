part of 'checkout_cubit.dart';

sealed class CheckoutState {}

final class CheckoutInitial extends CheckoutState {}

class CheckoutLoading extends CheckoutState {}

class CheckoutLoaded extends CheckoutState {
  final List<AddToCartModel> cartItems;
  final double totalAmount;
  final int numOfProducts;
  final PaymentCardModel? chosenPaymentCard;
  final LocationItemModel? shippingAddress;

  CheckoutLoaded({
    required this.cartItems,
    required this.totalAmount,
    required this.numOfProducts,
    this.chosenPaymentCard,
    this.shippingAddress,
  });
}

class CheckoutError extends CheckoutState {
  final String message;

  CheckoutError(this.message);
}
