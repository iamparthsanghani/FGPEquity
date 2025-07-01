import 'package:flutter/material.dart';

class BetSlipProvider with ChangeNotifier {
  String? description;
  String? target;
  String prediction = 'above';
  DateTime? endDate;
  double? stake;
  String betType = 'single'; // 'single' or 'multi'

  void setDescription(String value) {
    description = value;
    notifyListeners();
  }

  void setTarget(String value) {
    target = value;
    notifyListeners();
  }

  void setPrediction(String value) {
    prediction = value;
    notifyListeners();
  }

  void setEndDate(DateTime value) {
    endDate = value;
    notifyListeners();
  }

  void setStake(double value) {
    stake = value;
    notifyListeners();
  }

  void setBetType(String type) {
    betType = type;
    notifyListeners();
  }

  void clear() {
    description = null;
    target = null;
    prediction = 'above';
    endDate = null;
    stake = null;
    notifyListeners();
  }

  bool get isValid =>
      description != null &&
      target != null &&
      endDate != null &&
      stake != null &&
      stake! > 0;

  void addSelection({
    required String description,
    required String target,
    required String prediction,
    required DateTime endDate,
  }) {
    this.description = description;
    this.target = target;
    this.prediction = prediction;
    this.endDate = endDate;
    notifyListeners();
  }
}
