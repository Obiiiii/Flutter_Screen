// lib/core/constants.dart
import 'package:flutter/material.dart';

class AppConstants {
  // Colors
  static const primaryColor = Color(0xFF3B62FF);
  static const backgroundColor = Color(0xFF141A3A);
  static const errorColor = Colors.red;
  static const successColor = Colors.green;
  static const warningColor = Colors.orange;

  // Dimensions
  static const double padding = 16.0;
  static const double paddingLarge = 24.0;
  static const double radius = 12.0;
  static const double buttonHeight = 56.0;

  // Strings
  static const loginTitle = 'ĐĂNG NHẬP';
  static const loginSubtitle = 'Vui lòng đăng nhập để tiếp tục';
  static const emailLabel = 'Email';
  static const passwordLabel = 'Mật khẩu';
  static const loginButton = 'ĐĂNG NHẬP';
  static const rememberMe = 'Ghi nhớ đăng nhập';
  static const forgotPassword = 'Quên mật khẩu?';
  static const signUpText = 'Chưa có tài khoản? Đăng ký ngay';

  // Messages
  static const loginSuccess = 'Đăng nhập thành công!';
  static const loginFailed = 'Email hoặc mật khẩu không đúng';
  static const networkError = 'Lỗi kết nối. Vui lòng thử lại';

  // Validation messages
  static const emailRequired = 'Vui lòng nhập email';
  static const emailInvalid = 'Email không hợp lệ';
  static const passwordRequired = 'Vui lòng nhập mật khẩu';
  static const passwordMinLength = 'Mật khẩu phải có ít nhất 6 ký tự';
}

// Helper functions
class AppHelpers {
  static void showSnackBar(
    BuildContext context,
    String message, {
    Color? color,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color ?? AppConstants.primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
}
