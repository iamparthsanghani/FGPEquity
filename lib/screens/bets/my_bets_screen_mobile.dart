import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../theme/app_theme.dart';
import '../../widgets/mobile_top_section.dart';
import '../../services/firebase_service.dart';
import '../../providers/auth_provider.dart';

class MyBetsScreenMobile extends StatefulWidget {
  const MyBetsScreenMobile({Key? key}) : super(key: key);

  @override
  State<MyBetsScreenMobile> createState() => _MyBetsScreenMobileState();
}

class _MyBetsScreenMobileState extends State<MyBetsScreenMobile> {
  String _selectedTab = AppStrings.liveStatus;
  int _selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.currentUser;
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
            child: user == null
                ? Center(
                    child: Text('You must be logged in to view your bets.'))
                : StreamBuilder<QuerySnapshot>(
                    stream: FirebaseService.getUserBets(user.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No bets yet.'));
                      }
                      final bets = snapshot.data!.docs;
                      return ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: bets.length,
                        itemBuilder: (context, index) {
                          final bet =
                              bets[index].data() as Map<String, dynamic>?;
                          final description =
                              bet?['description'] ?? 'No Description';
                          final amount = bet?['amount']?.toString() ?? 'N/A';
                          final prediction = bet?['prediction'] ?? 'N/A';
                          final target = bet?['target']?.toString() ?? 'N/A';
                          final endDate = bet?['endDate'] != null
                              ? (bet!['endDate'] as Timestamp)
                                  .toDate()
                                  .toLocal()
                                  .toString()
                                  .split(' ')[0]
                              : 'N/A';
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              title: Text(description),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Amount: $amount'),
                                  Text('Prediction: $prediction'),
                                  Text('Target: $target'),
                                  Text('End Date: $endDate'),
                                ],
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {},
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
