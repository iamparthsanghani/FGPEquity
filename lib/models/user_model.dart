import 'package:cloud_firestore/cloud_firestore.dart';

/// Data model representing a user in the SalesBets application.
///
/// Contains user profile information including authentication details,
/// betting statistics, and account balance.
class UserModel {
  final String id;
  final String fullName;
  final String email;
  final double balance;
  final int totalBets;
  final int wins;
  final int losses;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.fullName,
    required this.email,
    required this.balance,
    required this.totalBets,
    required this.wins,
    required this.losses,
    required this.createdAt,
  });

  /// Creates a UserModel instance from Firestore document data.
  ///
  /// [id] - The document ID from Firestore
  /// [map] - The document data as a Map<String, dynamic>
  factory UserModel.fromMap(String id, Map<String, dynamic> map) {
    return UserModel(
      id: id,
      fullName: map['fullName'] ?? '',
      email: map['email'] ?? '',
      balance: (map['balance'] ?? 0.0).toDouble(),
      totalBets: map['totalBets'] ?? 0,
      wins: map['wins'] ?? 0,
      losses: map['losses'] ?? 0,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Converts the UserModel to a Map for Firestore storage.
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'balance': balance,
      'totalBets': totalBets,
      'wins': wins,
      'losses': losses,
      'createdAt': createdAt,
    };
  }

  /// Creates a copy of this UserModel with the given fields replaced.
  UserModel copyWith({
    String? id,
    String? fullName,
    String? email,
    double? balance,
    int? totalBets,
    int? wins,
    int? losses,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      balance: balance ?? this.balance,
      totalBets: totalBets ?? this.totalBets,
      wins: wins ?? this.wins,
      losses: losses ?? this.losses,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
