// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/orientation_provider.dart';
import 'screens/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cho phép xoay tự do khi khởi động app
  await OrientationProvider.setAllOrientations();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'My App',
            theme: themeProvider.getTheme(context),
            initialRoute: '/login',
            routes: {
              '/login': (context) => LoginScreen(),
              '/home': (context) => HomeScreen(),
              '/settings': (context) => SettingsScreen(),
              // ... thêm routes khác ở đây
            },
          );
        },
      ),
    );
  }
}

// Temporary Home Screen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: AppConstants.primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
      body: OrientationBuilder(
        // Sử dụng OrientationBuilder để tự động rebuild khi xoay màn hình
        builder: (context, orientation) {
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppConstants.padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome to Home Screen!',
                    style: TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),

                  // Hiển thị thông tin hướng màn hình hiện tại
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      orientation == Orientation.landscape
                          ? 'Màn hình ngang'
                          : 'Màn hình dọc',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.primaryColor,
                      ),
                    ),
                  ),

                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text('Logout'),
                  ),
                  SizedBox(height: 20),

                  // Các nút điều khiển orientation
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await OrientationProvider.setLandscape();
                          AppHelpers.showSnackBar(context, 'Đã khóa màn hình ngang');
                        },
                        child: Text('Khóa ngang'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryColor,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await OrientationProvider.setPortrait();
                          AppHelpers.showSnackBar(context, 'Đã khóa màn hình dọc');
                        },
                        child: Text('Khóa dọc'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppConstants.primaryColor,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await OrientationProvider.setAllOrientations();
                          AppHelpers.showSnackBar(context, 'Cho phép xoay tự do');
                        },
                        child: Text('Tự do xoay'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Settings Screen for theme and orientation control
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cài đặt'),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Giao diện', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),

            // Theme selection
            _buildThemeOption(
              context,
              themeProvider,
              AppConstants.lightTheme,
              'Sáng',
              Icons.light_mode,
            ),
            _buildThemeOption(
              context,
              themeProvider,
              AppConstants.darkTheme,
              'Tối',
              Icons.dark_mode,
            ),
            _buildThemeOption(
              context,
              themeProvider,
              AppConstants.systemTheme,
              'Theo hệ thống',
              Icons.settings_suggest,
            ),

            SizedBox(height: 32),
            Text('Xoay màn hình', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),

            // Orientation buttons
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildOrientationButton(
                  'Khóa dọc',
                  Icons.stay_primary_portrait,
                      () async {
                    await OrientationProvider.setPortrait();
                    AppHelpers.showSnackBar(context, 'Đã khóa màn hình dọc');
                  },
                ),
                _buildOrientationButton(
                  'Khóa ngang',
                  Icons.stay_primary_landscape,
                      () async {
                    await OrientationProvider.setLandscape();
                    AppHelpers.showSnackBar(context, 'Đã khóa màn hình ngang');
                  },
                ),
                _buildOrientationButton(
                  'Tự do xoay',
                  Icons.screen_rotation,
                      () async {
                    await OrientationProvider.setAllOrientations();
                    AppHelpers.showSnackBar(context, 'Cho phép xoay tự do');
                  },
                  backgroundColor: Colors.green,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(BuildContext context, ThemeProvider provider,
      String value, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: AppConstants.primaryColor),
      title: Text(title),
      trailing: Radio(
        value: value,
        groupValue: provider.themeMode,
        onChanged: (newValue) {
          provider.setTheme(newValue!);
        },
      ),
      onTap: () {
        provider.setTheme(value);
      },
    );
  }

  Widget _buildOrientationButton(String text, IconData icon,
      VoidCallback onPressed, {Color? backgroundColor}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppConstants.primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}