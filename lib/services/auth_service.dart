// lib/services/auth_service.dart
import '../core/constants.dart';

class AuthService {
  // Singleton pattern - đơn giản cho dự án nhỏ
  static final AuthService _instance = AuthService._internal();

  factory AuthService() => _instance;

  AuthService._internal();

  // Simulate user data storage
  String? _currentUserEmail;

  bool get isLoggedIn => _currentUserEmail != null;

  String? get currentUser => _currentUserEmail;

  Future<bool> login(String email, String password) async {
    try {
      // Simulate API delay
      await Future.delayed(Duration(seconds: 2));

      // Simple validation (replace with real API)
      if (email.isNotEmpty && password.length >= 6) {
        _currentUserEmail = email;
        return true;
      }

      throw Exception(AppConstants.loginFailed);
    } catch (e) {
      throw Exception(e.toString().replaceAll('Exception: ', ''));
    }
  }

  void logout() {
    _currentUserEmail = null;
  }
}
