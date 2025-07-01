import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firebase_service.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  User? _currentUser;
  UserModel? _userProfile;
  bool _isLoading = false;

  User? get currentUser => _currentUser;
  UserModel? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;

  AuthProvider() {
    _init();
  }

  void _init() {
    FirebaseService.authStateChanges.listen((User? user) {
      print('Auth state changed: ' + (user?.uid ?? 'null'));
      _currentUser = user;
      if (user != null) {
        _loadUserProfile(user.uid);
      } else {
        _userProfile = null;
      }
      notifyListeners();
    });
  }

  Future<void> _loadUserProfile(String userId) async {
    try {
      final profileData = await FirebaseService.getUserProfile(userId);
      if (profileData != null) {
        _userProfile = UserModel.fromMap(userId, profileData);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Error loading user profile: $e');
    }
  }

  Future<bool> signUp(String email, String password, String fullName) async {
    _setLoading(true);
    try {
      final result = await FirebaseService.signUpWithEmailAndPassword(
        email,
        password,
        fullName,
      );
      _setLoading(false);
      return result != null;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    try {
      final result = await FirebaseService.signInWithEmailAndPassword(
        email,
        password,
      );
      _setLoading(false);
      return result != null;
    } catch (e) {
      _setLoading(false);
      return false;
    }
  }

  Future<void> signOut() async {
    _setLoading(true);
    try {
      await FirebaseService.signOut();
      _currentUser = null;
      _userProfile = null;
    } catch (e) {
      debugPrint('Error signing out: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  Future<void> updateUserProfile(Map<String, dynamic> data) async {
    if (_currentUser != null) {
      await FirebaseService.updateUserProfile(_currentUser!.uid, data);
      await _loadUserProfile(_currentUser!.uid);
    }
  }
}
