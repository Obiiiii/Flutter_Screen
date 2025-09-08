// lib/core/providers/theme_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';

class ThemeProvider with ChangeNotifier {
  String _themeMode = AppConstants.systemTheme;

  ThemeProvider() {
    _loadThemePreference();
  }

  String get themeMode => _themeMode;

  Future<void> _loadThemePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _themeMode = prefs.getString(AppConstants.themeKey) ?? AppConstants.systemTheme;
      notifyListeners();
    } catch (e) {
      print('Error loading theme preference: $e');
    }
  }

  Future<void> setTheme(String themeMode) async {
    try {
      _themeMode = themeMode;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AppConstants.themeKey, themeMode);
      notifyListeners();
    } catch (e) {
      print('Error saving theme preference: $e');
    }
  }

  ThemeData getTheme(BuildContext context) {
    final brightness = AppHelpers.getCurrentBrightness(context, _themeMode);

    if (brightness == Brightness.dark) {
      return _darkTheme;
    } else {
      return _lightTheme;
    }
  }

  // Light Theme
  static final ThemeData _lightTheme = ThemeData(
    primaryColor: AppConstants.primaryColor,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppConstants.primaryColor,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppConstants.textDark),
      bodyMedium: TextStyle(color: AppConstants.textDark),
      titleLarge: TextStyle(color: AppConstants.textDark, fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radius),
        borderSide: BorderSide.none,
      ),
    ),
  );

  // Dark Theme
  static final ThemeData _darkTheme = ThemeData(
    primaryColor: AppConstants.primaryColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppConstants.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppConstants.backgroundColor,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppConstants.textPrimary),
      bodyMedium: TextStyle(color: AppConstants.textSecondary),
      titleLarge: TextStyle(color: AppConstants.textPrimary, fontWeight: FontWeight.bold),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.radius),
        borderSide: BorderSide.none,
      ),
    ),
  );
}