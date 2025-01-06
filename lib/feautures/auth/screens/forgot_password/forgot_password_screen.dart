import 'package:flutter/material.dart';
import '../../../../core/utils/pager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../widgets/auth_header.dart';
import 'reset_password_screen.dart';
import 'widgets/forgot_password_option_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  void _handleEmailOption(BuildContext context) {
    Pager.push(context, const ResetPasswordScreen(isEmail: true));
  }

  void _handlePhoneOption(BuildContext context) {
    Pager.push(context, const ResetPasswordScreen(isEmail: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AuthHeader(
                title: 'Forgot Password',
                subtitle: 'Select which contact details should we use to\nreset your password',
                hasBackButton: true,
              ),
              const SizedBox(height: 32),
              ForgotPasswordOptionWidget(
                icon: Icons.email_outlined,
                title: 'Email',
                subtitle: 'Send to your email',
                onTap: () => _handleEmailOption(context),
              ),
              const SizedBox(height: 16),
              ForgotPasswordOptionWidget(
                icon: Icons.phone_outlined,
                title: 'Phone Number',
                subtitle: 'Send to your phone',
                onTap: () => _handlePhoneOption(context),
              ),
              const Spacer(),
              CustomButton(
                text: 'Continue',
                onPressed: () => _handleEmailOption(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}