import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../repositories/game_repository.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_strings.dart';
import 'games_event.dart';
import 'games_state.dart';

class GamesBloc extends Bloc<GamesEvent, GamesState> {
  final IGameRepository _gameRepository;

  GamesBloc({required IGameRepository gameRepository})
      : _gameRepository = gameRepository,
        super(const GamesInitial()) {
    on<LoadLiveGamesEvent>(_onLoadLiveGames);
    on<LoadUpcomingGamesEvent>(_onLoadUpcomingGames);
    on<RefreshGamesEvent>(_onRefreshGames);
    on<CreateGameEvent>(_onCreateGame);
    on<UpdateGameEvent>(_onUpdateGame);
    on<DeleteGameEvent>(_onDeleteGame);
  }

  void _onLoadLiveGames(
      LoadLiveGamesEvent event, Emitter<GamesState> emit) async {
    try {
      emit(const GamesLoading());

      await emit.onEach<QuerySnapshot>(
        _gameRepository.getLiveGames(),
        onData: (QuerySnapshot snapshot) {
          if (snapshot.docs.isEmpty) {
            emit(GamesEmpty(AppStrings.noLiveEventsAvailable));
          } else {
            emit(LiveGamesLoaded(snapshot.docs));
          }
        },
      );
    } catch (e) {
      emit(GamesError('${AppStrings.errorLoadingLiveEvents}: $e'));
    }
  }

  void _onLoadUpcomingGames(
      LoadUpcomingGamesEvent event, Emitter<GamesState> emit) async {
    try {
      emit(const GamesLoading());

      await emit.onEach<QuerySnapshot>(
        _gameRepository.getUpcomingGames(),
        onData: (QuerySnapshot snapshot) {
          if (snapshot.docs.isEmpty) {
            emit(GamesEmpty(AppStrings.noUpcomingEventsAvailable));
          } else {
            emit(UpcomingGamesLoaded(snapshot.docs));
          }
        },
      );
    } catch (e) {
      emit(GamesError('${AppStrings.errorLoadingUpcomingEvents}: $e'));
    }
  }

  void _onRefreshGames(
      RefreshGamesEvent event, Emitter<GamesState> emit) async {
    try {
      emit(const GamesLoading());
      // Refresh both live and upcoming games
      add(const LoadLiveGamesEvent());
      add(const LoadUpcomingGamesEvent());
    } catch (e) {
      emit(GamesError('Error refreshing games: $e'));
    }
  }

  void _onCreateGame(CreateGameEvent event, Emitter<GamesState> emit) async {
    try {
      await _gameRepository.createGame(event.gameData);
      emit(const GameOperationSuccess('Game created successfully'));
    } catch (e) {
      emit(GameOperationError('Error creating game: $e'));
    }
  }

  void _onUpdateGame(UpdateGameEvent event, Emitter<GamesState> emit) async {
    try {
      await _gameRepository.updateGame(event.gameId, event.gameData);
      emit(const GameOperationSuccess('Game updated successfully'));
    } catch (e) {
      emit(GameOperationError('Error updating game: $e'));
    }
  }

  void _onDeleteGame(DeleteGameEvent event, Emitter<GamesState> emit) async {
    try {
      await _gameRepository.deleteGame(event.gameId);
      emit(const GameOperationSuccess('Game deleted successfully'));
    } catch (e) {
      emit(GameOperationError('Error deleting game: $e'));
    }
  }
}
