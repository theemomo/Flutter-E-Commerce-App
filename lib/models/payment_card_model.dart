// ignore_for_file: public_member_api_docs, sort_constructors_first

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

  copyWith({
    String? id,
    String? cardNumber,
    String? cardHolderName,
    String? cardExpireDate,
    String? ccvCode,
    bool? isChosen,
  }) {
    return PaymentCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardExpireDate: cardExpireDate ?? this.cardExpireDate,
      ccvCode: ccvCode ?? this.ccvCode,
      isChosen: isChosen ?? this.isChosen,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cardNumber': cardNumber,
      'cardHolderName': cardHolderName,
      'cardExpireDate': cardExpireDate,
      'ccvCode': ccvCode,
      'isChosen': isChosen,
    };
  }

  factory PaymentCardModel.fromMap(Map<String, dynamic> map) {
    return PaymentCardModel(
      id: map['id'] as String,
      cardNumber: map['cardNumber'] as String,
      cardHolderName: map['cardHolderName'] as String,
      cardExpireDate: map['cardExpireDate'] as String,
      ccvCode: map['ccvCode'] as String,
      isChosen: map['isChosen'] as bool,
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
];
