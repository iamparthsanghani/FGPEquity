import 'package:cloud_firestore/cloud_firestore.dart';

/// Data model representing a bet in the SalesBets application.
///
/// Contains bet information including amount, prediction, target,
/// status, and timing details.
class BetModel {
  final String id;
  final String userId;
  final double amount;
  final String prediction;
  final String target;
  final String status;
  final DateTime createdAt;
  final DateTime? endDate;
  final String description;
  final DateTime? updatedAt;

  BetModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.prediction,
    required this.target,
    required this.status,
    required this.createdAt,
    this.endDate,
    required this.description,
    this.updatedAt,
  });

  /// Creates a BetModel instance from Firestore document data.
  ///
  /// [id] - The document ID from Firestore
  /// [map] - The document data as a Map<String, dynamic>
  factory BetModel.fromMap(String id, Map<String, dynamic> map) {
    return BetModel(
      id: id,
      userId: map['userId'] ?? '',
      amount: (map['amount'] ?? 0.0).toDouble(),
      prediction: map['prediction'] ?? '',
      target: map['target'] ?? '',
      status: map['status'] ?? 'active',
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      endDate: (map['endDate'] as Timestamp?)?.toDate(),
      description: map['description'] ?? '',
      updatedAt: (map['updatedAt'] as Timestamp?)?.toDate(),
    );
  }

  /// Converts the BetModel to a Map for Firestore storage.
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'amount': amount,
      'prediction': prediction,
      'target': target,
      'status': status,
      'createdAt': createdAt,
      'endDate': endDate,
      'description': description,
      'updatedAt': updatedAt,
    };
  }

  /// Creates a copy of this BetModel with the given fields replaced.
  BetModel copyWith({
    String? id,
    String? userId,
    double? amount,
    String? prediction,
    String? target,
    String? status,
    DateTime? createdAt,
    DateTime? endDate,
    String? description,
    DateTime? updatedAt,
  }) {
    return BetModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      prediction: prediction ?? this.prediction,
      target: target ?? this.target,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
