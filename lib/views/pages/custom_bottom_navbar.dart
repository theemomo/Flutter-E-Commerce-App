import 'package:e_commerce/views/pages/cart_page.dart';
import 'package:e_commerce/views/pages/favorites_page.dart';
import 'package:e_commerce/views/pages/home_page.dart';
import 'package:e_commerce/views/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: HomePage(),
          item: ItemConfig(
            icon: Icon(CupertinoIcons.house_fill),
            inactiveIcon: Icon(CupertinoIcons.home),
            title: "Home",
            activeForegroundColor: Theme.of(context).primaryColor
          ),
        ),
        PersistentTabConfig(
          screen: CartPage(),
          item: ItemConfig(
            icon: Icon(CupertinoIcons.cube_box_fill),
            inactiveIcon:Icon(CupertinoIcons.cube_box),
            title: "Orders",
            activeForegroundColor: Theme.of(context).primaryColor
          ),
        ),
        PersistentTabConfig(
          screen: FavoritesPage(),
          item: ItemConfig(
            icon: Icon(CupertinoIcons.heart_fill),
            inactiveIcon: Icon(CupertinoIcons.heart),
            title: "Favorite",
            activeForegroundColor: Theme.of(context).primaryColor
          ),
        ),
        PersistentTabConfig(
          screen: ProfilePage(),
          item: ItemConfig(
            icon: Icon(CupertinoIcons.person_fill),
            inactiveIcon: Icon(CupertinoIcons.person),
            title: "Profile",
            activeForegroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) =>
          Style1BottomNavBar(navBarConfig: navBarConfig),
    );
  }
}
