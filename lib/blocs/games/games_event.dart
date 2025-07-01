import 'package:equatable/equatable.dart';

abstract class GamesEvent extends Equatable {
  const GamesEvent();

  @override
  List<Object?> get props => [];
}

class LoadLiveGamesEvent extends GamesEvent {
  const LoadLiveGamesEvent();
}

class LoadUpcomingGamesEvent extends GamesEvent {
  const LoadUpcomingGamesEvent();
}

class RefreshGamesEvent extends GamesEvent {
  const RefreshGamesEvent();
}

class CreateGameEvent extends GamesEvent {
  final Map<String, dynamic> gameData;

  const CreateGameEvent(this.gameData);

  @override
  List<Object?> get props => [gameData];
}

class UpdateGameEvent extends GamesEvent {
  final String gameId;
  final Map<String, dynamic> gameData;

  const UpdateGameEvent({
    required this.gameId,
    required this.gameData,
  });

  @override
  List<Object?> get props => [gameId, gameData];
}

class DeleteGameEvent extends GamesEvent {
  final String gameId;

  const DeleteGameEvent(this.gameId);

  @override
  List<Object?> get props => [gameId];
}
