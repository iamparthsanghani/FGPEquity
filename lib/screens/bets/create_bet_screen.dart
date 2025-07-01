import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../services/firebase_service.dart';
import '../../utils/theme.dart';
import '../../utils/form_utils.dart';
import '../../constants/app_strings.dart';

class CreateBetScreen extends StatefulWidget {
  const CreateBetScreen({super.key});

  @override
  State<CreateBetScreen> createState() => _CreateBetScreenState();
}

class _CreateBetScreenState extends State<CreateBetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _targetController = TextEditingController();
  final _amountController = TextEditingController();
  final _descriptionFocusNode = FocusNode();
  final _targetFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();
  DateTime? _selectedDate;
  String _selectedPrediction = 'above';

  @override
  void dispose() {
    _descriptionController.dispose();
    _targetController.dispose();
    _amountController.dispose();
    _descriptionFocusNode.dispose();
    _targetFocusNode.dispose();
    _amountFocusNode.dispose();
    super.dispose();
  }

  void _clearFormFields() {
    FormUtils.safeClearFormFields(
      [_descriptionController, _targetController, _amountController],
      [_descriptionFocusNode, _targetFocusNode, _amountFocusNode],
    );

    // Reset other form state
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        setState(() {
          _selectedDate = null;
          _selectedPrediction = 'above';
        });
      }
    });
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _createBet() async {
    if (_formKey.currentState!.validate() && _selectedDate != null) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final user = authProvider.currentUser;

      if (user != null) {
        final amount = double.tryParse(_amountController.text) ?? 0.0;
        final userProfile = authProvider.userProfile;

        if (userProfile != null && amount > userProfile.balance) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(AppStrings.insufficientBalanceForThisBet),
              backgroundColor: AppTheme.errorColor,
            ),
          );
          return;
        }

        final betData = {
          'amount': amount,
          'prediction': _selectedPrediction,
          'target': _targetController.text,
          'endDate': _selectedDate,
          'description': _descriptionController.text,
        };

        await FirebaseService.createBet(user.uid, betData);

        if (mounted) {
          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  const Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.betCreatedSuccessfully,
                          style: AppTheme.bodyMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          AppStrings.yourPredictionHasBeenRecordedGoodLuck,
                          style: AppTheme.bodySmall.copyWith(
                            color: Colors.white.withAlpha(230),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              backgroundColor: AppTheme.successColor,
              duration: const Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );

          // Clear form fields
          _clearFormFields();

          // Navigate back after a short delay to ensure form is cleared
          Future.delayed(const Duration(milliseconds: 150), () {
            if (mounted) {
              Navigator.pop(context);
            }
          });
        }
      }
    } else if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.pleaseSelectEndDate),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.createBet),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Description Field
              TextFormField(
                controller: _descriptionController,
                focusNode: _descriptionFocusNode,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: AppStrings.betDescription,
                  hintText: AppStrings.describeWhatYoureBettingOn,
                  prefixIcon: const Icon(Icons.description),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.pleaseEnterADescription;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Target Field
              TextFormField(
                controller: _targetController,
                focusNode: _targetFocusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppStrings.salesTarget,
                  hintText: AppStrings.eG2000,
                  prefixIcon: const Icon(Icons.attach_money),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.pleaseEnterASalesTarget;
                  }
                  if (double.tryParse(value) == null) {
                    return AppStrings.pleaseEnterAValidNumber;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Prediction Type
              Text(
                AppStrings.prediction,
                style: AppTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text(AppStrings.above),
                      value: 'above',
                      groupValue: _selectedPrediction,
                      onChanged: (value) {
                        setState(() {
                          _selectedPrediction = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: const Text(AppStrings.below),
                      value: 'below',
                      groupValue: _selectedPrediction,
                      onChanged: (value) {
                        setState(() {
                          _selectedPrediction = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // End Date
              Text(
                AppStrings.endDate,
                style: AppTheme.bodyLarge.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: _selectDate,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 12),
                      Text(
                        _selectedDate != null
                            ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                            : AppStrings.selectEndDate,
                        style: AppTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Bet Amount
              TextFormField(
                controller: _amountController,
                focusNode: _amountFocusNode,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: AppStrings.betAmount,
                  hintText: AppStrings.eG20,
                  prefixIcon: const Icon(Icons.account_balance_wallet),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return AppStrings.pleaseEnterABetAmount;
                  }
                  final amount = double.tryParse(value);
                  if (amount == null || amount <= 0) {
                    return AppStrings.pleaseEnterAValidAmount;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // Create Bet Button
              Consumer<AuthProvider>(
                builder: (context, authProvider, child) {
                  return ElevatedButton(
                    onPressed: authProvider.isLoading ? null : _createBet,
                    child: authProvider.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(AppStrings.createBet),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
