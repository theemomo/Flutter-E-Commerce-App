import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FieldsInProfilePage extends StatelessWidget {
  final String fieldLabel;
  final IconData icon;
  final String value;
  const FieldsInProfilePage({
    super.key,
    required this.fieldLabel,
    required this.icon,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(fieldLabel, style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
          child: SizedBox(
            height: 55,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Row(
                  children: [
                    Icon(icon, size: 27.0, color: AppColors.primary),
                    const SizedBox(width: 15.0),
                    Text(
                      value,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
