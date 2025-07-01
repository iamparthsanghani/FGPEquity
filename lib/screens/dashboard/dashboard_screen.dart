import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/auth_provider.dart';
import '../../blocs/bet_slip/bet_slip_bloc.dart';
import '../../blocs/bet_slip/bet_slip_event.dart';
import '../../blocs/bet_slip/bet_slip_state.dart';
import '../../blocs/games/games_bloc.dart';
import '../../services/firebase_service.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_sizes.dart';
import '../../theme/app_theme.dart';
import '../../widgets/recruiting_league_option.dart';
import '../../constants/app_strings.dart';

/// Main dashboard screen of the SalesBets application.
///
/// Provides the primary interface with sidebar navigation, header,
/// main content area, and bet slip panel. Handles responsive layout
/// for desktop and mobile devices.
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;
  String _selectedTab = AppStrings.liveStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          // Fixed header at the top
          DashboardHeader(
            selectedTab: _selectedTab,
            onTabChanged: (tab) {
              setState(() => _selectedTab = tab);
            },
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Sidebar(
                  selectedIndex: _selectedIndex,
                  onSelect: (i) => setState(() => _selectedIndex = i),
                ),
                // Vertical divider between sidebar and next section
                Container(
                  width: AppSizes.dividerWidth,
                  color: AppColors.gray200,
                  margin: EdgeInsets.symmetric(vertical: 0),
                ),
                // Recruiting League static option
                Container(
                  width: AppSizes.recruitingLeagueWidth,
                  color: AppColors.primaryColor,
                  child: const Column(
                    children: [
                      SizedBox(height: AppSizes.lg),
                      RecruitingLeagueOption(),
                    ],
                  ),
                ),
                // Main content area
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Banner with logo and LAB text inside
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 12, 12, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      'assets/images/header.png',
                                      fit: BoxFit.cover,
                                      height: 236,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                // Main content (event list, etc.)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: _selectedTab == AppStrings.liveStatus
                                      ? const EventList(isLive: true)
                                      : const EventList(isLive: false),
                                ),
                                const SizedBox(height: 50),
                                _DashboardFooter(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (context.isDesktop)
                  SizedBox(
                    width: AppSizes.endDrawerWidth,
                    child: const _BetSlipPanel(),
                  ),
              ],
            ),
          ),
        ],
      ),
      endDrawer: context.isMobile ? Drawer(child: const _BetSlipPanel()) : null,
    );
  }
}

/// Sidebar navigation component with game categories.
///
/// Displays a vertical list of navigation items for different
/// game categories with icons and labels.
class Sidebar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  const Sidebar({required this.selectedIndex, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final items = [
      _SidebarItem(Icons.sports_martial_arts, AppStrings.businessWarfare),
      _SidebarItem(Icons.flag, AppStrings.leadHunt),
      _SidebarItem(Icons.emoji_events, AppStrings.theContest),
      _SidebarItem(Icons.people, AppStrings.theInPerson),
      _SidebarItem(Icons.videogame_asset, AppStrings.virtualBu),
      _SidebarItem(Icons.sports, AppStrings.virtualWa),
    ];
    return Container(
      width: AppSizes.sidebarWidth,
      color: AppColors.primaryColor,
      child: Column(
        children: [
          const SizedBox(height: AppSizes.lg),
          ...List.generate(
            items.length,
            (i) => _SidebarNavItem(
              icon: items[i].icon,
              label: items[i].label,
              selected: selectedIndex == i,
              onTap: () => onSelect(i),
            ),
          ),
        ],
      ),
    );
  }
}

/// Data class for sidebar navigation items.
class _SidebarItem {
  final IconData icon;
  final String label;
  const _SidebarItem(this.icon, this.label);
}

