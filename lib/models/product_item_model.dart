// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

enum ProductSize {
  S,
  M,
  L,
  XL;

  static ProductSize fromString(String size) {
    switch (size.toUpperCase()) {
      case 'S':
        return ProductSize.S;
      case 'M':
        return ProductSize.M;
      case 'L':
        return ProductSize.L;
      case 'XL':
        return ProductSize.XL;
      default:
        return ProductSize.S;
    }
  }
}

class ProductItemModel {
  final String id;
  final String name;
  final String imgUrl;
  final String description;
  final double price;
  final bool isFav;
  final String category;

  ProductItemModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    this.description =
        "design suitable for daily use, whether at home, work, or on the go. Perfect choice for customers who value style, reliability, and functionality. Please note that this is only a sample description used for testing the UI layout.",
    required this.price,
    this.isFav = false,
    required this.category,
  });

  ProductItemModel copyWith({
    String? id,
    String? name,
    String? imgUrl,
    String? description,
    double? price,
    bool? isFav,
    String? category,
    int? quantity,
    ProductSize? size,
  }) {
    return ProductItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imgUrl: imgUrl ?? this.imgUrl,
      price: price ?? this.price,
      category: category ?? this.category,
      isFav: isFav ?? this.isFav
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imgUrl': imgUrl,
      'description': description,
      'price': price,
      // 'isFav': isFav,
      'category': category,
    };
  }

  

  factory ProductItemModel.fromMap(Map<String, dynamic> map) {
    double parsePrice(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

    return ProductItemModel(
      id: map['id'] as String? ?? "",
      name: map['name'] as String? ?? "",
      imgUrl: map['imgUrl'] as String? ?? "",
      description: map['description'] as String? ?? "",
      price: parsePrice(map['price']),
      // isFav: map['isFav'] as bool,
      category: map['category'] as String? ?? "",
    );
  }
}

// List<ProductItemModel> dummyProducts = [
//   ProductItemModel(
//     id: 'K434118okA3XH70vmCgk',
//     name: 'Grey Shoes',
//     imgUrl: 'https://i.pinimg.com/1200x/4c/da/13/4cda13b0453d475b9baf037b9ca21f91.jpg',
//     price: 20,
//     category: 'Shoes',
//   ),
//   ProductItemModel(
//     id: 'K434118okA3XH70vmCgI',
//     name: 'White Shoes',
//     imgUrl: 'https://i.pinimg.com/1200x/5d/7f/a2/5d7fa28a015e80531835580dd9046a6c.jpg',
//     price: 40,
//     category: 'Shoes',
//   ),
//   ProductItemModel(
//     id: 'Y4xM7ukLvqRsurgioQmN',
//     name: 'Green Back Bag',
//     imgUrl: 'https://i.pinimg.com/1200x/7e/6d/d8/7e6dd81da415599e4fc10f489ede6c7d.jpg',
//     price: 10,
//     category: 'Back Bag',
//   ),
//   ProductItemModel(
//     id: 'OHncCKAImAwC9jg9XPam',
//     name: 'Brown Hand Bag',
//     imgUrl: 'https://i.pinimg.com/1200x/87/bd/2e/87bd2ec357beb80374263240df471ba9.jpg',
//     price: 10,
//     category: 'Hand Bag',
//   ),
//   ProductItemModel(
//     id: '7WqSYwiEbed0G05zM72u',
//     name: 'Black Nike Bag',
//     imgUrl: 'https://i.pinimg.com/1200x/b3/18/3c/b3183cc9433b0e7306458591c9c13171.jpg',
//     price: 10,
//     category: 'Back Bag',
//   ),
//   ProductItemModel(
//     id: 'NQwKrejnxOFcgAzdkoQm',
//     name: 'Blue Trousers',
//     imgUrl: 'https://i.pinimg.com/1200x/b4/79/2b/b4792b7a4c09f985cb39898815961422.jpg',
//     price: 10,
//     category: 'Trousers',
//   ),
//   ProductItemModel(
//     id: 'uIVHYv1tLpiC3Jwik8b0',
//     name: 'Brown Trousers',
//     imgUrl: 'https://i.pinimg.com/1200x/99/0b/46/990b461b30b414f00625d7658e5c3935.jpg',
//     price: 10,
//     category: 'Trousers',
//   ),
//   ProductItemModel(
//     id: 'BOQKlAc0GlRZXOmzcs1l',
//     name: 'Trousers',
//     imgUrl: 'https://i.pinimg.com/1200x/40/a1/89/40a1897419238dafed9f1ede962f2701.jpg',
//     price: 10,
//     category: 'Trousers',
//   ),
//   ProductItemModel(
//     id: 'atZHZfhF5glVKKO3XCtz',
//     name: 'Baby Blue Jacket',
//     imgUrl: 'https://i.pinimg.com/1200x/d2/62/42/d26242a6b554b9a90d747228c2fc6af8.jpg',
//     price: 10,
//     category: 'Jacket',
//   ),
//   ProductItemModel(
//     id: 'jXDJxAUnBWJTXrOn5V1n',
//     name: 'Sweet Shirt',
//     imgUrl:
//         'https://www.usherbrand.com/cdn/shop/products/5uYjJeWpde9urtZyWKwFK4GHS6S3thwKRuYaMRph7bBDyqSZwZ_87x1mq24b2e7_1800x1800.png',
//     price: 15,
//     category: 'Clothes',
//   ),
//   ProductItemModel(
//     id: 'PjORGdvg4dVIxnVjjhgB',
//     name: 'T-shirt',
//     imgUrl: 'https://parspng.com/wp-content/uploads/2022/07/Tshirtpng.parspng.com_.png',
//     price: 10,
//     category: 'Clothes',
//   ),
// ];
