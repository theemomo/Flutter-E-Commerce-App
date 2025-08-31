part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<HomeCarouselItemModel> carouselItems;
  final List<ProductItemModel> products;

  HomeLoaded({required this.products, required this.carouselItems});
}

final class HomeError extends HomeState {
  final String message;

  HomeError(this.message);
}

final class CategoryLoading extends HomeState {}

final class CategoryLoaded extends HomeState {
  final List<CategoryModel> categories;
  CategoryLoaded(this.categories);
}

final class CategoryLoadingError extends HomeState {
  final String message;
  CategoryLoadingError(this.message);
}

final class SetFavLoading extends HomeState {
  final String productId;
  SetFavLoading(this.productId);
}

final class SetFavSuccess extends HomeState {
  final bool isFavorite;
    final String productId;

  SetFavSuccess(this.isFavorite, this.productId);
}

final class SetFavError extends HomeState {
  final String message;
    final String productId;

  SetFavError(this.message, this.productId);
}
