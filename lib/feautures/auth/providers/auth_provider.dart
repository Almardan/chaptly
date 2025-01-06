import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  static const String _userBoxName = 'userBox';
  UserModel? _currentUser;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  Future<void> init() async {
    await Hive.openBox(_userBoxName);
    await _loadUser();
  }

  Future<void> _loadUser() async {
    final box = await Hive.openBox(_userBoxName);
    final userData = box.get('current_user');
    if (userData != null) {
      _currentUser = UserModel.fromMap(Map<String, dynamic>.from(userData));
      notifyListeners();
    }
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    try {
      print('Starting sign in process...');
      final box = await Hive.openBox(_userBoxName);
      
      
      print('Box keys: ${box.keys.toList()}');
      
      
      final userData = box.get('registered_user');
      print('Found user data: $userData');

      if (userData != null) {
        final user = UserModel.fromMap(Map<String, dynamic>.from(userData));
        print('Comparing emails:');
        print('Stored email: ${user.email}');
        print('Entered email: $email');
        
        if (user.email.trim().toLowerCase() == email.trim().toLowerCase()) {
          _currentUser = user;
          await box.put('current_user', user.toMap());
          notifyListeners();
          print('Sign in successful!');
          return true;
        }
      }
      
      print('Sign in failed - no matching user found');
      return false;
    } catch (e) {
      print('Error during sign in: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    _setLoading(true);
    try {
      print('Creating new user with email: $email');
      
      final user = UserModel(
        id: DateTime.now().toString(),
        name: name,
        email: email.trim().toLowerCase(),
        phoneNumber: '',
      );
      
      final box = await Hive.openBox(_userBoxName);
      
      
      await box.put('registered_user', user.toMap());
      await box.put('current_user', user.toMap());
      
      
      final savedData = box.get('registered_user');
      print('Saved user data: $savedData');
      print('Box keys after save: ${box.keys.toList()}');
      
      _currentUser = user;
      notifyListeners();
      print('User registration completed successfully');
    } catch (e) {
      print('Error during registration: $e');
      rethrow;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      final box = await Hive.openBox(_userBoxName);
      await box.delete('current_user');
      _currentUser = null;
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}