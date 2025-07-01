import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class GamesState extends Equatable {
  const GamesState();

  @override
  List<Object?> get props => [];
}

class GamesInitial extends GamesState {
  const GamesInitial();
}

class GamesLoading extends GamesState {
  const GamesLoading();
}

class LiveGamesLoaded extends GamesState {
  final List<QueryDocumentSnapshot> games;

  const LiveGamesLoaded(this.games);

  @override
  List<Object?> get props => [games];
}

class UpcomingGamesLoaded extends GamesState {
  final List<QueryDocumentSnapshot> games;

  const UpcomingGamesLoaded(this.games);

  @override
  List<Object?> get props => [games];
}

class GamesEmpty extends GamesState {
  final String message;

  const GamesEmpty(this.message);

  @override
  List<Object?> get props => [message];
}

class GamesError extends GamesState {
  final String message;

  const GamesError(this.message);

  @override
  List<Object?> get props => [message];
}

class GameOperationSuccess extends GamesState {
  final String message;

  const GameOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class GameOperationError extends GamesState {
  final String message;

  const GameOperationError(this.message);

  @override
  List<Object?> get props => [message];
}
