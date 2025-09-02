class ApiPaths {
  static String users({required String userId}) => 'users/$userId';

  static String promoCodes() => 'promoCods/';

  static String products() => 'products/';
  static String product(String productId) => 'products/$productId';

  static String cartItem(String userId, String cartItemId) => 'users/$userId/cart/$cartItemId';
  static String cartItems(String userId) => 'users/$userId/cart/';

  static String carouselItems() => 'announceements/';
  static String categories() => 'categories/';

  static String favoriteProducts(String userId) => 'users/$userId/favorites/';
  static String favoriteProduct(String userId, String favoriteItemId) => 'users/$userId/favorites/$favoriteItemId';

  static String paymentCard(String userId, paymentId) => 'users/$userId/paymentCards/$paymentId';
  static String paymentCards(String userId) => 'users/$userId/paymentCards/';

  static String locations(String userId) => 'users/$userId/addresses/';
  static String location(String userId, String locationId) => 'users/$userId/addresses/$locationId';
}