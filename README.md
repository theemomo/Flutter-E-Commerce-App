
````markdown
# Flutter E-Commerce App

A full-featured e-commerce application built with Flutter and Firebase, featuring secure user authentication, product browsing, shopping cart management, favorites, and order capabilities.

---

##  Table of Contents

- [Features](#features)  
- [Screenshots](#screenshots)  
- [Getting Started](#getting-started)  
- [Dependencies](#dependencies)  
- [Architecture & State Management](#architecture--state-management)  
- [Usage](#usage)  
- [Contributing](#contributing)  
- [License](#license)

---

##  Features

- **Authentication**: Email/password, Facebook (and optionally Google)
- **Product Catalog**: View products by category, see details, and add to cart or favorites
- **Favorites & Cart**: Add/remove items, update quantities, and view subtotal with discount support
- **Discount Codes**: Apply promo codes for real-time discount calculations
- **User Management**: Update password or email, delete account
- **UI Components**: Carousel, grid product layouts, responsive dialogs
- **Persistent Data**: Firebase Authentication for auth; Firestore for products, favorites, cart, and user data

---

##  Screenshots

*(Add your app screenshots here)*

- Home Screen (Browse products, favorites)
- Product Detail Screen
- Cart & Checkout View
- Settings & Authentication Flow

---

##  Getting Started

1. **Clone the repository**
   ```bash
   git clone https://github.com/theemomo/Flutter-E-Commerce-App.git
   cd Flutter-E-Commerce-App
````

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Firebase Setup**

   * Create a Firebase project
   * Enable Authentication (Email/Password, Facebook, Google if used)
   * Add Android/iOS app and replace `google-services.json` / `GoogleService-Info.plist`
   * Enable Firestore and structure collections for `products`, `favorites`, `cart`, `users`, etc.

4. **Run the application**

   ```bash
   flutter run
   ```

---

## Dependencies

Key packages used in this project include:

* `flutter_bloc` — State management with Cubit/BLoC
* `firebase_auth`, `cloud_firestore` — Firebase backend integration
* `flutter_carousel_widget`, `cached_network_image` — Carousel and image loading
* Additional UI packages as needed (icons, animations, etc.)

*(List more in your `pubspec.yaml`)*

---

## Architecture & State Management

* **BLoC (Cubit)** + **Clean Services Layer**

  * `AuthCubit`: Manages login, sign-up, logout, update password/email, delete account
  * `HomeCubit`: Fetch products, favorites; toggle favorite status
  * `CartCubit`: Fetch cart items, update quantities, apply promo discount
  * `FavoriteCubit`: Display favorite products list
  * `LocationCubit`: Manage user’s selected location
* **Services Layer**

  * `AuthServicesImpl`: Encapsulates Firebase calls
  * `HomeServicesImpl` / `FavoriteServicesImpl` / `CartServicesImpl`: Encapsulate Firestore operations

---

## Usage Examples

### Apply a Promo Code

```dart
cartCubit.getCartItems(promoCode: 'DISCOUNT10');
```

### Toggle Favorite Item

```dart
homeCubit.setFavorite(productItem);
```

### Update Password

```dart
authCubit.updatePassword(newPassword);
```

### Navigate After Update

Listener in `BlocConsumer` handles redirect after success:

```dart
if (state is UpdatePasswordSuccessfully) {
  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginRoute, (r) => false);
}
```

---

## Contributing

Contributions are welcome! Feel free to submit pull requests for bug fixes, enhancements, or documentation improvements. Please ensure issues are discussed before submitting major changes.

---

## License

This project is distributed under the MIT License. See `LICENSE` for more details.

---

⭐ If you find this project useful, please don’t forget to star the repository!

```


