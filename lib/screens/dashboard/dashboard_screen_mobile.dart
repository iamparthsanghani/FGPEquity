import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../theme/app_theme.dart';
import '../../blocs/games/games_bloc.dart';
import '../../blocs/bet_slip/bet_slip_bloc.dart';
import '../../widgets/recruiting_league_option.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../providers/auth_provider.dart';
import '../../services/firebase_service.dart';
import 'package:provider/provider.dart';
import 'dashboard_screen.dart' show EventList;
import '../../widgets/mobile_top_section.dart';
import 'package:fgp/screens/bets/my_bets_screen_mobile.dart';
import 'package:fgp/screens/auth/login_screen_mobile.dart';

class DashboardScreenMobile extends StatefulWidget {
  const DashboardScreenMobile({Key? key}) : super(key: key);

  @override
  State<DashboardScreenMobile> createState() => _DashboardScreenMobileState();
}

class _DashboardScreenMobileState extends State<DashboardScreenMobile> {
  int _selectedIndex = 0;
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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/header.png',
                fit: BoxFit.contain,
                height: 100,
                width: double.infinity,
              ),
            ),
          ),
          Expanded(
            child: _selectedTab == AppStrings.liveStatus
                ? const EventList(isLive: true)
                : const EventList(isLive: false),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _TabButton(
      {required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.secondaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: selected ? AppColors.secondaryColor : Colors.white,
            width: 2,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
