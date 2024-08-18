part of 'dge_game_cubit.dart';

@immutable
abstract class DgeGameState {}

class DgeGameInitial extends DgeGameState {}

class DgeGameLoading extends DgeGameState {}

class DgeGameLoaded extends DgeGameState {
  final DgeGameModel? data;

  DgeGameLoaded({required this.data});
}

class DgeGameError extends DgeGameState {
  DgeGameError();
}
