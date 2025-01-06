import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/pager.dart';
import '../../../auth/providers/app_provider.dart';
import '../../../auth/signin/signin_screen.dart';
import '../../models/onboarding_model.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _navigateToAuth() {
    // Mark onboarding as complete and go to SignInScreen
    context.read<AppProvider>().setOnboardingComplete();
    Pager.pushReplacement(context, const SignInScreen());
  }

  void _nextPage() {
    if (_currentPage < OnboardingContent.contents.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _navigateToAuth();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _navigateToAuth,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: AppColors.skipButton,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: OnboardingContent.contents.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    content: OnboardingContent.contents[index],
                  );
                },
              ),
            ),
            PageIndicator(
              currentPage: _currentPage,
              pageCount: OnboardingContent.contents.length,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _nextPage,  // Changed to use _nextPage
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonPrimary,
                    foregroundColor: AppColors.buttonText,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Text(
                    _currentPage == OnboardingContent.contents.length - 1
                        ? 'Get Started'
                        : 'Continue',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            if (_currentPage != OnboardingContent.contents.length - 1)
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: TextButton(
                  onPressed: _navigateToAuth,
                  child: Text(
                    'Sign in',
                    style: TextStyle(
                      color: AppColors.buttonPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}