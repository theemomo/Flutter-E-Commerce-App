import 'package:e_commerce/models/payment_card_model.dart';
import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/checkout_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());
  late String selectedPaymentId;

  final _authServices = AuthServicesImpl();
  final _checkoutServices = CheckoutServicesImpl();

  Future<void> addNewCard({
    required String cardNumber,
    required String cardHolderName,
    required String cardExpireDate,
    required String ccvCode,
  }) async {
    emit(AddNewCardLoading());

    try {
      final newCard = PaymentCardModel(
        id: DateTime.now().toIso8601String(),
        cardNumber: cardNumber,
        cardHolderName: cardHolderName,
        cardExpireDate: cardExpireDate,
        ccvCode: ccvCode,
      );
      await _checkoutServices.setCard(_authServices.getCurrentUser()!.uid, newCard);
      emit(AddNewCardSuccess());
    } catch (e) {
      emit(AddNewCardFailure(e.toString()));
    }
  }

  Future<void> fetchPaymentCards() async {
    emit(FetchingPaymentMethods());
    try {
      final paymentCards = await _checkoutServices.fetchPaymentCards(
        _authServices.getCurrentUser()!.uid,
        false,
      );
      // final chosenPaymentCard = (await _checkoutServices.fetchPaymentCards(_authServices.getCurrentUser()!.uid, true)).first; // why new request !!
      final chosenPaymentCard = paymentCards.firstWhere(
        (product) => product.isChosen == true,
        orElse: () => paymentCards.first,
      );
      selectedPaymentId = chosenPaymentCard.id;

      emit(FetchedPaymentMethods(paymentCards: paymentCards));

      if (paymentCards.isNotEmpty) {
        emit(PaymentMethodChosen(chosenPaymentMethod: chosenPaymentCard));
      }
    } catch (e) {
      FetchingPaymentMethodsFailure(e.toString());
    }
  }

  changePaymentMethod(String cardId) async {
    selectedPaymentId = cardId;
    var tempChosenPaymentMethod = await _checkoutServices.fetchPaymentCard(
      _authServices.getCurrentUser()!.uid,
      selectedPaymentId,
    );

    emit(PaymentMethodChosen(chosenPaymentMethod: tempChosenPaymentMethod));
  }

  Future<void> confirmPaymentMethod() async {
    emit(PaymentMethodConfirmLoading());

    try {
      // get the previous card and edit the isChose value to false
      final PaymentCardModel previousPaymentCard = (await _checkoutServices.fetchPaymentCards(
        _authServices.getCurrentUser()!.uid,
        true,
      )).first.copyWith(isChosen: false);

      PaymentCardModel chosenPaymentCard = await _checkoutServices.fetchPaymentCard(
        _authServices.getCurrentUser()!.uid,
        selectedPaymentId,
      );
      // set the chosen card to true
      chosenPaymentCard = chosenPaymentCard.copyWith(isChosen: true);

      await _checkoutServices.setCard(_authServices.getCurrentUser()!.uid, previousPaymentCard);
      await _checkoutServices.setCard(_authServices.getCurrentUser()!.uid, chosenPaymentCard);

      emit(PaymentMethodConfirmed(confirmedPaymentMethod: chosenPaymentCard));
    } catch (e) {
      PaymentMethodConfirmFailure(e.toString());
    }
  }

  Future<void> deletePaymentCard(String cardId) async {
    await _checkoutServices.deletePaymentCard(_authServices.getCurrentUser()!.uid, cardId);
    final paymentCards = await _checkoutServices.fetchPaymentCards(
        _authServices.getCurrentUser()!.uid,
        false,
      );
      emit(FetchedPaymentMethods(paymentCards: paymentCards));
  }
}
