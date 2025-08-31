part of 'favorite_cubit.dart';

sealed class FavoriteState {}

final class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<ProductItemModel> favoriteProducts;
  FavoriteLoaded(this.favoriteProducts);
}

class FavoriteLoadingError extends FavoriteState {
  final String message;
  FavoriteLoadingError(this.message);
}

class FavoriteRemoving extends FavoriteState {
  final String productId;
  FavoriteRemoving(this.productId);
}

class FavoriteRemoved extends FavoriteState {
  final String productId;
  FavoriteRemoved(this.productId);
}

class FavoriteRemovingError extends FavoriteState {
  final String message;
  FavoriteRemovingError(this.message);
}
