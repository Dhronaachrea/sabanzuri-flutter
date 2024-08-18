import 'package:sabanzuri/screens/lobby/lobby_model/draw_game_response.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/init_game_response.dart';

abstract class InitGameState {}

class InitGameInitial extends InitGameState {}

class InitGameLoading extends InitGameState {}

class InitGameError extends InitGameState {
  final String error;

  InitGameError({required this.error});
}

class InitGameLoaded extends InitGameState {
  InitGameResponse initGameResponse;

  InitGameLoaded({required this.initGameResponse});
}
