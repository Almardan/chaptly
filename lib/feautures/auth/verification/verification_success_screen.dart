import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/utils/pager.dart';
import '../../navigation/screens/main_navigation_screen.dart';

class VerificationSuccessScreen extends StatelessWidget {
  const VerificationSuccessScreen({super.key});

  void _handleGetStarted(BuildContext context) {
    Pager.pushAndRemoveUntil(context, const MainNavigationScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const Icon(
                Icons.celebration_outlined,
                size: 120,
                color: AppColors.primary,
              ),
              const SizedBox(height: 32),
              const Text(
                'Congratulation!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'your account is complete, please enjoy the\nbest books from us.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 48),
              CustomButton(
                text: 'Get Started',
                onPressed: () => _handleGetStarted(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}