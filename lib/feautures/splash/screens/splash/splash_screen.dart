import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/pager.dart';
import '../../../auth/providers/app_provider.dart';
import '../../../auth/signin/signin_screen.dart';
import '../../../onboarding/screens/onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    _navigateNext();
  }

  Future<void> _navigateNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      final hasSeenOnboarding = context.read<AppProvider>().hasSeenOnboarding;
      if (hasSeenOnboarding) {
        Pager.pushReplacement(context, const SignInScreen());
      } else {
        Pager.pushReplacement(context, const OnboardingScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Image.asset(
          'assets/png/splash.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}