import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/models/product_item_model.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utils/api_paths.dart';

abstract class ProductDetailsServices {
  Future<ProductItemModel> fetchProductDetails(String productId);
  Future<void> addToCart(AddToCartModel cartItem, String userId);
}

class ProductDetailsServicesImpl implements ProductDetailsServices {
  final FirestoreServices _firestoreServices = FirestoreServices.instance;
  @override
  Future<ProductItemModel> fetchProductDetails(String productId) async {
    final ProductItemModel selectedProduct = await _firestoreServices.getDocument(
      path: ApiPaths.product(productId),
      builder: (data, documentId) => ProductItemModel.fromMap(data),
    );
    return selectedProduct;
  }

  @override
  Future<void> addToCart(AddToCartModel cartItem, String userId) async {
    await _firestoreServices.setData(
      path: ApiPaths.cartItem(userId, cartItem.id),
      data: cartItem.toMap(),
    );
  }
}
