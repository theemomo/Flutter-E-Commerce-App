import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utils/api_paths.dart';

abstract class FavoriteServices {
  Future<void> addFavorite(String userId, ProductItemModel product);
  Future<void> removeFavorite(String userId, String productId);
  Future<List<ProductItemModel>> getFavorite(String userId);
}

class FavoriteServicesImpl implements FavoriteServices {
  final _firestoreServices = FirestoreServices.instance;
  @override
  Future<void> addFavorite(String userId, ProductItemModel product) async {
    await _firestoreServices.setData(
      path: ApiPaths.favoriteProduct(userId, product.id), // <-- use product.id
      data: product.toMap(),
    );
  }

  @override
  Future<void> removeFavorite(String userId, String productId) async {
    await _firestoreServices.deleteData(path: ApiPaths.favoriteProduct(userId, productId));
  }

  @override
  Future<List<ProductItemModel>> getFavorite(String userId) async {
    final result = await _firestoreServices.getCollection(
      path: ApiPaths.favoriteProducts(userId),
      builder: (data, documentId) => ProductItemModel.fromMap(data),
    );
    return result;
  }
}
