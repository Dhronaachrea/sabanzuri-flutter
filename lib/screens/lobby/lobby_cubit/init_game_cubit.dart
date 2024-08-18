import 'package:bloc/bloc.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/init_game_state.dart';

class InitGameCubit extends Cubit<InitGameState> {
  Repository repository = Repository();

  InitGameCubit() : super(InitGameInitial());

  void initGames(request) {
    emit(InitGameLoading());
    if (request != null) {
      repository.initGames(request).then((result) {
        if (result != null) {
          emit(InitGameLoaded(initGameResponse: result));
        } else {
          emit(InitGameError(error: 'Server Error'));
        }
      });
    }
  }
}