/// Individual sidebar navigation item widget.
class _SidebarNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _SidebarNavItem(
      {required this.icon,
      required this.label,
      required this.selected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected
          ? AppColors.secondaryColor.withOpacity(0.18)
          : Colors.transparent,
      // borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Column(
            children: [
              Icon(icon,
                  color: selected ? AppColors.secondaryColor : AppColors.white,
                  size: 22),
              const SizedBox(height: 2),
              SizedBox(
                width: 60,
                child: Text(
                  label,
                  style: AppTheme.bodySmall.copyWith(
                    color:
                        selected ? AppColors.secondaryColor : AppColors.white,
                    fontSize: 11,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashboardHeader extends StatelessWidget {
  final String selectedTab;
  final ValueChanged<String> onTabChanged;
  const DashboardHeader(
      {required this.selectedTab, required this.onTabChanged});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Container(
      color: AppColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left: Logo + LAB + Live/Upcoming Tabs
          Row(
            children: [
              Image.asset('assets/images/lab drawer logo.png',
                  width: 200, height: 50.96),
              const SizedBox(width: 12),
              const SizedBox(width: 24),
              TextButton(
                onPressed: () => onTabChanged(AppStrings.liveStatus),
                style: TextButton.styleFrom(
                  backgroundColor: selectedTab == AppStrings.liveStatus
                      ? AppColors.secondaryColor
                      : Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(
                      color: selectedTab == AppStrings.liveStatus
                          ? AppColors.secondaryColor
                          : Colors.white,
                      width: 2,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                child: const Text('Live',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: () => onTabChanged(AppStrings.upcomingStatus),
                style: TextButton.styleFrom(
                  backgroundColor: selectedTab == AppStrings.upcomingStatus
                      ? AppColors.secondaryColor
                      : Colors.transparent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                    side: BorderSide(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                ),
                child: const Text('Upcoming',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
          // Right: Home, Odds, Login, Sign up (hide/collapse on mobile)
          if (!isMobile)
            Row(
              children: [
                Text('Home',
                    style: AppTheme.bodyLarge.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w500)),
                const SizedBox(width: 24),
                DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: 'Decimal Odds',
                    items: const [
                      DropdownMenuItem(
                          value: 'Decimal Odds', child: Text('Decimal Odds')),
                    ],
                    onChanged: (_) {},
                    style: const TextStyle(color: Colors.white),
                    dropdownColor: AppColors.primaryColor,
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 24),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primaryColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  ),
                  child: const Text(AppStrings.login,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    foregroundColor: Colors.white,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  ),
                  child: const Text(AppStrings.signUp,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          if (isMobile)
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
        ],
      ),
    );
  }
}

class DashboardBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: AppSizes.xl, left: AppSizes.xl, right: AppSizes.xl),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        child: Image.asset(
          'assets/images/header.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: 220,
        ),
      ),
    );
  }
}

class EventList extends StatelessWidget {
  final bool isLive;
  const EventList({required this.isLive});

  @override
  Widget build(BuildContext context) {
    return SafeFirestoreStream(
      stream: FirebaseFirestore.instance
          .collection('games')
          .where('status', isEqualTo: isLive ? 'live' : 'upcoming')
          .snapshots(),
      errorMessage: AppStrings.errorLoadingEvents,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/selection.png',
                width: 80,
                height: 80,
                color: AppColors.gray300,
              ),
              const SizedBox(height: AppSizes.sm),
              Text(
                AppStrings.noGameAvailable,
                style:
                    AppTheme.bodySmall.copyWith(color: AppColors.textSecondary),
              ),
            ],
          );
        }
        final events = snapshot.data!.docs;
        return Column(
          children: [
            ...events.map((doc) {
              final event = doc.data() as Map<String, dynamic>;
              return Card(
                margin: const EdgeInsets.only(bottom: AppSizes.md),
                child: ListTile(
                  title: Text(event['description'] ?? AppStrings.noDescription),
                  subtitle: Text(
                      'Target: ${event['target'] ?? AppStrings.nA} | Prediction: ${event['prediction'] ?? AppStrings.above}'),
                  trailing: ElevatedButton(
                    onPressed: () {
                      try {
                        final endDate = event['endDate'] != null
                            ? (event['endDate'] as Timestamp).toDate()
                            : DateTime.now().add(const Duration(days: 1));
                        context.read<BetSlipBloc>().add(AddSelectionEvent(
                              description: event['description'] ??
                                  AppStrings.unknownEvent,
                              target: event['target'] ?? '0',
                              prediction:
                                  event['prediction'] ?? AppStrings.above,
                              endDate: endDate,
                            ));
                        if (context.isDesktop) {
                          Scaffold.of(context).openEndDrawer();
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error selecting event: $e'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: const Text('Bet'),
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class _DashboardFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.xl, vertical: AppSizes.lg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // About Us
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('About Us',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 8),
                    Text(
                        'Salesbets is an innovative platform where users can place bets on the performance of salespeople in various industries. Participants can wager on which salesperson will close the most deals, hit sales targets, or outperform their peers within a set time frame. Winners of the bets earn rewards such as business services, exclusive prizes, and cash incentives, making the process exciting and rewarding. By combining competition and gamification, Salesbets creates an engaging way to motivate sales teams and drive results.'),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.xl),
              // Useful Links
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Useful Links',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 8),
                    Text('Home'),
                    Text('News & Updates'),
                    Text('Contact'),
                  ],
                ),
              ),
              const SizedBox(width: AppSizes.xl),
              // Company Policy
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Company Policy',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 8),
                    Text('Privacy Policy'),
                    Text('Terms of Service'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Safe Firestore Stream Widget to handle connection issues
class SafeFirestoreStream extends StatelessWidget {
  final Stream<QuerySnapshot> stream;
  final Widget Function(BuildContext, AsyncSnapshot<QuerySnapshot>) builder;
  final String errorMessage;

  const SafeFirestoreStream({
    super.key,
    required this.stream,
    required this.builder,
    required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 48, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    // Force rebuild to retry
                    (context as Element).markNeedsBuild();
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return builder(context, snapshot);
      },
    );
  }
}

// Bet Slip Panel Widget
class _BetSlipPanel extends StatefulWidget {
  const _BetSlipPanel();

  @override
  State<_BetSlipPanel> createState() => _BetSlipPanelState();
}

class _BetSlipPanelState extends State<_BetSlipPanel> {
  late TextEditingController stakeController;
  bool _isPlacingBet = false;

  @override
  void initState() {
    super.initState();
    final betSlipState = context.read<BetSlipBloc>().state;
    if (betSlipState is BetSlipLoaded) {
      stakeController = TextEditingController(
        text: betSlipState.stake?.toString() ?? '',
      );
    } else {
      stakeController = TextEditingController();
    }
    stakeController.addListener(_onStakeChanged);
  }

  @override
  void dispose() {
    stakeController.dispose();
    super.dispose();
  }

  void _onStakeChanged() {
    final stake = double.tryParse(stakeController.text);
    if (stake != null) {
      context.read<BetSlipBloc>().add(SetStakeEvent(stake));
    } else {
      context.read<BetSlipBloc>().add(const SetStakeEvent(0));
    }
  }

  Future<void> _placeBet(BetSlipLoaded state, AuthProvider authProvider) async {
    setState(() => _isPlacingBet = true);
    try {
      final user = authProvider.currentUser;
      if (user == null) return;
      final betData = {
        'amount': state.stake,
        'prediction': state.prediction,
        'target': state.target,
        'endDate': state.endDate,
        'description': state.description,
      };
      await FirebaseService.createBet(user.uid, betData);
      context.read<BetSlipBloc>().add(const ClearBetSlipEvent());
      stakeController.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('Bet placed successfully!'),
              ],
            ),
            backgroundColor: AppColors.successColor,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to place bet: $e'),
            backgroundColor: AppColors.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isPlacingBet = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return BlocBuilder<BetSlipBloc, BetSlipState>(
      builder: (context, state) {
        if (state is BetSlipLoaded) {
          return Container(
            color: AppColors.betSlipBackground,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: AppColors.betSlipBorder),
                    ),
                  ),
                  child: Text(
                    AppStrings.betSlipTitle,
                    style: AppTheme.heading3,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          context
                              .read<BetSlipBloc>()
                              .add(const SetBetTypeEvent(AppStrings.singleBet));
                        },
                        child: Text(AppStrings.singleBetLabel),
                        style: TextButton.styleFrom(
                          foregroundColor: state.betType == AppStrings.singleBet
                              ? AppColors.white
                              : AppColors.primaryColor,
                          backgroundColor: state.betType == AppStrings.singleBet
                              ? AppColors.betSlipActive
                              : AppColors.betSlipInactive,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(AppSizes.radiusSm)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          context
                              .read<BetSlipBloc>()
                              .add(const SetBetTypeEvent(AppStrings.multiBet));
                        },
                        child: Text(AppStrings.multiBetLabel),
                        style: TextButton.styleFrom(
                          foregroundColor: state.betType == AppStrings.multiBet
                              ? AppColors.white
                              : AppColors.primaryColor,
                          backgroundColor: state.betType == AppStrings.multiBet
                              ? AppColors.betSlipActive
                              : AppColors.betSlipInactive,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(AppSizes.radiusSm)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: state.isValid
                        ? SingleChildScrollView(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      'Description: \\${state.description ?? ''}'),
                                  Text('Target: \\${state.target ?? ''}'),
                                  Text('Prediction: \\${state.prediction}'),
                                  Text(
                                      'End Date: \\${state.endDate?.toLocal().toString().split(' ')[0] ?? ''}'),
                                  Text('Stake: \\${state.stake ?? ''}'),
                                ],
                              ),
                            ),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/selection.png',
                                width: 80,
                                height: 80,
                                color: AppColors.gray300,
                              ),
                              const SizedBox(height: AppSizes.md),
                              Text(
                                AppStrings.yourSelectionsWillBeDisplayedHere,
                                style: AppTheme.bodyMedium
                                    .copyWith(color: AppColors.textSecondary),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(AppSizes.md),
                  decoration: const BoxDecoration(
                    border:
                        Border(top: BorderSide(color: AppColors.betSlipBorder)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            state.betType == AppStrings.singleBet
                                ? AppStrings.singlesLabel
                                : AppStrings.multiplesLabel,
                            style: AppTheme.bodySmall
                                .copyWith(color: AppColors.textSecondary),
                          ),
                          const Spacer(),
                          Text(
                            state.stake?.toStringAsFixed(2) ?? '0.0',
                            style: AppTheme.bodySmall
                                .copyWith(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.sm),
                      TextField(
                        controller: stakeController,
                        decoration: InputDecoration(
                          labelText: AppStrings.stakePerBetLabel,
                          border: const OutlineInputBorder(),
                          isDense: true,
                        ),
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: AppSizes.sm),
                      Row(
                        children: [
                          Text(AppStrings.returnsLabel),
                          Text(
                            '${AppStrings.currencySymbol}${state.stake != null ? (state.stake! * 2).toStringAsFixed(2) : '0.00'}',
                            style: AppTheme.bodyMedium
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.sm),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete,
                                color: AppColors.errorColor),
                            onPressed: () {
                              context
                                  .read<BetSlipBloc>()
                                  .add(const ClearBetSlipEvent());
                              stakeController.clear();
                            },
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _isPlacingBet
                                  ? null
                                  : () async {
                                      await _placeBet(state, authProvider);
                                    },
                              child: _isPlacingBet
                                  ? const SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(AppStrings.placeBetLabel),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.buttonPrimary,
                                foregroundColor: AppColors.white,
                                padding: const EdgeInsets.symmetric(
                                    vertical: AppSizes.md),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSizes.radiusSm),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
