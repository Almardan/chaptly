import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';
import '../widgets/auth_header.dart';
import 'widgets/verification_code_widget.dart';

class VerificationEmailScreen extends StatelessWidget {
  final String email;

  const VerificationEmailScreen({
    super.key,
    required this.email,
  });

  void _onVerificationComplete(BuildContext context, String code) {
    
    Navigator.pushNamed(context, '/verification-phone');
  }

  void _resendCode() {
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              AuthHeader(
                title: 'Verification Email',
                subtitle: 'Please enter the code we just sent to email\n$email',
                onBackPressed: () => Navigator.pop(context),
              ),
              const SizedBox(height: 48),
              VerificationCodeWidget(
                onCompleted: (code) => _onVerificationComplete(context, code),
                onResendCode: _resendCode,
              ),
              const Spacer(),
              CustomButton(
                text: 'Continue',
                onPressed: () => _onVerificationComplete(context, ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}