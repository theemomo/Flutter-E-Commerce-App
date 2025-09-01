import 'package:e_commerce/models/add_to_cart_model.dart';
import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utils/api_paths.dart';

abstract class CartServices {
  Future<List<AddToCartModel>> fetchCartItems();
  Future<void> setCartItem(AddToCartModel cartItem);
}

class CartServicesImpl implements CartServices {
  final _firestoreServices = FirestoreServices.instance;
  final _authServices = AuthServicesImpl();

  @override
  Future<List<AddToCartModel>> fetchCartItems() async {
    final result = await _firestoreServices.getCollection(
      path: ApiPaths.cartItems(_authServices.getCurrentUser()!.uid),
      builder: (data, documentId) => AddToCartModel.fromMap(data),
    );
    return result;
  }
  
  @override
  Future<void> setCartItem(AddToCartModel cartItem) async {
    await _firestoreServices.setData(path: ApiPaths.cartItem(_authServices.getCurrentUser()!.uid, cartItem.id), data: cartItem.toMap());
  }
}
