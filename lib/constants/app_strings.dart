/// Centralized string constants for the SalesBets application.
///
/// This class contains all user-facing strings used throughout the application,
/// organized by feature area. This centralization enables easy localization
/// and consistent messaging across the app.
class AppStrings {
  // Auth
  static const String login = 'Login';
  static const String signUp = 'Sign Up';
  static const String fullName = 'Full Name';
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String forgotPassword = 'Forgot Password?';
  static const String alreadyHaveAccount = 'Already have an account?';
  static const String dontHaveAccount = "Don't have an account?";
  static const String welcomeBack =
      'Welcome back! You\'ve successfully logged in.';
  static const String accountCreated =
      'Account created successfully! Welcome to SalesBets!';
  static const String pleaseEnterFullName = 'Please enter your full name';
  static const String pleaseEnterEmail = 'Please enter your email';
  static const String pleaseEnterValidEmail = 'Please enter a valid email';
  static const String pleaseEnterPassword = 'Please enter your password';
  static const String pleaseEnterConfirmPassword =
      'Please confirm your password';
  static const String passwordsDoNotMatch = 'Passwords do not match';
  static const String pleaseEnterDescription = 'Please enter a description';
  static const String pleaseEnterBetAmount = 'Please enter a bet amount';
  static const String pleaseEnterValidAmount = 'Please enter a valid amount';
  static const String pleaseSelectEndDate =
      'Please select an end date for your bet.';

  // Dashboard & Navigation
  static const String home = 'Home';
  static const String usefulLinks = 'Useful Links';
  static const String newsAndUpdates = 'News & Updates';
  static const String contact = 'Contact';
  static const String companyPolicy = 'Company Policy';
  static const String privacyPolicy = 'Privacy Policy';
  static const String termsOfService = 'Terms of Service';
  static const String aboutUs = 'About Us';
  static const String aboutUsDescription =
      'Salesbets is an innovative platform where users can place bets on the performance of salespeople in various industries. Participants can wager on which salesperson will close the most deals, hit sales targets, or outperform their peers within a set time frame. Winners of the bets earn rewards such as business services, exclusive prizes, and cash incentives, making the process exciting and rewarding. By combining competition and gamification, Salesbets creates an engaging way to motivate sales teams and drive results.';

  // Bets
  static const String betDescription = 'Bet Description';
  static const String betDescriptionHint = "Describe what you're betting on...";
  static const String betAmount = 'Bet Amount (₹)';
  static const String betAmountHint = 'e.g., 50';
  static const String endDate = 'End Date';
  static const String selectEndDate = 'Select end date';
  static const String above = 'Above';
  static const String below = 'Below';
  static const String createBet = 'Create New Bet';
  static const String placeBet = 'Place Bet';
  static const String betPlacedSuccessfully = 'Bet placed successfully!';
  static const String failedToPlaceBet = 'Failed to place bet:';
  static const String noBetsYet = 'No bets yet';
  static const String createFirstBet = 'Create your first bet to get started!';
  static const String active = 'Active';
  static const String won = 'Won';
  static const String lost = 'Lost';
  static const String pending = 'Pending';
  static const String unknown = 'Unknown';
  static const String delete = 'Delete';
  static const String returns = 'Returns:';
  static const String stakePerBet = 'Stake Per Bet';
  static const String singles = 'Singles (x1)';
  static const String multiples = 'Multiples (x1)';
  static const String yourSelections = 'Your selections will be displayed here';
  static const String noGameAvailable = 'No game available in this category';
  static const String errorLoadingEvents = 'Error loading events';
  static const String retry = 'Retry';
  static const String betSlip = 'Bet Slip';
  static const String singleBet = 'Single Bet';
  static const String multiBet = 'Multi Bet';
  static const String recruitingLeague = 'Recruiting League';
  static const String live = 'Live';
  static const String upcoming = 'Upcoming';
  static const String decimalOdds = 'Decimal Odds';
  static const String loginButton = 'Login';
  static const String signUpButton = 'Sign up';

