import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  final VoidCallback onItemTapped;
  final String image;
  final String title;
  final String subTitle;

  const SettingsWidget({
    super.key,
    required this.image,
    required this.onItemTapped,
    required this.subTitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemTapped,

      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: image,
          width: 40,
          fit: BoxFit.contain,
          color: const Color.fromARGB(255, 105, 105, 105),
        ),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(
          subTitle,
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(fontSize: 16, color: AppColors.grey),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
    );
  }
}
