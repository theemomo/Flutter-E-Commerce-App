// ignore_for_file: public_member_api_docs, sort_constructors_first

class PromoCodeModel {
  final String code;
  final double discount;

  PromoCodeModel({required this.code, required this.discount});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'code': code, 'discount': discount};
  }

  factory PromoCodeModel.fromMap(Map<String, dynamic> map) {
    return PromoCodeModel(
      code: map['code'] as String? ?? "",
      discount: map['discount'] as double? ?? 0.0,
    );
  }
}

final List<PromoCodeModel> dummyPromoCodes = [
  PromoCodeModel(code: 'SAVE10', discount: 0.10),
  PromoCodeModel(code: 'SAVE20', discount: 0.20),
  PromoCodeModel(code: 'SAVE30', discount: 0.30),
];
