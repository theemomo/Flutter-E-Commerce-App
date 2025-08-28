import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:e_commerce/views/pages/settings_page.dart';
import 'package:e_commerce/views/widgets/fields_in_profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                // Navigator.of(context).pushNamed(AppRoutes.settingsRoute);
                pushScreen(
                  context,
                  screen: const SettingsPage(), 
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                radius: 60,
                backgroundImage: CachedNetworkImageProvider(
                  "https://cdn-icons-png.flaticon.com/512/9408/9408175.png",
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            const FieldsInProfilePage(
              fieldLabel: "Username",
              icon: CupertinoIcons.person,
              value: "Mohammad Moustafa",
            ),
            const SizedBox(height: 25.0),
            const FieldsInProfilePage(
              fieldLabel: "Email or Phone Number",
              icon: Icons.email_outlined,
              value: "mohammad@example.com",
            ),
            const SizedBox(height: 25.0),
            const FieldsInProfilePage(
              fieldLabel: "Account Linked With",
              icon: Icons.facebook,
              value: "Facebook",
            ),
            const SizedBox(height: 25.0),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text("Privacy Policy", style: TextStyle(color: AppColors.grey)),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Terms of Service", style: TextStyle(color: AppColors.grey)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
