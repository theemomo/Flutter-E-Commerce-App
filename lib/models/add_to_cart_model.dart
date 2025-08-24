import 'package:e_commerce/models/product_item_model.dart';

class AddToCartModel {
  final String id;
  final ProductItemModel product;
  final ProductSize size;
  final int quantity;

  const AddToCartModel({
    required this.id,
    required this.product,
    required this.size,
    required this.quantity,
  });

  AddToCartModel copyWith({
    String? id,
    ProductItemModel? product,
    ProductSize? size,
    int? quantity,
  }) {
    return AddToCartModel(
      id: id ?? this.id,
      product: product ?? this.product,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
    );
  }
}

List<AddToCartModel> dummyCart = [];
