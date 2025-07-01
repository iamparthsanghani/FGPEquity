import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/auth_provider.dart';
import '../../services/firebase_service.dart';
import '../../models/bet_model.dart';
import '../../utils/theme.dart';
import '../../constants/app_strings.dart';

class MyBetsScreen extends StatelessWidget {
  const MyBetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Bets'),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.currentUser;

          if (user == null) {
            return const Center(
              child: Text('Please log in to view your bets.'),
            );
          }

          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseService.getUserBets(user.uid),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final bets = snapshot.data?.docs ?? [];

              if (bets.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.list_alt_outlined,
                        size: 64,
                        color: AppTheme.textSecondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.noBetsYet,
                        style: AppTheme.heading3.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.createFirstBet,
                        style: AppTheme.bodyMedium.copyWith(
                          color: AppTheme.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: bets.length,
                itemBuilder: (context, index) {
                  final betData = bets[index].data() as Map<String, dynamic>;
                  final bet = BetModel.fromMap(bets[index].id, betData);

                  return _BetCard(bet: bet);
                },
              );
            },
          );
        },
      ),
    );
  }
}

class _BetCard extends StatelessWidget {
  final BetModel bet;

  const _BetCard({required this.bet});

  Color _getStatusColor() {
    switch (bet.status) {
      case 'active':
        return AppTheme.primaryColor;
      case 'won':
        return AppTheme.successColor;
      case 'lost':
        return AppTheme.errorColor;
      case 'pending':
        return AppTheme.warningColor;
      default:
        return AppTheme.textSecondary;
    }
  }

  IconData _getStatusIcon() {
    switch (bet.status) {
      case 'active':
        return Icons.schedule;
      case 'won':
        return Icons.check_circle;
      case 'lost':
        return Icons.cancel;
      case 'pending':
        return Icons.pending;
      default:
        return Icons.help;
    }
  }

  String _getStatusText() {
    switch (bet.status) {
      case 'active':
        return 'Active';
      case 'won':
        return 'Won';
      case 'lost':
        return 'Lost';
      case 'pending':
        return 'Pending';
      default:
        return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor().withAlpha(26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _getStatusIcon(),
                        size: 16,
                        color: _getStatusColor(),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _getStatusText(),
                        style: AppTheme.bodySmall.copyWith(
                          color: _getStatusColor(),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${bet.amount.toStringAsFixed(2)}',
                  style: AppTheme.heading3.copyWith(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Description
            Text(
              bet.description,
              style: AppTheme.bodyLarge,
            ),
            const SizedBox(height: 8),

            // Prediction details
            Row(
              children: [
                Icon(
                  bet.prediction == 'above'
                      ? Icons.trending_up
                      : Icons.trending_down,
                  color: bet.prediction == 'above'
                      ? AppTheme.successColor
                      : AppTheme.errorColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Sales will be ${bet.prediction} \$${bet.target}',
                  style: AppTheme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Date information
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  color: AppTheme.textSecondary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Ends: ${bet.endDate?.day}/${bet.endDate?.month}/${bet.endDate?.year}',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
                const Spacer(),
                Text(
                  'Created: ${bet.createdAt.day}/${bet.createdAt.month}/${bet.createdAt.year}',
                  style: AppTheme.bodySmall.copyWith(
                    color: AppTheme.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
