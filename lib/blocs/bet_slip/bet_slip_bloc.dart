import 'package:flutter_bloc/flutter_bloc.dart';
import 'bet_slip_event.dart';
import 'bet_slip_state.dart';

class BetSlipBloc extends Bloc<BetSlipEvent, BetSlipState> {
  BetSlipBloc()
      : super(const BetSlipLoaded(
          description: null,
          target: null,
          prediction: 'above',
          endDate: null,
          stake: null,
          betType: 'single',
          isValid: false,
        )) {
    on<AddSelectionEvent>(_onAddSelection);
    on<SetStakeEvent>(_onSetStake);
    on<SetBetTypeEvent>(_onSetBetType);
    on<ClearBetSlipEvent>(_onClearBetSlip);
    on<UpdateDescriptionEvent>(_onUpdateDescription);
    on<UpdateTargetEvent>(_onUpdateTarget);
    on<UpdatePredictionEvent>(_onUpdatePrediction);
    on<UpdateEndDateEvent>(_onUpdateEndDate);
  }

  void _onAddSelection(AddSelectionEvent event, Emitter<BetSlipState> emit) {
    final isValid = _validateBetSlip(
      description: event.description,
      target: event.target,
      prediction: event.prediction,
      endDate: event.endDate,
      stake: state is BetSlipLoaded ? (state as BetSlipLoaded).stake : null,
    );

    emit(BetSlipLoaded(
      description: event.description,
      target: event.target,
      prediction: event.prediction,
      endDate: event.endDate,
      stake: state is BetSlipLoaded ? (state as BetSlipLoaded).stake : null,
      betType:
          state is BetSlipLoaded ? (state as BetSlipLoaded).betType : 'single',
      isValid: isValid,
    ));
  }

  void _onSetStake(SetStakeEvent event, Emitter<BetSlipState> emit) {
    if (state is BetSlipLoaded) {
      final currentState = state as BetSlipLoaded;
      final isValid = _validateBetSlip(
        description: currentState.description,
        target: currentState.target,
        prediction: currentState.prediction,
        endDate: currentState.endDate,
        stake: event.stake,
      );

      emit(currentState.copyWith(
        stake: event.stake,
        isValid: isValid,
      ));
    }
  }

  void _onSetBetType(SetBetTypeEvent event, Emitter<BetSlipState> emit) {
    if (state is BetSlipLoaded) {
      final currentState = state as BetSlipLoaded;
      emit(currentState.copyWith(betType: event.betType));
    }
  }

  void _onClearBetSlip(ClearBetSlipEvent event, Emitter<BetSlipState> emit) {
    emit(const BetSlipLoaded(
      prediction: 'above',
      betType: 'single',
      isValid: false,
    ));
  }

  void _onUpdateDescription(
      UpdateDescriptionEvent event, Emitter<BetSlipState> emit) {
    if (state is BetSlipLoaded) {
      final currentState = state as BetSlipLoaded;
      final isValid = _validateBetSlip(
        description: event.description,
        target: currentState.target,
        prediction: currentState.prediction,
        endDate: currentState.endDate,
        stake: currentState.stake,
      );

      emit(currentState.copyWith(
        description: event.description,
        isValid: isValid,
      ));
    }
  }

  void _onUpdateTarget(UpdateTargetEvent event, Emitter<BetSlipState> emit) {
    if (state is BetSlipLoaded) {
      final currentState = state as BetSlipLoaded;
      final isValid = _validateBetSlip(
        description: currentState.description,
        target: event.target,
        prediction: currentState.prediction,
        endDate: currentState.endDate,
        stake: currentState.stake,
      );

      emit(currentState.copyWith(
        target: event.target,
        isValid: isValid,
      ));
    }
  }

  void _onUpdatePrediction(
      UpdatePredictionEvent event, Emitter<BetSlipState> emit) {
    if (state is BetSlipLoaded) {
      final currentState = state as BetSlipLoaded;
      final isValid = _validateBetSlip(
        description: currentState.description,
        target: currentState.target,
        prediction: event.prediction,
        endDate: currentState.endDate,
        stake: currentState.stake,
      );

      emit(currentState.copyWith(
        prediction: event.prediction,
        isValid: isValid,
      ));
    }
  }

  void _onUpdateEndDate(UpdateEndDateEvent event, Emitter<BetSlipState> emit) {
    if (state is BetSlipLoaded) {
      final currentState = state as BetSlipLoaded;
      final isValid = _validateBetSlip(
        description: currentState.description,
        target: currentState.target,
        prediction: currentState.prediction,
        endDate: event.endDate,
        stake: currentState.stake,
      );

      emit(currentState.copyWith(
        endDate: event.endDate,
        isValid: isValid,
      ));
    }
  }

  bool _validateBetSlip({
    String? description,
    String? target,
    String? prediction,
    DateTime? endDate,
    double? stake,
  }) {
    return description != null &&
        description.isNotEmpty &&
        target != null &&
        target.isNotEmpty &&
        prediction != null &&
        prediction.isNotEmpty &&
        endDate != null &&
        stake != null &&
        stake > 0;
  }
}
