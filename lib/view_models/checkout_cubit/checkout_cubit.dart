import 'package:e_commerce/models/location_item_model.dart';
import 'package:e_commerce/models/payment_card_model.dart';
import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/cart_services.dart';
import 'package:e_commerce/services/checkout_services.dart';
import 'package:e_commerce/services/location_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/models/add_to_cart_model.dart';

part 'checkout_state.dart';

class CheckoutCubit extends Cubit<CheckoutState> {
  CheckoutCubit() : super(CheckoutInitial());

  final _cartServices = CartServicesImpl();
  final _authServices = AuthServicesImpl();
  final _checkoutServices = CheckoutServicesImpl();
  final _locationServices = LocationServicesImpl();
  Future<void> getCheckoutItems() async {
    emit(CheckoutLoading());
    final cartItems = await _cartServices.fetchCartItems();
    final numOfProducts = cartItems.fold(0, (sum, item) => sum + item.quantity);

    final paymentCards = await _checkoutServices.fetchPaymentCards(
      _authServices.getCurrentUser()!.uid,
      false,
    );

    final PaymentCardModel? chosenPaymentCard = paymentCards.isNotEmpty
        ? (paymentCards.any((item) => item.isChosen)
              ? paymentCards.firstWhere((item) => item.isChosen)
              : paymentCards.first)
        : null;

    final locations = await _locationServices.fetchLocations(_authServices.getCurrentUser()!.uid);

    final LocationItemModel? chosenLocation =
        locations.where((item) => item.isChosen == true).toList().isNotEmpty
        ? locations.firstWhere((item) => item.isChosen == true)
        : null;

    emit(
      CheckoutLoaded(
        cartItems: cartItems,
        numOfProducts: numOfProducts,
        chosenPaymentCard: chosenPaymentCard,
        shippingAddress: chosenLocation,
      ),
    );
  }
}
