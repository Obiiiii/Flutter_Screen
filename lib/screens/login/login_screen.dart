// lib/screens/login/login_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants.dart';
import '../../core/validators.dart';
import '../../core/widgets/app_scaffold.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import 'login_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _emailFocus.requestFocus();
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: AppScaffold(
        hasGradient: true,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppConstants.paddingLarge),
            child: Consumer<LoginProvider>(
              builder: (context, provider, child) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: AppHelpers.screenHeight(context) * 0.05),

                      // Header
                      _buildHeader(),
                      SizedBox(height: AppConstants.paddingLarge * 2),

                      // Form
                      _buildForm(provider),
                      SizedBox(height: AppConstants.padding),

                      // Options
                      _buildOptions(provider),
                      SizedBox(height: AppConstants.paddingLarge * 2),

                      // Login Button
                      CustomButton(
                        text: AppConstants.loginButton,
                        isLoading: provider.isLoading,
                        onPressed: () => _handleLogin(provider),
                      ),

                      // Error Message
                      if (provider.errorMessage != null) ...[
                        SizedBox(height: AppConstants.padding),
                        _buildErrorMessage(provider),
                      ],

                      SizedBox(height: AppConstants.paddingLarge),

                      // Sign Up
                      _buildSignUpOption(),

                      SizedBox(height: screenSize.height),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final logoSize = AppHelpers.screenWidth(context) * 0.25;

    return Column(
      children: [
        // Logo
        Container(
          width: logoSize,
          height: logoSize,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            Icons.lock_rounded,
            size: logoSize * 0.5,
            color: AppConstants.primaryColor,
          ),
        ),

        SizedBox(height: AppConstants.paddingLarge),

        Text(
          AppConstants.loginTitle,
          style: TextStyle(
            fontSize: AppHelpers.screenWidth(context) * 0.07,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        SizedBox(height: AppConstants.padding / 2),

        Text(
          AppConstants.loginSubtitle,
          style: TextStyle(
            fontSize: AppHelpers.screenWidth(context) * 0.04,
            color: Colors.white70,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildForm(LoginProvider provider) {
    return Column(
      children: [
        CustomTextField(
          label: AppConstants.emailLabel,
          controller: _emailController,
          focusNode: _emailFocus,
          prefixIcon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          validator: Validators.email,
          onFieldSubmitted: (_) => _passwordFocus.requestFocus(),
        ),

        SizedBox(height: AppConstants.padding),

        CustomTextField(
          label: AppConstants.passwordLabel,
          controller: _passwordController,
          focusNode: _passwordFocus,
          prefixIcon: Icons.lock,
          obscureText: provider.isPasswordHidden,
          textInputAction: TextInputAction.done,
          validator: Validators.password,
          onFieldSubmitted: (_) => _handleLogin(provider),
          suffixIcon: IconButton(
            icon: Icon(
              provider.isPasswordHidden
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: Colors.white70,
            ),
            onPressed: provider.togglePasswordVisibility,
          ),
        ),
      ],
    );
  }

  Widget _buildOptions(LoginProvider provider) {
    return Row(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: provider.rememberMe,
              onChanged: (value) => provider.toggleRememberMe(value ?? false),
              fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                return states.contains(MaterialState.selected)
                    ? Colors.white
                    : Colors.transparent;
              }),
              checkColor: AppConstants.primaryColor,
            ),
            Text(
              AppConstants.rememberMe,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),

        Spacer(),

        TextButton(
          onPressed: () {
            AppHelpers.showSnackBar(
              context,
              'Chức năng quên mật khẩu sẽ được triển khai',
            );
          },
          child: Text(
            AppConstants.forgotPassword,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorMessage(LoginProvider provider) {
    return Container(
      padding: EdgeInsets.all(AppConstants.padding),
      decoration: BoxDecoration(
        color: AppConstants.errorColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.radius),
        border: Border.all(color: AppConstants.errorColor.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: AppConstants.errorColor),
          SizedBox(width: AppConstants.padding / 2),
          Expanded(
            child: Text(
              provider.errorMessage!,
              style: TextStyle(color: AppConstants.errorColor),
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: AppConstants.errorColor, size: 20),
            onPressed: provider.clearError,
            constraints: BoxConstraints.tightFor(width: 32, height: 32),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpOption() {
    return TextButton(
      onPressed: () {
        AppHelpers.showSnackBar(
          context,
          'Chức năng đăng ký sẽ được triển khai',
        );
      },
      child: Text(
        AppConstants.signUpText,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Future<void> _handleLogin(LoginProvider provider) async {
    if (!_formKey.currentState!.validate()) return;

    final success = await provider.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (success) {
      AppHelpers.showSnackBar(
        context,
        AppConstants.loginSuccess,
        color: AppConstants.successColor,
      );

      // Navigate to home
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
