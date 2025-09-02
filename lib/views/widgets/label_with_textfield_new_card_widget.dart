import 'package:e_commerce/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabelWithTextfieldNewCardWidget extends StatefulWidget {
  final String label;
  final String fieldLabel;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType inputType;
  final List<TextInputFormatter> inputFormatters;
  final FormFieldValidator? validator;
  const LabelWithTextfieldNewCardWidget({
    super.key,
    required this.label,
    required this.fieldLabel,
    required this.controller,
    required this.icon,
    required this.inputType,
    required this.inputFormatters,
    this.validator
  });

  @override
  State<LabelWithTextfieldNewCardWidget> createState() => _LabelWithTextfieldNewCardWidgetState();
}

class _LabelWithTextfieldNewCardWidgetState extends State<LabelWithTextfieldNewCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          TextFormField(
            keyboardType: widget.inputType,
            inputFormatters: widget.inputFormatters,
            validator: widget.validator,
            controller: widget.controller,
            decoration: InputDecoration(
              prefixIcon: Icon(widget.icon, color: AppColors.grey.withValues(alpha: 0.8)),
              fillColor: AppColors.grey.withValues(alpha: 0.1),
              filled: true,
              hintText: widget.fieldLabel,
              hintStyle: TextStyle(color: AppColors.grey.withValues(alpha: 0.8)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: const BorderSide(color: AppColors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
