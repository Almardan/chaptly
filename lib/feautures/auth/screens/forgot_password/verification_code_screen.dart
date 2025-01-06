import 'package:flutter/material.dart';
import '../../../../core/utils/pager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../widgets/auth_header.dart';
import 'new_password_screen.dart';
import 'widgets/verification_code_input.dart';

class VerificationCodeScreen extends StatelessWidget {
  final String contact;
  final bool isEmail;
  final String otp;

  const VerificationCodeScreen({
    super.key,
    required this.contact,
    required this.isEmail,
    required this.otp,
  });

  void _handleVerification(BuildContext context, String code) {
    if (code == otp) {
      Pager.push(context, const NewPasswordScreen());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid verification code'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _handleResend() {
    
    print('Resending OTP: $otp');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 
                   MediaQuery.of(context).padding.top - 
                   MediaQuery.of(context).padding.bottom,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  AuthHeader(
                    title: 'Verification Code',
                    subtitle: 'Please enter the code we just sent to ${isEmail ? 'email' : 'phone number'}\n$contact',
                    hasBackButton: true,
                  ),
                  const Spacer(),
                  VerificationCodeInput(
                    onCompleted: (code) => _handleVerification(context, code),
                    onResendCode: _handleResend,
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Continue',
                    onPressed: () => _handleVerification(context, ''),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,  
    );
  }
}