import 'package:flutter/material.dart';

class CheckoutHeadlines extends StatelessWidget {
  final String title;
  final int? numOfProducts;
  final VoidCallback? onTap;
  const CheckoutHeadlines({super.key, required this.title, this.numOfProducts, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w500)),
              if (numOfProducts != null) Text("($numOfProducts)", style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey)),
            ],
          ),
          if (onTap != null)
            TextButton(
              onPressed: onTap,
              child: Text("Edit", style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}
