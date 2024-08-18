import 'package:sabanzuri/model/ige_game_model.dart';

abstract class IgeGameState {}

class IgeGameInitial extends IgeGameState {}

class IgeGameLoading extends IgeGameState {}

class IgeGameLoaded extends IgeGameState {
  final IgeGameModel? data;

  IgeGameLoaded({required this.data});
}

class IgeGameError extends IgeGameState {
  IgeGameError();
}
