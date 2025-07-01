import 'package:fgp/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'providers/auth_provider.dart';
import 'blocs/bet_slip/bet_slip_bloc.dart';
import 'blocs/games/games_bloc.dart';
import 'repositories/game_repository.dart';
import 'theme/app_theme.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/login_screen_mobile.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/dashboard/dashboard_screen_mobile.dart';
import 'screens/dashboard/mobile_main_scaffold.dart';
import 'constants/app_strings.dart';
import 'package:flutter/services.dart';

/// Main entry point of the SalesBets Flutter application.
///
/// Initializes Firebase and runs the app with proper state management setup.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF191D45),
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));

  // Web-specific configuration to handle input focus issues
  if (kIsWeb) {
    // Add web-specific configurations if needed
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

/// Root widget of the SalesBets application.
///
/// Sets up the app-wide state management providers including:
/// - AuthProvider for authentication state
/// - BetSlipBloc for bet slip management
/// - GamesBloc for games data management
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Keep AuthProvider for now (can be migrated to Bloc later)
        ChangeNotifierProvider(create: (_) => AuthProvider()),

        // New Bloc providers
        BlocProvider(create: (_) => BetSlipBloc()),
        BlocProvider(
          create: (_) => GamesBloc(
            gameRepository: GameRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: AppStrings.home,
        theme: AppTheme.lightTheme,
        home: const AuthWrapper(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

/// Authentication wrapper that handles the app's authentication flow.
///
/// Shows loading indicator while checking authentication state,
/// redirects to Dashboard if authenticated, or Login screen if not.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (authProvider.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (authProvider.isAuthenticated) {
          final width = MediaQuery.of(context).size.width;
          if (width < 700) {
            return const MobileMainScaffold();
          } else {
            return const DashboardScreen();
          }
        }

        final width = MediaQuery.of(context).size.width;
        if (width < 700) {
          return const LoginScreenMobile();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
