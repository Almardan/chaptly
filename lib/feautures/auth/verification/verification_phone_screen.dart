import 'package:flutter/material.dart';
import '../../../core/widgets/custom_button.dart';
import '../widgets/auth_header.dart';
import 'widgets/verification_code_widget.dart';

class VerificationPhoneScreen extends StatelessWidget {
  final String phoneNumber;

  const VerificationPhoneScreen({
    super.key,
    required this.phoneNumber,
  });

  void _onVerificationComplete(BuildContext context, String code) {
    
    Navigator.pushNamed(context, '/verification-success');
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
                title: 'Verification Phone',
                subtitle: 'Please enter the code we just sent to phone\nnumber $phoneNumber',
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