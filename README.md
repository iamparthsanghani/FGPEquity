# SalesBets - Modern Flutter Betting Platform

<div align="center">

![SalesBets Logo](assets/images/header.png)

**A Flutter technical assessment project replicating the SalesBets platform functionality**

[![Flutter](https://img.shields.io/badge/Flutter-3.19.0-blue.svg)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.3.0-blue.svg)](https://dart.dev/)
[![Firebase](https://img.shields.io/badge/Firebase-10.7.0-orange.svg)](https://firebase.google.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

</div>

## 🎯 Overview

This is a Flutter technical assessment project that replicates the SalesBets platform functionality. The application demonstrates modern Flutter development practices, Firebase integration, and responsive UI/UX design. Built as part of the FGF Private Equity Group Flutter Developer application process.

### 🌟 Key Features

- **🎮 Gamified Sales Predictions** - Bet on sales performance outcomes
- **📊 Real-time Analytics** - Track wins, losses, and betting statistics
- **🔐 Secure Authentication** - Firebase-powered user management
- **📱 Responsive Design** - Works seamlessly on mobile and desktop
- **⚡ Real-time Updates** - Live data synchronization with Firestore
- **🎨 Modern UI/UX** - Material Design 3 with custom theming

## 🚀 Features

### Authentication & User Management
- ✅ Email/password authentication
- ✅ User profile management
- ✅ Session persistence
- ✅ Secure logout functionality

### Betting System
- ✅ Create sales performance predictions
- ✅ Set target amounts and timeframes
- ✅ Above/below prediction types
- ✅ Real-time bet status tracking
- ✅ Balance validation and management

### Dashboard & Analytics
- ✅ Personalized welcome dashboard
- ✅ Real-time balance display
- ✅ Comprehensive betting statistics
- ✅ Quick action shortcuts
- ✅ Live event streaming

### Modern Architecture
- ✅ **BLoC Pattern** for state management
- ✅ **Provider** for dependency injection
- ✅ **Firebase** for backend services
- ✅ **Responsive Design** for all screen sizes
- ✅ **Localization Ready** with centralized strings

## 🛠️ Technology Stack

- **Frontend**: Flutter 3.19.0, Dart 3.3.0
- **Backend**: Firebase (Authentication, Firestore, Storage)
- **State Management**: BLoC Pattern + Provider
- **UI Framework**: Material Design 3
- **Architecture**: Clean Architecture with Repository Pattern

## 📋 Prerequisites

- Flutter SDK (3.19.0 or higher)
- Dart SDK (3.3.0 or higher)
- Android Studio / VS Code with Flutter extensions
- Firebase project setup
- Git

## 🚀 Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/salesbets.git
cd salesbets
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Firebase Setup

#### Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Create a new project
3. Enable Authentication with Email/Password provider
4. Create a Firestore database in test mode

#### Download Configuration Files
- **Android**: Download `google-services.json` → Place in `android/app/`
- **iOS**: Download `GoogleService-Info.plist` → Place in `ios/Runner/`
- **Web**: Download `firebase_options.dart` → Place in `lib/`

#### Configure Firebase Rules

**Firestore Security Rules:**
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read/write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Users can read/write their own bets
    match /bets/{betId} {
      allow read, write: if request.auth != null && 
        request.auth.uid == resource.data.userId;
    }
    
    // Public read access to games
    match /games/{gameId} {
      allow read: if true;
      allow write: if request.auth != null;
    }
  }
}
```

### 4. Run the Application

```bash
# For development
flutter run

# For production build
flutter build apk --release

# For web deployment
flutter build web --release
```

## 📁 Project Structure

```
lib/
├── main.dart                    # Application entry point
├── constants/                   # App-wide constants
│   ├── app_colors.dart         # Color definitions
│   ├── app_sizes.dart          # Size constants & responsive utilities
│   ├── app_strings.dart        # Localized strings
│   └── app_constants.dart      # Technical constants
├── models/                     # Data models
│   ├── user_model.dart         # User data model
│   └── bet_model.dart          # Bet data model
├── providers/                  # State management
│   ├── auth_provider.dart      # Authentication state
│   └── bet_slip_provider.dart  # Bet slip state
├── blocs/                      # BLoC pattern implementation
│   ├── bet_slip/              # Bet slip state management
│   │   ├── bet_slip_bloc.dart
│   │   ├── bet_slip_event.dart
│   │   └── bet_slip_state.dart
│   └── games/                 # Games state management
│       ├── games_bloc.dart
│       ├── games_event.dart
│       └── games_state.dart
├── screens/                    # UI screens
│   ├── auth/                  # Authentication screens
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── dashboard/             # Main dashboard
│   │   └── dashboard_screen.dart
│   ├── bets/                  # Betting screens
│   │   ├── create_bet_screen.dart
│   │   └── my_bets_screen.dart
│   └── profile/               # Profile management
│       └── profile_screen.dart
├── services/                  # Business logic & external services
│   └── firebase_service.dart  # Firebase operations
├── repositories/              # Data access layer
│   └── game_repository.dart   # Game data operations
├── theme/                     # App theming
│   └── app_theme.dart         # Material theme configuration
├── utils/                     # Utility functions
│   ├── form_utils.dart        # Form validation utilities
│   └── theme.dart             # Legacy theme (deprecated)
└── widgets/                   # Reusable UI components
    └── recruiting_league_option.dart
```

## 📦 Dependencies

### Core Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.2          # Firebase initialization
  firebase_auth: ^4.15.3          # User authentication
  cloud_firestore: ^4.13.6        # Real-time database
  flutter_bloc: ^8.1.3            # State management
  provider: ^6.1.1                # Dependency injection
  google_fonts: ^6.1.0            # Custom typography
  equatable: ^2.0.5               # Value equality
```

### Development Dependencies
```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0           # Code quality
```

## 🔧 Configuration

### Environment Variables
Create a `.env` file in the root directory:
```env
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_API_KEY=your-api-key
```

### Build Configuration
The app supports multiple build configurations:
- **Debug**: Development with hot reload
- **Release**: Production-optimized build
- **Profile**: Performance profiling

## 📊 Data Models

### User Model
```dart
class UserModel {
  final String id;
  final String fullName;
  final String email;
  final double balance;
  final int totalBets;
  final int wins;
  final int losses;
  final DateTime createdAt;
}
```

### Bet Model
```dart
class BetModel {
  final String id;
  final String userId;
  final double amount;
  final String prediction;
  final String target;
  final String status;
  final DateTime createdAt;
  final DateTime? endDate;
  final String description;
}
```

## 🔥 Firebase Collections

### Users Collection
```json
{
  "users": {
    "userId": {
      "fullName": "John Doe",
      "email": "john@example.com",
      "balance": 1000.0,
      "totalBets": 5,
      "wins": 3,
      "losses": 2,
      "createdAt": "2024-01-01T00:00:00Z"
    }
  }
}
```

### Bets Collection
```json
{
  "bets": {
    "betId": {
      "userId": "user123",
      "amount": 50.0,
      "prediction": "above",
      "target": "2000",
      "status": "active",
      "description": "Sales will exceed target",
      "createdAt": "2024-01-01T00:00:00Z",
      "endDate": "2024-01-31T23:59:59Z"
    }
  }
}
```

### Games Collection
```json
{
  "games": {
    "gameId": {
      "description": "Monthly Sales Target",
      "target": "50000",
      "prediction": "above",
      "status": "live",
      "endDate": "2024-01-31T23:59:59Z",
      "createdAt": "2024-01-01T00:00:00Z"
    }
  }
}
```

## 🎨 UI/UX Features

### Design System
- **Color Palette**: Custom color scheme with primary, secondary, and accent colors
- **Typography**: Inter font family with consistent text styles
- **Spacing**: 8px grid system for consistent spacing
- **Components**: Reusable Material Design 3 components

### Responsive Design
- **Mobile**: Optimized for phones with collapsible sidebar
- **Tablet**: Enhanced layout with larger touch targets
- **Desktop**: Full-featured interface with side panels

### Accessibility
- Screen reader support
- High contrast mode
- Keyboard navigation
- Semantic labels

## 🧪 Testing

### Unit Tests
```bash
flutter test
```

### Widget Tests
```bash
flutter test test/widget_test.dart
```

### Integration Tests
```bash
flutter drive --target=test_driver/app.dart
```

## 🚀 Deployment

### Android
```bash
flutter build apk --release
flutter build appbundle --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Development Guidelines
- Follow the existing code style
- Add tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🆘 Support

- **Documentation**: Check the code comments and this README
- **Issues**: [GitHub Issues](https://github.com/yourusername/salesbets/issues)
- **Discussions**: [GitHub Discussions](https://github.com/yourusername/salesbets/discussions)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase team for the backend services
- Material Design team for the design system
- FGF Private Equity Group for the technical assessment opportunity

---

<div align="center">

**Built as a Flutter Technical Assessment for FGF Private Equity Group**

[![GitHub stars](https://img.shields.io/github/stars/yourusername/salesbets?style=social)](https://github.com/yourusername/salesbets)
[![GitHub forks](https://img.shields.io/github/forks/yourusername/salesbets?style=social)](https://github.com/yourusername/salesbets)
[![GitHub issues](https://img.shields.io/github/issues/yourusername/salesbets)](https://github.com/yourusername/salesbets/issues)

</div>
