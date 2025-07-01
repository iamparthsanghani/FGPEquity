import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_strings.dart';

/// A specialized widget for displaying the Recruiting League option.
///
/// This widget shows a compact representation of the recruiting league
/// with an avatar, icon, and label in a consistent design pattern.
class RecruitingLeagueOption extends StatelessWidget {
  const RecruitingLeagueOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        width: AppSizes.recruitingLeagueWidth,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor.withOpacity(0.12),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: AppSizes.recruitingLeaguePaddingV,
          horizontal: AppSizes.recruitingLeaguePaddingH,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: AppSizes.recruitingLeagueAvatarRadius,
              backgroundColor: AppColors.secondaryColor,
              child: Icon(
                Icons.emoji_events,
                color: Colors.white,
                size: AppSizes.recruitingLeagueIconSize,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                AppStrings.recruitingLeague,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: AppSizes.recruitingLeagueFontSize,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
