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

This project follows a **BLoC (Cubit) + Clean Services Layer** architecture to separate UI, business logic, and Firebase operations.  

---

### Cubits

- **AuthCubit**  
  - Login, register, logout  
  - Update email and password  
  - Delete account  
  - Handle authentication state changes  

- **HomeCubit**  
  - Fetch products from Firestore  
  - Manage product categories  
  - Toggle favorite status on product items  

- **CartCubit**  
  - Fetch cart items from Firestore  
  - Add/remove products from cart  
  - Update item quantities  
  - Apply promo codes and recalculate totals  

- **FavoriteCubit**  
  - Manage the list of favorite products  
  - Add/remove items from favorites  
  - Sync favorites with Firestore  

- **LocationCubit**  
  - Handle user’s selected location (for delivery or region-based browsing)  
  - Update and persist location data  

---

### Services Layer

Each cubit depends on a dedicated **Service Implementation** that encapsulates Firebase logic:

- `AuthServicesImpl` → Handles Firebase Auth API calls  
- `HomeServicesImpl` → Fetches products and category data  
- `CartServicesImpl` → Cart operations and discount logic  
- `FavoriteServicesImpl` → Favorite products logic  
- `LocationServicesImpl` → Location management  
- `OrderServicesImpl` → Order placement and retrieval  

This keeps the codebase **modular, testable, and scalable**.


---

## Usage Examples

### Apply a Promo Code

```dart
cartCubit.getCartItems(promoCode: 'SAVE10');
```
```dart
cartCubit.getCartItems(promoCode: 'SAVE20');
```
```dart
cartCubit.getCartItems(promoCode: 'SAVE30');
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
