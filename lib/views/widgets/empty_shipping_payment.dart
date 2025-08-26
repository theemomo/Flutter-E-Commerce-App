import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyShippingPayment extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const EmptyShippingPayment({super.key, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.11,
        decoration: BoxDecoration(color: AppColors.grey2, borderRadius: BorderRadius.circular(12.0)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [const Icon(Icons.add), Text(title)],
          ),
        ),
      ),
    );
  }
}
