part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final List<HomeCarouselItemModel> carouselItems;
  final List<ProductItemModel> arrivalProducts;

  HomeLoaded({required this.arrivalProducts, required this.carouselItems});
}

final class HomeError extends HomeState {
  final String message;

  HomeError({required this.message});
}
