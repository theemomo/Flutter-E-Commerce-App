import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce/models/payment_card_model.dart';
import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class PaymentMethodItem extends StatelessWidget {
  final PaymentCardModel? paymentCard;
  final VoidCallback? onItemTapped;
  const PaymentMethodItem({
    super.key,
    required this.paymentCard,
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onItemTapped,

      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColors.white,
          border: Border.all(
            color: Colors.grey.withValues(alpha: 0.5), // border color
            width: 1, // border thickness
          ),
        ),
        child: ListTile(
          leading: CachedNetworkImage(
            imageUrl: 'https://cdn-icons-png.flaticon.com/512/11378/11378185.png',
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
          title: const Text("MasterCard"),
          subtitle: Text(paymentCard!.cardNumber, style: const TextStyle(fontSize: 16)),
          trailing: const Icon(Icons.arrow_forward_ios, size: 15),
        ),
      ),
    );
  }
}
