import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Service class for Firebase operations including authentication and Firestore.
///
/// Provides centralized methods for user authentication, profile management,
/// and data operations with Firebase services.
class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Authentication methods

  /// Signs up a new user with email and password, and creates their profile.
  ///
  /// [email] - User's email address
  /// [password] - User's password
  /// [fullName] - User's full name
  /// Returns UserCredential on success, null on failure
  static Future<UserCredential?> signUpWithEmailAndPassword(
      String email, String password, String fullName) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Create user profile in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'email': email,
        'createdAt': FieldValue.serverTimestamp(),
        'balance': 1000.0, // Starting balance
        'totalBets': 0,
        'wins': 0,
        'losses': 0,
      });

      return userCredential;
    } catch (e) {
      return null;
    }
  }

  /// Signs in an existing user with email and password.
  ///
  /// [email] - User's email address
  /// [password] - User's password
  /// Returns UserCredential on success, null on failure
  static Future<UserCredential?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      return null;
    }
  }

  /// Signs out the current user.
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Gets the currently authenticated user.
  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Stream of authentication state changes.
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  // User profile methods

  /// Retrieves a user's profile data from Firestore.
  ///
  /// [userId] - The user's unique ID
  /// Returns user profile data as Map, or null if not found
  static Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('users').doc(userId).get();
      return doc.data() as Map<String, dynamic>?;
    } catch (e) {
      return null;
    }
  }

  /// Updates a user's profile data in Firestore.
  ///
  /// [userId] - The user's unique ID
  /// [data] - The data to update
  static Future<void> updateUserProfile(
      String userId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection('users').doc(userId).update(data);
    } catch (e) {
      // debugPrint('Error updating user profile: $e');
    }
  }

  // Betting methods

  /// Creates a new bet in Firestore.
  ///
  /// [userId] - The user's unique ID
  /// [betData] - The bet data to store
  static Future<void> createBet(
      String userId, Map<String, dynamic> betData) async {
    try {
      await _firestore.collection('bets').add({
        'userId': userId,
        'amount': betData['amount'],
        'prediction': betData['prediction'],
        'target': betData['target'],
        'status': 'active',
        'createdAt': FieldValue.serverTimestamp(),
        'endDate': betData['endDate'],
        'description': betData['description'],
      });
    } catch (e) {
      // debugPrint('Error creating bet: $e');
    }
  }

  /// Retrieves all bets for a specific user.
  ///
  /// [userId] - The user's unique ID
  /// Returns a stream of bet documents
  static Stream<QuerySnapshot> getUserBets(String userId) {
    return _firestore
        .collection('bets')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Retrieves all bets from the system.
  ///
  /// Returns a stream of all bet documents
  static Stream<QuerySnapshot> getAllBets() {
    return _firestore
        .collection('bets')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Updates the status of a specific bet.
  ///
  /// [betId] - The bet's unique ID
  /// [status] - The new status to set
  static Future<void> updateBetStatus(String betId, String status) async {
    try {
      await _firestore.collection('bets').doc(betId).update({
        'status': status,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      // debugPrint('Error updating bet status: $e');
    }
  }
}
