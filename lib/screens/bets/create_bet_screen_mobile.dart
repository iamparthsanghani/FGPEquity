import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_strings.dart';
import '../../theme/app_theme.dart';
import '../../widgets/mobile_top_section.dart';
import '../../services/firebase_service.dart';
import '../../providers/auth_provider.dart';

class CreateBetScreenMobile extends StatefulWidget {
  const CreateBetScreenMobile({Key? key}) : super(key: key);

  @override
  State<CreateBetScreenMobile> createState() => _CreateBetScreenMobileState();
}

class _CreateBetScreenMobileState extends State<CreateBetScreenMobile> {
  String _selectedTab = AppStrings.liveStatus;
  int _selectedCategoryIndex = 0;

  final _formKey = GlobalKey<FormState>();
  final _descController = TextEditingController();
  final _amountController = TextEditingController();
  final _targetController = TextEditingController();
  String _prediction = AppStrings.above;
  DateTime? _endDate;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _descController.dispose();
    _amountController.dispose();
    _targetController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate() || _endDate == null) return;
    setState(() => _isSubmitting = true);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.currentUser;
    if (user == null) {
      setState(() => _isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You must be logged in to create a bet.')),
      );
      return;
    }
    final betData = {
      'description': _descController.text.trim(),
      'amount': double.tryParse(_amountController.text.trim()) ?? 0,
      'target': _targetController.text.trim(),
      'prediction': _prediction,
      'endDate': _endDate,
    };
    try {
      await FirebaseService.createBet(user.uid, betData);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bet created successfully!')),
      );
      _formKey.currentState!.reset();
      _descController.clear();
      _amountController.clear();
      _targetController.clear();
      setState(() => _endDate = null);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to create bet: $e')),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

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
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Text(AppStrings.betDescription,
                        style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descController,
                      decoration: InputDecoration(
                        labelText: AppStrings.betDescription,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Enter a description' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _amountController,
                      decoration: InputDecoration(
                        labelText: AppStrings.betAmount,
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Enter an amount' : null,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _targetController,
                      decoration: InputDecoration(
                        labelText: AppStrings.salesTarget,
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Enter a target' : null,
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: _prediction,
                      items: [
                        DropdownMenuItem(
                            value: AppStrings.above,
                            child: Text(AppStrings.above)),
                        DropdownMenuItem(
                            value: AppStrings.below,
                            child: Text(AppStrings.below)),
                      ],
                      onChanged: (v) =>
                          setState(() => _prediction = v ?? AppStrings.above),
                      decoration: InputDecoration(
                        labelText: AppStrings.prediction,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(_endDate == null
                          ? AppStrings.selectEndDate
                          : 'End Date: ${_endDate!.toLocal().toString().split(' ')[0]}'),
                      trailing: Icon(Icons.calendar_today),
                      onTap: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate:
                              DateTime.now().add(const Duration(days: 1)),
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        );
                        if (picked != null) setState(() => _endDate = picked);
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _isSubmitting ? null : _submit,
                      child: _isSubmitting
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white))
                          : Text(AppStrings.placeBetLabel),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonPrimary,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(48),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
