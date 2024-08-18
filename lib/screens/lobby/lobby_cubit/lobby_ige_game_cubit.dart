import 'package:bloc/bloc.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/lobby_ige_game_state.dart';

class LobbyIgeGameCubit extends Cubit<LobbyIgeGameState> {
  Repository repository = Repository();

  LobbyIgeGameCubit() : super(LobbyIgeGameInitial());

  void fetchIgeGames(request) {
    emit(LobbyIgeGameLoading());
    if (request != null) {
      repository.fetchIgeGames(request).then((result) {
        if (result != null) {
          emit(LobbyIgeGameLoaded(igeGameResponse: result));
        } else {
          emit(LobbyIgeGameError(error: 'Server Error'));
        }
      });
    }
  }
}
