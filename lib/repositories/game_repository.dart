import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants/app_constants.dart';

abstract class IGameRepository {
  Stream<QuerySnapshot> getLiveGames();
  Stream<QuerySnapshot> getUpcomingGames();
  Future<void> createGame(Map<String, dynamic> gameData);
  Future<void> updateGame(String gameId, Map<String, dynamic> gameData);
  Future<void> deleteGame(String gameId);
}

class GameRepository implements IGameRepository {
  final FirebaseFirestore _firestore;

  GameRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot> getLiveGames() {
    return _firestore
        .collection(AppConstants.gamesCollection)
        .where('status', isEqualTo: AppConstants.liveStatus)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot> getUpcomingGames() {
    return _firestore
        .collection(AppConstants.gamesCollection)
        .where('status', isEqualTo: AppConstants.upcomingStatus)
        .snapshots();
  }

  @override
  Future<void> createGame(Map<String, dynamic> gameData) async {
    await _firestore.collection(AppConstants.gamesCollection).add(gameData);
  }

  @override
  Future<void> updateGame(String gameId, Map<String, dynamic> gameData) async {
    await _firestore
        .collection(AppConstants.gamesCollection)
        .doc(gameId)
        .update(gameData);
  }

  @override
  Future<void> deleteGame(String gameId) async {
    await _firestore
        .collection(AppConstants.gamesCollection)
        .doc(gameId)
        .delete();
  }
}
