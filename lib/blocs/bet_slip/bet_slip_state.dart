import 'package:equatable/equatable.dart';

abstract class BetSlipState extends Equatable {
  const BetSlipState();

  @override
  List<Object?> get props => [];
}

class BetSlipInitial extends BetSlipState {
  const BetSlipInitial();
}

class BetSlipLoading extends BetSlipState {
  const BetSlipLoading();
}

class BetSlipLoaded extends BetSlipState {
  final String? description;
  final String? target;
  final String prediction;
  final DateTime? endDate;
  final double? stake;
  final String betType;
  final bool isValid;

  const BetSlipLoaded({
    this.description,
    this.target,
    this.prediction = 'above',
    this.endDate,
    this.stake,
    this.betType = 'single',
    required this.isValid,
  });

  BetSlipLoaded copyWith({
    String? description,
    String? target,
    String? prediction,
    DateTime? endDate,
    double? stake,
    String? betType,
    bool? isValid,
  }) {
    return BetSlipLoaded(
      description: description ?? this.description,
      target: target ?? this.target,
      prediction: prediction ?? this.prediction,
      endDate: endDate ?? this.endDate,
      stake: stake ?? this.stake,
      betType: betType ?? this.betType,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [
        description,
        target,
        prediction,
        endDate,
        stake,
        betType,
        isValid,
      ];
}

class BetSlipError extends BetSlipState {
  final String message;

  const BetSlipError(this.message);

  @override
  List<Object?> get props => [message];
}
