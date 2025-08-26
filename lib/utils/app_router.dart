import 'package:e_commerce/views/pages/add_new_card_page.dart';
import 'package:e_commerce/views/pages/checkout_page.dart';
import 'package:e_commerce/views/pages/custom_bottom_navbar.dart';
import 'package:e_commerce/views/pages/product_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.homeRoute:
        return CupertinoPageRoute(
          builder: (_) => const CustomBottomNavbar(),
          settings: settings,
        );

      case AppRoutes.productDetailsRoute:
        final String productId = settings.arguments as String;
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => ProductDetailsPage(productId: productId),
        );
        
      case AppRoutes.checkoutRoute:
        return CupertinoPageRoute(builder: (_) => const CheckoutPage());

      case AppRoutes.addNewCardRoute:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) => const AddNewCardPage(),
        );

      default:
        return CupertinoPageRoute(
          settings: settings,
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Page Not Found"))),
        );
    }
  }
}
