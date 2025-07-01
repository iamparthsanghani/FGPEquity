# Firebase Setup Guide

## Prerequisites
1. A Google account
2. Flutter project set up

## Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Create a project" or "Add project"
3. Enter a project name (e.g., "salesbets-app")
4. Choose whether to enable Google Analytics (recommended)
5. Click "Create project"

## Step 2: Enable Authentication

1. In your Firebase project, go to "Authentication" in the left sidebar
2. Click "Get started"
3. Go to the "Sign-in method" tab
4. Enable "Email/Password" provider
5. Click "Save"

## Step 3: Create Firestore Database

1. In your Firebase project, go to "Firestore Database" in the left sidebar
2. Click "Create database"
3. Choose "Start in test mode" for development (you can add security rules later)
4. Select a location for your database
5. Click "Done"

## Step 4: Download Configuration Files

### For Android:
1. In your Firebase project, go to "Project settings" (gear icon)
2. Scroll down to "Your apps" section
3. Click "Add app" and select Android
4. Enter your Android package name: `com.example.fgp`
5. Download the `google-services.json` file
6. Place it in `android/app/` directory

### For iOS:
1. In your Firebase project, go to "Project settings" (gear icon)
2. Scroll down to "Your apps" section
3. Click "Add app" and select iOS
4. Enter your iOS bundle ID: `com.example.fgp`
5. Download the `GoogleService-Info.plist` file
6. Place it in `ios/Runner/` directory

## Step 5: Security Rules (Optional)

For Firestore, you can start with these basic rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow users to read and write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
    
    // Allow users to read and write their own bets
    match /bets/{betId} {
      allow read, write: if request.auth != null && 
        (resource.data.userId == request.auth.uid || 
         request.resource.data.userId == request.auth.uid);
    }
  }
}
```

## Step 6: Test the Setup

1. Run `flutter pub get` to ensure all dependencies are installed
2. Run `flutter run` to test the app
3. Try creating a new account and logging in

## Troubleshooting

### Common Issues:

1. **"No Firebase App '[DEFAULT]' has been created"**
   - Make sure you've placed the configuration files in the correct locations
   - Ensure Firebase is properly initialized in `main.dart`

2. **Authentication errors**
   - Check that Email/Password authentication is enabled in Firebase Console
   - Verify your Firebase project settings

3. **Firestore permission errors**
   - Make sure your Firestore database is created
   - Check security rules if you've set them up

### Getting Help:
- Check the [Firebase Flutter documentation](https://firebase.flutter.dev/)
- Review the [Firebase Console documentation](https://firebase.google.com/docs)
- Check the app logs for specific error messages

## Next Steps

Once Firebase is set up:
1. Test user registration and login
2. Create some test bets
3. Verify data is being stored in Firestore
4. Consider implementing additional security rules
5. Set up Firebase Analytics for user insights 