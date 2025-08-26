import 'package:e_commerce/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/models/add_to_cart_model.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());
  

  void getCheckoutItems() {
    emit(CheckoutLoading());
    final subtotal = dummyCart.fold(
      0.0,
      (sum, item) => sum + item.product.price * item.quantity,
    );
    final numOfProducts = dummyCart.fold(
      0,
      (sum, item) => sum + item.quantity,
    );

    final PaymentCardModel? chosenPaymentCard = dummyPaymentCards.isNotEmpty ? dummyPaymentCards[0] : null;

    emit(CheckoutLoaded(
      cartItems: dummyCart,
      totalAmount: subtotal + 20,
      numOfProducts: numOfProducts,
      chosenPaymentCard: chosenPaymentCard,
    ));
  }
}