  // Auth & General
  static const String loginFailed =
      'Login failed. Please check your credentials and try again.';
  static const String loginToYourAccount = 'Login to your account';
  static const String pleaseEnterYourEmail = 'Please enter your email';
  static const String pleaseEnterAValidEmail = 'Please enter a valid email';
  static const String pleaseEnterYourPassword = 'Please enter your password';
  static const String passwordMustBeAtLeast6Characters =
      'Password must be at least 6 characters';
  static const String dontHaveAnAccount = "Don't have an account? ";
  static const String signUpFailed =
      'Sign up failed. Please check your information and try again.';
  static const String createYourAccount = 'Create your account';

  // Bets & Dashboard
  static const String insufficientBalanceForThisBet =
      'Insufficient balance for this bet.';
  static const String betCreatedSuccessfully = 'Bet Created Successfully!';
  static const String yourPredictionHasBeenRecordedGoodLuck =
      'Your prediction has been recorded. Good luck!';
  static const String describeWhatYoureBettingOn =
      "Describe what you're betting on...";
  static const String pleaseEnterADescription = 'Please enter a description';
  static const String salesTarget = 'Sales Target (₹)';
  static const String eG2000 = 'e.g., 2000';
  static const String pleaseEnterASalesTarget = 'Please enter a sales target';
  static const String pleaseEnterAValidNumber = 'Please enter a valid number';
  static const String prediction = 'Prediction';
  static const String eG20 = 'e.g., 50';

  // Sidebar & Navigation
  static const String businessWarfare = 'Business Warfare';
  static const String leadHunt = 'Lead Hunt';
  static const String theContest = 'The Contest';
  static const String theInPerson = 'The In-Person';
  static const String virtualBu = 'Virtual Bu...';
  static const String virtualWa = 'Virtual Wa...';

  // Event List
  static const String noDescription = 'No Description';
  static const String nA = 'N/A';
  static const String unknownEvent = 'Unknown Event';
  static const String yourSelectionsWillBeDisplayedHere =
      'Your selections will be displayed here';

  // Moved from app_constants.dart
  static const String placeBetLabel = 'PLACE BET';
  static const String betLabel = 'Bet';
  static const String retryLabel = 'Retry';
  static const String singleBetLabel = 'Single Bet';
  static const String multiBetLabel = 'Multi Bet';
  static const String stakePerBetLabel = 'Stake Per Bet';
  static const String returnsLabel = 'Returns: ';
  static const String singlesLabel = 'Singles (x1)';
  static const String multiplesLabel = 'Multiples (x1)';
  static const String betSlipTitle = 'Bet Slip';
  static const String yourStatsTitle = 'Your Stats';
  static const String quickActionsTitle = 'Quick Actions';
  static const String welcomeBackMessage = 'Welcome back, ';
  static const String readyToPredictMessage =
      'Ready to make some sales predictions?';
  static const String balanceLabel = 'Balance';
  static const String totalBetsLabel = 'Total Bets';
  static const String winsLabel = 'Wins';
  static const String lossesLabel = 'Losses';
  static const String createBetLabel = 'Create Bet';
  static const String viewBetsLabel = 'View Bets';
  static const String makeNewPredictionLabel = 'Make a new prediction';
  static const String seeAllBetsLabel = 'See all your bets';
  static const String currencySymbol = '₹';
  static const String errorLoadingLiveEvents = 'Error loading live events';
  static const String errorLoadingUpcomingEvents =
      'Error loading upcoming events';
  static const String noLiveEventsAvailable = 'No live events available.';
  static const String noUpcomingEventsAvailable =
      'No upcoming events available.';
  static const String errorSelectingEvent = 'Error selecting event: ';
  static const String homeLabel = 'Home';
  static const String betsLabel = 'My Bets';
  static const String profileLabel = 'Profile';

  static const String liveStatus = 'Live';
  static const String upcomingStatus = 'Upcoming';

  static const String pleaseEnterABetAmount = 'Please enter a bet amount';
  static const String pleaseEnterAValidAmount = 'Please enter a valid amount';
}
