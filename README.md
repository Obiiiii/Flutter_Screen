# Flutter Login App Documentation

## 📁 Project Structure
lib/<br>
├── core/<br>
│   ├── constants.dart<br>
│   ├── validators.dart<br>
│   ├── providers/<br>
│   │   ├── orientation_provider.dart<br>
│   │   └── theme_provider.dart<br>
│   └── widgets/<br>
│      ├── app_scaffold.dart<br>
│      ├── custom_button.dart<br>
│      └── custom_text_field.dart<br>
├── screens/<br>
│   └── login/<br>
│      ├── login_screen.dart<br>
│      └── login_provider.dart<br>
├── services/<br>
│   └── auth_service.dart<br>
└── main.dart


## ✨ Key Features

### 🎨 Theme System
- Light/Dark/System theme modes
- Persistent theme preferences using SharedPreferences
- Custom theme configurations for both light and dark modes

### 📱 Orientation Control
- Portrait/Landscape/Free rotation modes
- Programmatic orientation locking
- Responsive UI that adapts to orientation changes

### 🔐 Authentication
- Login with email/password validation
- Remember me functionality
- Forgot password option (placeholder)
- Sign up option (placeholder)

### 🎯 UI Components
- Custom gradient scaffold
- Responsive login form layout
- Custom form fields with validation
- Loading states and error handling
- SnackBar notifications

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- Dart
- iOS/Android simulator or physical device

### Installation
1. Clone the repository
2. Run `flutter pub get`
3. Run `flutter run`

## 🔧 Configuration

### Theme Settings
Access theme settings through:
- Settings screen
- System-level theme preferences

### Orientation Control
Change screen orientation through:
- Settings screen buttons
- Programmatic calls to `OrientationProvider`

## 💾 Data Persistence
- Theme preferences saved using SharedPreferences
- "Remember me" login functionality

## 🎨 UI Features
- Adaptive layout for portrait/landscape modes
- Custom color scheme defined in `AppConstants`
- Consistent spacing and borderRadius
- Loading indicators and interactive feedback

## 🔮 Future Enhancements
- Actual API integration for authentication
- Password recovery implementation
- User registration flow
- Additional app features beyond login

## 📝 Notes
- Current authentication uses mock service
- All orientation features are functional
- Theme system is fully implemented
- UI is responsive across different screen sizes

---

**Happy Coding!** 🎉
