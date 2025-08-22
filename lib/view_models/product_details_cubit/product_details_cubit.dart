import 'package:e_commerce/models/product_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsInitial());

  void getProductDetailsPage(String id) {
    emit(ProductDetailsLoading());

    Future.delayed(Duration(seconds: 1), () {
      final selectedProduct = dummyProducts.firstWhere((item) => item.id == id);
      emit(ProductDetailsLoaded(product: selectedProduct));
    });
  }

  void incrementCounter(String productId) {
    final int selectedIndex = dummyProducts.indexWhere(
      (item) => item.id == productId,
    );
    dummyProducts[selectedIndex] = dummyProducts[selectedIndex].copyWith(
      quantity: dummyProducts[selectedIndex].quantity + 1,
    );
    emit(QuantityCounterLoaded(value: dummyProducts[selectedIndex].quantity));
  }
  void decrementCounter(String productId) {
    final int selectedIndex = dummyProducts.indexWhere(
      (item) => item.id == productId,
    );
    dummyProducts[selectedIndex] = dummyProducts[selectedIndex].copyWith(
      quantity: dummyProducts[selectedIndex].quantity - 1,
    );
    emit(QuantityCounterLoaded(value: dummyProducts[selectedIndex].quantity));
  }
}
