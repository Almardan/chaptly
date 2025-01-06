import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppProvider extends ChangeNotifier {
  static const String _settingsBoxName = 'settingsBox';
  bool _hasSeenOnboarding = false;

  bool get hasSeenOnboarding => _hasSeenOnboarding;

  Future<void> init() async {
    final box = await Hive.openBox(_settingsBoxName);
    _hasSeenOnboarding = box.get('has_seen_onboarding', defaultValue: false);
    notifyListeners();
  }

  Future<void> setOnboardingComplete() async {
    final box = await Hive.openBox(_settingsBoxName);
    await box.put('has_seen_onboarding', true);
    _hasSeenOnboarding = true;
    notifyListeners();
  }
}