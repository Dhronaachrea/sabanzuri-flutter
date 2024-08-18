abstract class GameListState {}

class GameListInitial extends GameListState {}

class GameListLoading extends GameListState {}

class GameListLoaded extends GameListState {
  // GameListModel gameList;
  // GameListLoaded({required this.gameList});
  String gameName;

  GameListLoaded({required this.gameName});
}

class GameListError extends GameListState {
  final String error;

  GameListError({required this.error});
}
