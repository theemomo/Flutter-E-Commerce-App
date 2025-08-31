import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/home_carousel_item_model.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utils/api_paths.dart';

abstract class HomeServices {
  Future<List<ProductItemModel>> fetchProducts();
  Future<List<HomeCarouselItemModel>> fetchCarouselItems();
  Future<List<CategoryModel>> fetchCategories();

}

class HomeServicesImpl implements HomeServices {
  final FirestoreServices _firestoreServices = FirestoreServices.instance;
  @override
  Future<List<ProductItemModel>> fetchProducts() async {
    final result = await _firestoreServices.getCollection<ProductItemModel>(
      path: ApiPaths.products(),
      builder: (data, documentId) => ProductItemModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<List<HomeCarouselItemModel>> fetchCarouselItems() async {
    final result = await _firestoreServices.getCollection(
      path: ApiPaths.carouselItems(),
      builder: (data, documentId) => HomeCarouselItemModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final result = await _firestoreServices.getCollection(
      path: ApiPaths.categories(),
      builder: (data, documentId) => CategoryModel.fromMap(data),
    );
    return result;
  }


}
