import 'package:equatable/equatable.dart';

abstract class BetSlipEvent extends Equatable {
  const BetSlipEvent();

  @override
  List<Object?> get props => [];
}

class AddSelectionEvent extends BetSlipEvent {
  final String description;
  final String target;
  final String prediction;
  final DateTime endDate;

  const AddSelectionEvent({
    required this.description,
    required this.target,
    required this.prediction,
    required this.endDate,
  });

  @override
  List<Object?> get props => [description, target, prediction, endDate];
}

class SetStakeEvent extends BetSlipEvent {
  final double stake;

  const SetStakeEvent(this.stake);

  @override
  List<Object?> get props => [stake];
}

class SetBetTypeEvent extends BetSlipEvent {
  final String betType;

  const SetBetTypeEvent(this.betType);

  @override
  List<Object?> get props => [betType];
}

class ClearBetSlipEvent extends BetSlipEvent {
  const ClearBetSlipEvent();
}

class UpdateDescriptionEvent extends BetSlipEvent {
  final String description;

  const UpdateDescriptionEvent(this.description);

  @override
  List<Object?> get props => [description];
}

class UpdateTargetEvent extends BetSlipEvent {
  final String target;

  const UpdateTargetEvent(this.target);

  @override
  List<Object?> get props => [target];
}

class UpdatePredictionEvent extends BetSlipEvent {
  final String prediction;

  const UpdatePredictionEvent(this.prediction);

  @override
  List<Object?> get props => [prediction];
}

class UpdateEndDateEvent extends BetSlipEvent {
  final DateTime endDate;

  const UpdateEndDateEvent(this.endDate);

  @override
  List<Object?> get props => [endDate];
}
