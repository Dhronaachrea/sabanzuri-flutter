import 'package:sabanzuri/screens/lobby/lobby_model/NewDrawGamesResponse.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/draw_game_response.dart';

abstract class LobbyDrawGameState {}

class LobbyDrawGameInitial extends LobbyDrawGameState {}

class LobbyDrawGameLoading extends LobbyDrawGameState {}

class LobbyDrawGameError extends LobbyDrawGameState {
  final String error;

  LobbyDrawGameError({required this.error});
}

class LobbyDrawGameLoaded extends LobbyDrawGameState {
  NewDrawGamesResponse drawGameResponse;

  LobbyDrawGameLoaded({required this.drawGameResponse});
}
