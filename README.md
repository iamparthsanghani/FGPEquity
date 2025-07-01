# SalesBets - Flutter Mobile App

A fully functional Flutter mobile app that replicates the SalesBets platform functionality, featuring user authentication, real-time betting, and a modern UI design.

## Features

- 🔐 **Full User Authentication**
  - Sign up with email and password
  - Login/logout functionality
  - User profile management

- 💰 **Betting System**
  - Create sales predictions
  - Track bet status (active, won, lost)
  - Real-time balance management
  - Bet history and statistics

- 📱 **Modern UI/UX**
  - Clean, responsive design
  - Material Design 3 components
  - Gradient backgrounds and modern styling
  - Intuitive navigation

- 🔥 **Firebase Integration**
  - Firebase Authentication
  - Cloud Firestore for real-time data
  - Firebase Storage support

## Screenshots

The app includes the following screens:
- Login/Signup screens with modern design
- Dashboard with user stats and quick actions
- Create Bet screen with form validation
- My Bets screen showing all user bets
- Profile screen with user information and settings

## Getting Started

### Prerequisites

- Flutter SDK (3.6.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Firebase project

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd fgp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**

   a. Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   
   b. Enable Authentication with Email/Password provider
   
   c. Create a Firestore database
   
   d. Download the Firebase configuration files:
      - For Android: `google-services.json` → `android/app/`
      - For iOS: `GoogleService-Info.plist` → `ios/Runner/`

4. **Configure Firebase**

   For Android, add to `android/app/build.gradle`:
   ```gradle
   dependencies {
       implementation platform('com.google.firebase:firebase-bom:32.7.0')
       implementation 'com.google.firebase:firebase-analytics'
   }
   ```

   And to `android/build.gradle`:
   ```gradle
   dependencies {
       classpath 'com.google.gms:google-services:4.4.0'
   }
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── user_model.dart
│   └── bet_model.dart
├── providers/                # State management
│   └── auth_provider.dart
├── screens/                  # UI screens
│   ├── auth/
│   │   ├── login_screen.dart
│   │   └── signup_screen.dart
│   ├── dashboard/
│   │   └── dashboard_screen.dart
│   ├── bets/
│   │   ├── create_bet_screen.dart
│   │   └── my_bets_screen.dart
│   └── profile/
│       └── profile_screen.dart
├── services/                 # Business logic
│   └── firebase_service.dart
├── utils/                    # Utilities
│   └── theme.dart
└── widgets/                  # Reusable widgets
```

## Dependencies

- **firebase_core**: Firebase initialization
- **firebase_auth**: User authentication
- **cloud_firestore**: Real-time database
- **firebase_storage**: File storage
- **provider**: State management
- **google_fonts**: Custom typography
- **cached_network_image**: Image caching
- **flutter_svg**: SVG support
- **shimmer**: Loading animations
- **intl**: Internationalization
- **url_launcher**: URL handling
- **shared_preferences**: Local storage

## Features in Detail

### Authentication Flow
- Users can sign up with email, password, and full name
- Login with existing credentials
- Automatic session management
- Secure logout functionality

### Dashboard
- Welcome message with user's name
- Real-time balance display
- Statistics cards (total bets, wins, losses)
- Quick action buttons
- Recent activity feed

### Betting System
- Create bets with sales predictions
- Set target amounts and end dates
- Choose between "above" or "below" predictions
- Real-time bet status tracking
- Balance validation before placing bets

### Profile Management
- View user statistics
- Account information display
- Settings and preferences
- Transaction history (placeholder)
- Help and support options

## Firebase Collections

### Users Collection
```json
{
  "userId": {
    "fullName": "string",
    "email": "string",
    "balance": "number",
    "totalBets": "number",
    "wins": "number",
    "losses": "number",
    "createdAt": "timestamp"
  }
}
```

### Bets Collection
```json
{
  "betId": {
    "userId": "string",
    "amount": "number",
    "prediction": "string",
    "target": "string",
    "status": "string",
    "description": "string",
    "createdAt": "timestamp",
    "endDate": "timestamp"
  }
}
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For support and questions, please open an issue in the repository.

---

**Note**: This is a demonstration app. For production use, ensure proper security rules, error handling, and additional features like payment processing, admin panels, and advanced analytics.
