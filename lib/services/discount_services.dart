import 'package:e_commerce/models/promo_code_model.dart';
// import 'package:e_commerce/services/auth_services.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utils/api_paths.dart';

abstract class DiscountServices {
  Future<List<PromoCodeModel>> fetchPromoCodes();
}

class DiscountServicesImpl implements DiscountServices {
  final _firestoreServices = FirestoreServices.instance;
  // final _authServices = AuthServicesImpl();
  @override
  Future<List<PromoCodeModel>> fetchPromoCodes() async {
    final result = await _firestoreServices.getCollection(
      path: ApiPaths.promoCodes(),
      builder: (data, documentId) => PromoCodeModel.fromMap(data),
    );
    return result;
  }
}
