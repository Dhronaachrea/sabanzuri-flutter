import 'package:sabanzuri/screens/lobby/lobby_model/ige_game_response.dart';

abstract class LobbyIgeGameState {}

class LobbyIgeGameInitial extends LobbyIgeGameState {}

class LobbyIgeGameLoading extends LobbyIgeGameState {}

class LobbyIgeGameError extends LobbyIgeGameState {
  final String error;

  LobbyIgeGameError({required this.error});
}

class LobbyIgeGameLoaded extends LobbyIgeGameState {
  IgeGameResponse igeGameResponse;
  LobbyIgeGameLoaded({required this.igeGameResponse});
}
