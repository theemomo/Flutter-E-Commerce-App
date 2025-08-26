import 'package:e_commerce/models/payment_card_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'payment_methods_state.dart';

class PaymentMethodsCubit extends Cubit<PaymentMethodsState> {
  PaymentMethodsCubit() : super(PaymentMethodsInitial());
  String selectedPaymentId = dummyPaymentCards.first.id;

  void addNewCard({
    required String cardNumber,
    required String cardHolderName,
    required String cardExpireDate,
    required String ccvCode,
  }) {
    emit(AddNewCardLoading());
    Future.delayed(const Duration(seconds: 2), () {
      final newCard = PaymentCardModel(
        id: DateTime.now().toIso8601String(),
        cardNumber: cardNumber,
        cardHolderName: cardHolderName,
        cardExpireDate: cardExpireDate,
        ccvCode: ccvCode,
      );
      dummyPaymentCards.add(newCard);
      emit(AddNewCardSuccess());
    });
  }

  fetchPaymentMethods() {
    emit(FetchingPaymentMethods());
    Future.delayed(const Duration(seconds: 1), () {
      if (dummyPaymentCards.isNotEmpty) {
        final chosenPaymentMethod = dummyPaymentCards.firstWhere(
          (card) => card.isChosen == true,
          orElse: () => dummyPaymentCards.first,
        );
        emit(FetchedPaymentMethods(paymentCards: dummyPaymentCards));
        emit(PaymentMethodChosen(chosenPaymentMethod: chosenPaymentMethod));
      }
    });
  }

  changePaymentMethod(String cardId) {
    selectedPaymentId = cardId;
    var tempChosenPaymentMethod = dummyPaymentCards.firstWhere(
      (card) => card.id == selectedPaymentId,
    );

    emit(PaymentMethodChosen(chosenPaymentMethod: tempChosenPaymentMethod));
  }

  confirmPaymentMethod() {
    emit(PaymentMethodConfirmLoading());
    Future.delayed(const Duration(seconds: 1), () {
      var chosenPaymentMethod = dummyPaymentCards.firstWhere(
        (card) => card.id == selectedPaymentId,
      );

      var previousPaymentMethod = dummyPaymentCards.firstWhere(
        (card) => card.isChosen == true,
        orElse: () => dummyPaymentCards.first,
      );
      previousPaymentMethod = previousPaymentMethod.copyWith(isChosen: false);
      chosenPaymentMethod = chosenPaymentMethod.copyWith(isChosen: true);

      final previousIndex = dummyPaymentCards.indexWhere((card) => card.id == chosenPaymentMethod.id);
      final chosenIndex = dummyPaymentCards.indexWhere((card) => card.id == previousPaymentMethod.id);
      dummyPaymentCards[previousIndex] = previousPaymentMethod;
      dummyPaymentCards[chosenIndex] = chosenPaymentMethod;

      emit(PaymentMethodConfirmed(confirmedPaymentMethod: chosenPaymentMethod));
    });
  }
}
