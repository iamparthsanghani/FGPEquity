import 'package:flutter/material.dart';

/// Centralized color definitions for the SalesBets application.
///
/// This class contains all color constants used throughout the application,
/// organized by category (primary, secondary, status, etc.). This ensures
/// consistent theming and easy maintenance across the app.
class AppColors {
  // Primary Colors
  static const Color primaryColor = Color(0xFF181C3A);
  static const Color primaryLight = Color(0xFF2A2F4F);
  static const Color primaryDark = Color(0xFF0F111F);

  // Secondary Colors
  static const Color secondaryColor = Color(0xFF3B82F6);
  static const Color secondaryLight = Color(0xFF60A5FA);
  static const Color secondaryDark = Color(0xFF2563EB);

  // Accent Colors
  static const Color accentColor = Color(0xFF10B981);
  static const Color accentLight = Color(0xFF34D399);
  static const Color accentDark = Color(0xFF059669);

  // Success Colors
  static const Color successColor = Color(0xFF10B981);
  static const Color successLight = Color(0xFFD1FAE5);
  static const Color successDark = Color(0xFF047857);

  // Error Colors
  static const Color errorColor = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFEE2E2);
  static const Color errorDark = Color(0xFFDC2626);

  // Warning Colors
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFEF3C7);
  static const Color warningDark = Color(0xFFD97706);

  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);

  // Gray Scale
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray200 = Color(0xFFE5E7EB);
  static const Color gray300 = Color(0xFFD1D5DB);
  static const Color gray400 = Color(0xFF9CA3AF);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray600 = Color(0xFF4B5563);
  static const Color gray700 = Color(0xFF374151);
  static const Color gray800 = Color(0xFF1F2937);
  static const Color gray900 = Color(0xFF111827);

  // Background Colors
  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);

  // Text Colors
  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textInverse = Color(0xFFFFFFFF);

  // Border Colors
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderMedium = Color(0xFFD1D5DB);
  static const Color borderDark = Color(0xFF9CA3AF);

  // Shadow Colors
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryColor, secondaryColor],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accentColor, accentLight],
  );

  static const LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [successColor, successLight],
  );

  // Status Colors
  static const Color liveStatusColor = Color(0xFFEF4444);
  static const Color upcomingStatusColor = Color(0xFF3B82F6);
  static const Color completedStatusColor = Color(0xFF10B981);

  // Bet Slip Colors
  static const Color betSlipBackground = Color(0xFFFFFFFF);
  static const Color betSlipBorder = Color(0xFFE5E7EB);
  static const Color betSlipActive = Color(0xFF181C3A);
  static const Color betSlipInactive = Color(0xFFE5E7EB);

  // Button Colors
  static const Color buttonPrimary = Color(0xFF3B82F6);
  static const Color buttonSecondary = Color(0xFF6B7280);
  static const Color buttonSuccess = Color(0xFF10B981);
  static const Color buttonError = Color(0xFFEF4444);
  static const Color buttonWarning = Color(0xFFF59E0B);

  // Input Colors
  static const Color inputBorder = Color(0xFFD1D5DB);
  static const Color inputFocus = Color(0xFF3B82F6);
  static const Color inputError = Color(0xFFEF4444);
  static const Color inputBackground = Color(0xFFFFFFFF);

  // Card Colors
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE5E7EB);
  static const Color cardShadow = Color(0x1A000000);
}
