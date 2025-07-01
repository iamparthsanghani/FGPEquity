import 'package:flutter/material.dart';
import 'dashboard_screen_mobile.dart';
import '../bets/create_bet_screen_mobile.dart';
import '../bets/my_bets_screen_mobile.dart';
import '../bets/bet_slip_screen_mobile.dart';
import '../auth/login_screen_mobile.dart';
import '../../constants/app_colors.dart';
import '../../services/firebase_service.dart';

class MobileMainScaffold extends StatefulWidget {
  const MobileMainScaffold({Key? key}) : super(key: key);

  @override
  State<MobileMainScaffold> createState() => _MobileMainScaffoldState();
}

class _MobileMainScaffoldState extends State<MobileMainScaffold> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    DashboardScreenMobile(),
    CreateBetScreenMobile(),
    MyBetsScreenMobile(),
    BetSlipScreenMobile(),
    LoginScreenMobile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) async {
          if (i == 4) {
            // Logout
            await FirebaseService.signOut();
            if (mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreenMobile()),
                (route) => false,
              );
            }
          } else {
            setState(() => _selectedIndex = i);
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_martial_arts),
            label: 'Bet Now',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Create Bet',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'My Bets',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Bet Slip',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        selectedItemColor: AppColors.secondaryColor,
        unselectedItemColor: AppColors.gray400,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}
