class OnboardingContent {
  final String image;
  final String title;
  final String description;

  OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });

  static List<OnboardingContent> contents = [
    OnboardingContent(
      image: 'assets/png/onboarding1.png',
      title: 'Now reading books\nwill be easier',
      description: 'Discover new worlds, join a vibrant reading community. Start your reading adventure effortlessly with us.',
    ),
    OnboardingContent(
      image: 'assets/png/onboarding2.png',
      title: 'Your Bookish Soulmate\nAwaits',
      description: 'Let us be your guide to the perfect read. Discover books tailored to your tastes for a truly rewarding experience.',
    ),
    OnboardingContent(
      image: 'assets/png/onboarding3.png',
      title: 'Start Your Adventure',
      description: 'Ready to embark on a quest for inspiration and knowledge? Your adventure begins now. Let\'s go!',
    ),
  ];
}