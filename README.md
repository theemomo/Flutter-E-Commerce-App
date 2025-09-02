# Flutter E-Commerce App

A full-featured e-commerce application built with **Flutter** and **Firebase**, featuring secure user authentication, product browsing, shopping cart management, favorites, discount codes, and order management.

---

## Table of Contents

- [Features](#features)  
- [Getting Started](#getting-started)  
- [Dependencies](#dependencies)  
- [Architecture & State Management](#architecture--state-management)  
- [Usage Examples](#usage-examples)  
- [Contributing](#contributing)  
- [License](#license)

---

## Features

- **Authentication**: Email/Password, Facebook, and optionally Google  
- **Product Catalog**: Browse products by category, view details, and add to cart or favorites  
- **Favorites & Cart**: Add/remove items, update quantities, and view subtotal with discount support  
- **Discount Codes**: Apply promo codes with real-time discount calculations  
- **User Management**: Update password or email, and delete account  
- **UI Components**: Carousel, grid product layouts, and responsive dialogs  
- **Persistent Data**: Firebase Authentication for auth; Firestore for products, favorites, cart, and user data  

---

## Getting Started

### 1. Clone the repository

```bash
git clone https://github.com/theemomo/Flutter-E-Commerce-App.git
cd Flutter-E-Commerce-App
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Firebase setup

- Create a Firebase project.  
- Enable **Authentication** (Email/Password, Facebook, Google if needed).  
- Add Android/iOS apps and replace `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).  
- Enable **Firestore** and create collections:  
  - `products`  
  - `favorites`  
  - `cart`  
  - `users`  

### 4. Run the application

```bash
flutter run
```

---

## Dependencies

Key packages used in this project:

- `flutter_bloc` — State management with Cubit/BLoC  
- `firebase_auth`, `cloud_firestore` — Firebase backend integration  
- `flutter_carousel_widget`, `cached_network_image` — Carousel and image handling  
- `equatable`, `fluttertoast`, and other UI/utility packages as needed  

---

## Architecture & State Management

This project follows a **BLoC (Cubit) + Services Layer** architecture.

- **Cubits**
  - `AuthCubit`: Login, sign-up, logout, update password/email, delete account  
  - `HomeCubit`: Fetch products and manage favorites  
  - `CartCubit`: Manage cart items, quantities, and promo codes  
  - `FavoriteCubit`: Handle favorite products list  
  - `LocationCubit`: Manage user’s location  

- **Services Layer**
  - `AuthServicesImpl`: Encapsulates Firebase Auth operations  
  - `HomeServicesImpl`, `FavoriteServicesImpl`, `CartServicesImpl`: Handle Firestore operations  

---

## Usage Examples

### Apply a Promo Code

```dart
cartCubit.getCartItems(promoCode: 'SAVE10');
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

```dart
if (state is UpdatePasswordSuccessfully) {
  Navigator.pushNamedAndRemoveUntil(context, AppRoutes.loginRoute, (r) => false);
}
```

---

## Contributing

Contributions are welcome!  
- Submit pull requests for bug fixes, features, or documentation.  
- For major changes, please open an issue first to discuss what you’d like to change.  

---

## License

This project is distributed under the **MIT License**.  
See the `LICENSE` file for details.  

---

⭐ If you find this project useful, please star the repository!
