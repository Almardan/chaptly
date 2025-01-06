import 'package:flutter/material.dart';
import '../../../../core/utils/otp_util.dart';
import '../../../../core/utils/pager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../widgets/auth_header.dart';
import 'verification_code_screen.dart';

class ResetPasswordScreen extends StatefulWidget {
  final bool isEmail;

  const ResetPasswordScreen({
    super.key,
    required this.isEmail,
  });

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  void _handleSend() {
    if (_formKey.currentState?.validate() ?? false) {
      final otp = OTPUtil.generateOTP();
      print('Generated OTP: $otp'); // For testing purposes

      Pager.push(
        context,
        VerificationCodeScreen(
          contact: _controller.text,
          isEmail: widget.isEmail,
          otp: otp,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthHeader(
                  title: 'Reset Password',
                  subtitle: widget.isEmail
                      ? 'Please enter your email, we will send\nverification code to your email'
                      : 'Please enter your phone number, we will send\na verification code to your phone number',
                  hasBackButton: true,
                ),
                const SizedBox(height: 32),
                CustomTextField(
                  label: widget.isEmail ? 'Email' : 'Phone Number',
                  controller: _controller,
                  keyboardType: widget.isEmail
                      ? TextInputType.emailAddress
                      : TextInputType.phone,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'This field is required';
                    }
                    if (widget.isEmail) {
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value!)) {
                        return 'Please enter a valid email';
                      }
                    } else {
                      if (!RegExp(r'^\+?[\d\s-]+$').hasMatch(value!)) {
                        return 'Please enter a valid phone number';
                      }
                    }
                    return null;
                  },
                  prefixIcon: widget.isEmail ? null : const Icon(Icons.phone),
                ),
                const Spacer(),
                CustomButton(
                  text: 'Send',
                  onPressed: _handleSend,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}