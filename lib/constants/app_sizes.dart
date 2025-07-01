import 'package:flutter/material.dart';

/// Centralized size constants for the SalesBets application.
///
/// This class contains all size-related constants used throughout the application,
/// including spacing, dimensions, breakpoints, and animation durations.
/// This ensures consistent sizing and responsive design across the app.
class AppSizes {
  // Base Sizes
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // Specific Sizes
  static const double iconSize = 24.0;
  static const double iconSizeSmall = 16.0;
  static const double iconSizeLarge = 32.0;
  static const double iconSizeXLarge = 48.0;

  // Border Radius
  static const double radiusXs = 4.0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 24.0;
  static const double radiusFull = 999.0;

  // Border Width
  static const double borderWidth = 1.0;
  static const double borderWidthThick = 2.0;
  static const double borderWidthThin = 0.5;

  // Elevation/Shadow
  static const double elevationNone = 0.0;
  static const double elevationXs = 1.0;
  static const double elevationSm = 2.0;
  static const double elevationMd = 4.0;
  static const double elevationLg = 8.0;
  static const double elevationXl = 16.0;

  // Button Heights
  static const double buttonHeight = 48.0;
  static const double buttonHeightSmall = 36.0;
  static const double buttonHeightLarge = 56.0;

  // Input Heights
  static const double inputHeight = 48.0;
  static const double inputHeightSmall = 40.0;
  static const double inputHeightLarge = 56.0;

  // Card Dimensions
  static const double cardPadding = 16.0;
  static const double cardMargin = 8.0;
  static const double cardBorderRadius = 12.0;

  // List Tile Dimensions
  static const double listTileHeight = 72.0;
  static const double listTileMinHeight = 56.0;
  static const double listTilePadding = 16.0;

  // App Bar Dimensions
  static const double appBarHeight = 56.0;
  static const double appBarElevation = 4.0;

  // Bottom Navigation Dimensions
  static const double bottomNavHeight = 56.0;
  static const double bottomNavElevation = 8.0;

  // Drawer Dimensions
  static const double drawerWidth = 280.0;
  static const double endDrawerWidth = 350.0;

  // Dialog Dimensions
  static const double dialogWidth = 400.0;
  static const double dialogMaxWidth = 600.0;
  static const double dialogPadding = 24.0;

  // Snackbar Dimensions
  static const double snackbarHeight = 48.0;
  static const double snackbarPadding = 16.0;

  // Progress Indicator
  static const double progressIndicatorSize = 24.0;
  static const double progressIndicatorSizeLarge = 48.0;

  // Avatar Sizes
  static const double avatarSize = 40.0;
  static const double avatarSizeSmall = 32.0;
  static const double avatarSizeLarge = 56.0;
  static const double avatarSizeXLarge = 80.0;

  // Badge Sizes
  static const double badgeSize = 20.0;
  static const double badgeSizeSmall = 16.0;
  static const double badgeSizeLarge = 24.0;

  // Divider Heights
  static const double dividerHeight = 1.0;
  static const double dividerHeightThick = 2.0;

  // Spacing for Layout
  static const double pagePadding = 16.0;
  static const double sectionSpacing = 24.0;
  static const double itemSpacing = 16.0;
  static const double contentSpacing = 8.0;

  // Responsive Breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;
  static const double wideScreenBreakpoint = 1600.0;

  // Animation Durations
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 300);
  static const Duration durationSlow = Duration(milliseconds: 500);

  // Animation Curves
  static const Curve curveFast = Curves.easeInOut;
  static const Curve curveNormal = Curves.easeInOut;
  static const Curve curveSlow = Curves.easeInOut;

  // New constants from the code block
  static const double sidebarWidth = 72;
  static const double dividerWidth = 0.5;
  static const double recruitingLeagueWidth = 170;
  static const double recruitingLeagueAvatarRadius = 11;
  static const double recruitingLeagueIconSize = 12;
  static const double recruitingLeagueFontSize = 10;
  static const double recruitingLeaguePaddingV = 12;
  static const double recruitingLeaguePaddingH = 10;
  static const double dashboardHeaderLogoWidth = 200;
  static const double dashboardHeaderLogoHeight = 50.96;
  static const double dashboardHeaderButtonFontSize = 16;
  static const double dashboardHeaderButtonPaddingH = 20;
  static const double dashboardHeaderButtonPaddingV = 8;
  static const double dashboardHeaderSpacing = 24;
  static const double dashboardHeaderTabSpacing = 8;
}

/// Extension providing convenient access to screen dimensions and responsive utilities.
extension AppSizesExtension on BuildContext {
  /// Screen width in logical pixels.
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Screen height in logical pixels.
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Status bar height in logical pixels.
  double get statusBarHeight => MediaQuery.of(this).padding.top;

  /// Bottom padding (safe area) in logical pixels.
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  /// Returns true if the screen width is below the mobile breakpoint.
  bool get isMobile => screenWidth < AppSizes.mobileBreakpoint;

  /// Returns true if the screen width is between mobile and tablet breakpoints.
  bool get isTablet =>
      screenWidth >= AppSizes.mobileBreakpoint &&
      screenWidth < AppSizes.tabletBreakpoint;

  /// Returns true if the screen width is above the desktop breakpoint.
  bool get isDesktop => screenWidth >= AppSizes.desktopBreakpoint;

  /// Returns true if the screen width is above the wide screen breakpoint.
  bool get isWideScreen => screenWidth >= AppSizes.wideScreenBreakpoint;
}
