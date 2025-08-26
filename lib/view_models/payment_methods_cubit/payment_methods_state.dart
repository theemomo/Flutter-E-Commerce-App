part of 'payment_methods_cubit.dart';

sealed class PaymentMethodsState {}

final class PaymentMethodsInitial extends PaymentMethodsState {}

final class AddNewCardLoading extends PaymentMethodsState {}

final class AddNewCardSuccess extends PaymentMethodsState {}

final class AddNewCardFailure extends PaymentMethodsState {
  final String error;

  AddNewCardFailure(this.error);
}

final class FetchingPaymentMethods extends PaymentMethodsState {}

final class FetchedPaymentMethods extends PaymentMethodsState {
  final List<PaymentCardModel> paymentCards;

  FetchedPaymentMethods({required this.paymentCards});
}

final class FetchingPaymentMethodsFailure extends PaymentMethodsState {
  final String error;

  FetchingPaymentMethodsFailure(this.error);
}

final class PaymentMethodChosen extends PaymentMethodsState {
  final PaymentCardModel chosenPaymentMethod;

  PaymentMethodChosen({required this.chosenPaymentMethod});
}


final class PaymentMethodConfirmLoading extends PaymentMethodsState {}

final class PaymentMethodConfirmed extends PaymentMethodsState {
  final PaymentCardModel confirmedPaymentMethod;

  PaymentMethodConfirmed({required this.confirmedPaymentMethod});
}

final class PaymentMethodConfirmFailure extends PaymentMethodsState {
  final String error;

  PaymentMethodConfirmFailure(this.error);
}