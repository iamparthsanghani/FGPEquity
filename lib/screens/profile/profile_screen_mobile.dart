import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../theme/app_theme.dart';
import '../../widgets/mobile_top_section.dart';

class ProfileScreenMobile extends StatefulWidget {
  const ProfileScreenMobile({Key? key}) : super(key: key);

  @override
  State<ProfileScreenMobile> createState() => _ProfileScreenMobileState();
}

class _ProfileScreenMobileState extends State<ProfileScreenMobile> {
  String _selectedTab = AppStrings.liveStatus;
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: null,
      body: Column(
        children: [
          MobileTopSection(
            selectedTab: _selectedTab,
            onTabChanged: (tab) => setState(() => _selectedTab = tab),
            selectedCategoryIndex: _selectedCategoryIndex,
            onCategoryChanged: (i) =>
                setState(() => _selectedCategoryIndex = i),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: AppColors.secondaryColor,
                    child: Icon(Icons.person, size: 48, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(AppStrings.fullName, style: AppTheme.heading3),
                  const SizedBox(height: 8),
                  Text(AppStrings.email, style: AppTheme.bodyMedium),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.errorColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(48),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
