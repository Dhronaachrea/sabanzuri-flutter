import 'package:bloc/bloc.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/lobby_draw_game_state.dart';

class LobbyDrawGameCubit extends Cubit<LobbyDrawGameState> {
  Repository repository = Repository();

  LobbyDrawGameCubit() : super(LobbyDrawGameInitial());

  void fetchDrawGames(request) {
    emit(LobbyDrawGameLoading());
    if (request != null) {
      repository.fetchDrawGames(request).then((result) {
        if (result != null) {
          emit(LobbyDrawGameLoaded(drawGameResponse: result));
        } else {
          emit(LobbyDrawGameError(error: 'Server Error'));
        }
      });
    }
  }
}
