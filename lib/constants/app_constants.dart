/// Technical constants for the SalesBets application.
///
/// This class contains non-user-facing constants such as collection names,
/// status codes, bet types, and default values used throughout the application.
/// User-facing strings are centralized in AppStrings for localization support.
class AppConstants {
  // App Information
  static const String appName = 'SalesBets';
  static const String appVersion = '1.0.0';

  // Firebase Collections
  static const String usersCollection = 'users';
  static const String gamesCollection = 'games';
  static const String betsCollection = 'bets';

  // Game Status
  static const String liveStatus = 'live';
  static const String upcomingStatus = 'upcoming';
  static const String completedStatus = 'completed';

  // Bet Types
  static const String singleBet = 'single';
  static const String multiBet = 'multi';

  // Predictions
  static const String abovePrediction = 'above';
  static const String belowPrediction = 'below';

  // Default Values
  static const String defaultDescription = 'No Description';
  static const String defaultTarget = 'N/A';
  static const String defaultPrediction = 'above';
  static const String unknownEvent = 'Unknown Event';

  // Time
  static const int defaultBetDurationDays = 1;
}
