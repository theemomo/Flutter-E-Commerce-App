class PaymentCardModel {
  final String id;
  final String cardNumber;
  final String cardHolderName;
  final String cardExpireDate;
  final String ccvCode;
  final bool isChosen;

  PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.cardExpireDate,
    required this.ccvCode,
    this.isChosen = false,
  });

  copyWith(
    {
      String? id,
      String? cardNumber,
      String? cardHolderName,
      String? cardExpireDate,
      String? ccvCode,
      bool? isChosen,
    }
  ) {
    return PaymentCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardExpireDate: cardExpireDate ?? this.cardExpireDate,
      ccvCode: ccvCode ?? this.ccvCode,
      isChosen: isChosen ?? this.isChosen,
    );
  }
}

List<PaymentCardModel> dummyPaymentCards = [
  PaymentCardModel(
    id: '1',
    cardNumber: '**** **** **** 1234',
    cardHolderName: 'Mohammad Moustafa',
    cardExpireDate: '12/04',
    ccvCode: '123',
  ),
  PaymentCardModel(
    id: '2',
    cardNumber: '**** **** **** 5678',
    cardHolderName: 'Hajer Alsayed',
    cardExpireDate: '04/04',
    ccvCode: '456',
  ),
  PaymentCardModel(
    id: '3',
    cardNumber: '**** **** **** 1234',
    cardHolderName: 'John Doe',
    cardExpireDate: '12/25',
    ccvCode: '123',
  ),
  PaymentCardModel(
    id: '4',
    cardNumber: '**** **** **** 5678',
    cardHolderName: 'Jane Smith',
    cardExpireDate: '11/24',
    ccvCode: '456',
  ),
  PaymentCardModel(
    id: '5',
    cardNumber: '**** **** **** 5678',
    cardHolderName: 'Jane Smith',
    cardExpireDate: '11/24',
    ccvCode: '456',
  ),
];
