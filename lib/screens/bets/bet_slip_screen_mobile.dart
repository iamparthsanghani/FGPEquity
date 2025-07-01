import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../theme/app_theme.dart';
import '../../widgets/mobile_top_section.dart';

class BetSlipScreenMobile extends StatefulWidget {
  const BetSlipScreenMobile({Key? key}) : super(key: key);

  @override
  State<BetSlipScreenMobile> createState() => _BetSlipScreenMobileState();
}

class _BetSlipScreenMobileState extends State<BetSlipScreenMobile> {
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
            child: Center(
              child: Text(
                AppStrings.yourSelectionsWillBeDisplayedHere,
                style: AppTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
