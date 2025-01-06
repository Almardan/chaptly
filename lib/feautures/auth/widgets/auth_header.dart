import 'package:flutter/material.dart';
import '../../../core/utils/pager.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool hasBackButton;
  final VoidCallback? onBackPressed;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.hasBackButton = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasBackButton)
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: onBackPressed ?? () => Pager.pop(context),
            padding: EdgeInsets.zero,
            alignment: Alignment.centerLeft,
          ),
        const SizedBox(height: 16),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}