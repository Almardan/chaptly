import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/pager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../signin/signin_screen.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  void _handleLogin(BuildContext context) {
    
    Pager.pushAndRemoveUntil(context, const SignInScreen());
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
                'Password Changed!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Password changed successfully, you can\nlogin again with a new password!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 48),
              CustomButton(
                text: 'Login',
                onPressed: () => _handleLogin(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}