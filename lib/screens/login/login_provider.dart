// lib/screens/login/login_provider.dart
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';

class LoginProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isLoading = false;
  bool _isPasswordHidden = true;
  bool _rememberMe = false;
  String? _errorMessage;

  // Getters
  bool get isLoading => _isLoading;

  bool get isPasswordHidden => _isPasswordHidden;

  bool get rememberMe => _rememberMe;

  String? get errorMessage => _errorMessage;

  void togglePasswordVisibility() {
    _isPasswordHidden = !_isPasswordHidden;
    notifyListeners();
  }

  void toggleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final success = await _authService.login(email, password);
      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
}
