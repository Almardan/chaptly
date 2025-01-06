import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback? onPressed;

  const SectionHeader({
    super.key,
    required this.title,
    required this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        TextButton(
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}