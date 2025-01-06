import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/pager.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../providers/auth_provider.dart';
import '../../verification/verification_success_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  // ignore: unused_field
  final bool _isPasswordVisible = false;
  bool _isPasswordValid = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onPasswordChanged(String value) {
    setState(() {
      _isPasswordValid = value.length >= 8 &&
          value.contains(RegExp(r'[0-9]')) &&
          value.contains(RegExp(r'[A-Za-z]'));
    });
  }

  Future<void> _handleSignUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        print('Starting signup process...');
        print('Name: ${_nameController.text}');
        print('Email: ${_emailController.text}');
        
        await context.read<AuthProvider>().signUp(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );

        if (mounted) {
          print('Signup successful, navigating to success screen');
          Pager.pushReplacement(context, const VerificationSuccessScreen());
        }
      } catch (e) {
        print('Error during signup: $e');
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error signing up: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Create account and choose favorite menu',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              CustomTextField(
                label: 'Name',
                hint: 'Your name',
                controller: _nameController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                hint: 'Your email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                hint: 'Your password',
                isPassword: true,
                controller: _passwordController,
                onChanged: _onPasswordChanged,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter your password';
                  }
                  if (!_isPasswordValid) {
                    return 'Password must be at least 8 characters with numbers and letters';
                  }
                  return null;
                },
              ),
              if (_passwordController.text.isNotEmpty) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      _passwordController.text.length >= 8
                          ? Icons.check_circle
                          : Icons.cancel,
                      size: 16,
                      color: _passwordController.text.length >= 8
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    const Text('Minimum 8 characters',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      RegExp(r'[0-9]').hasMatch(_passwordController.text)
                          ? Icons.check_circle
                          : Icons.cancel,
                      size: 16,
                      color: RegExp(r'[0-9]').hasMatch(_passwordController.text)
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    const Text('At least 1 number (1-9)',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      RegExp(r'[A-Za-z]').hasMatch(_passwordController.text)
                          ? Icons.check_circle
                          : Icons.cancel,
                      size: 16,
                      color: RegExp(r'[A-Za-z]').hasMatch(_passwordController.text)
                          ? Colors.green
                          : Colors.red,
                    ),
                    const SizedBox(width: 8),
                    const Text('At least lowercase or uppercase letters',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
              const SizedBox(height: 32),
              CustomButton(
                text: 'Register',
                onPressed: _handleSignUp,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/sign-in');
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                'By clicking Register, you agree to our Terms and Data Policy.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}