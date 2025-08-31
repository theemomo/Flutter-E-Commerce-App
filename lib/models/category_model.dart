// ignore_for_file: public_member_api_docs, sort_constructors_first

class CategoryModel {
  final String id;
  final String name;
  final int productsCount;
  final String imageUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.productsCount,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'productsCount': productsCount,
      'imageUrl': imageUrl,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] as String,
      name: map['name'] as String,
      productsCount: map['productsCount'] as int,
      imageUrl: map['imageUrl'] as String,
    );
  }

}

List<CategoryModel> dummyCategories = [
  CategoryModel(
    id: '1',
    name: 'New Arrivals',
    productsCount: 208,

    imageUrl: "https://i.pinimg.com/1200x/6b/19/c2/6b19c26e4cd2ec49bca3676fa4302fc9.jpg",
  ),
  CategoryModel(
    id: '2',
    name: 'Jackets',
    productsCount: 358,

    imageUrl: "https://i.pinimg.com/1200x/a3/76/de/a376de194ba4cf33bbdf8a4fee6da081.jpg",
  ),
  CategoryModel(
    id: '3',
    name: 'Bags',
    productsCount: 160,
    imageUrl: "https://i.pinimg.com/736x/07/72/af/0772afce799e383fe3c8b4797f50874e.jpg",
  ),
  CategoryModel(
    id: '4',
    name: 'Shoes',
    productsCount: 230,
    imageUrl: "https://i.pinimg.com/736x/b1/f6/e3/b1f6e330cf2a967c8b9be1161d735913.jpg",
  ),
  CategoryModel(
    id: '5',
    name: 'Trousers',
    productsCount: 101,
    imageUrl: "https://i.pinimg.com/736x/e4/cd/97/e4cd978e4934173ee900b246c975d614.jpg",
  ),
];
