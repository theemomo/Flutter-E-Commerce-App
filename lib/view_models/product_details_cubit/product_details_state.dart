part of 'product_details_cubit.dart';

// ! product details states
sealed class ProductDetailsState {}

final class ProductDetailsInitial extends ProductDetailsState {}

final class ProductDetailsLoading extends ProductDetailsState {}

final class ProductDetailsLoaded extends ProductDetailsState {
  final ProductItemModel product;
  ProductDetailsLoaded({required this.product});
}

final class ProductDetailsError extends ProductDetailsState {
  final String message;
  ProductDetailsError({required this.message});
}

// ! counter section

final class QuantityCounterLoaded extends ProductDetailsState {
  final int value;
  QuantityCounterLoaded({required this.value});
}

// ! size section

final class SizeSelected extends ProductDetailsState {
  final ProductSize size;
  SizeSelected({required this.size});
}

// ! adding to cart button section

final class ProductAddingToCart extends ProductDetailsState {}

final class ProductAddedToCart extends ProductDetailsState {
  final String id;
  ProductAddedToCart({required this.id});
}
  