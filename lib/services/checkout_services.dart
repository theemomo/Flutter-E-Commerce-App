import 'package:e_commerce/models/payment_card_model.dart';
import 'package:e_commerce/services/firestore_services.dart';
import 'package:e_commerce/utils/api_paths.dart';

abstract class CheckoutServices {
  Future<void> setCard(String userId, PaymentCardModel paymentCard);
  Future<PaymentCardModel> fetchPaymentCard(String userId, String cardId);
  Future<List<PaymentCardModel>> fetchPaymentCards(String userId, bool chosen);
  Future<void> deletePaymentCard(String userId, String cardId);
}

class CheckoutServicesImpl implements CheckoutServices {
  final _firestoreServices = FirestoreServices.instance;

  @override
  Future<void> setCard(String userId, PaymentCardModel paymentCard) async {
    await _firestoreServices.setData(
      path: ApiPaths.paymentCard(userId, paymentCard.id),
      data: paymentCard.toMap(),
    );
  }

  @override
  Future<List<PaymentCardModel>> fetchPaymentCards(String userId, bool chosen) async {
    final List<PaymentCardModel> result = await _firestoreServices.getCollection(
      path: ApiPaths.paymentCards(userId),
      builder: (data, documentId) => PaymentCardModel.fromMap(data),
      queryBuilder: chosen ? (query) => query.where("isChosen", isEqualTo: true) : null,
    );
    return result;
  }

  @override
  Future<PaymentCardModel> fetchPaymentCard(String userId, String cardId) async {
    final result = await _firestoreServices.getDocument(
      path: ApiPaths.paymentCard(userId, cardId),
      builder: (data, documentId) => PaymentCardModel.fromMap(data),
    );
    return result;
  }

  @override
  Future<void> deletePaymentCard(String userId, String cardId) async {
    await _firestoreServices.deleteData(path: ApiPaths.paymentCard(userId, cardId));
  }
}
