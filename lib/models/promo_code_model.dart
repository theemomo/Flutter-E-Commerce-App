class PromoCodeModel {
  final String code;
  final double discount;

  PromoCodeModel({required this.code, required this.discount});
}

final List<PromoCodeModel> promoCodes = [
  PromoCodeModel(code: 'SAVE10', discount: 0.10),
  PromoCodeModel(code: 'SAVE20', discount: 0.20),
  PromoCodeModel(code: 'SAVE30', discount: 0.30),
];