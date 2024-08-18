import 'package:bloc/bloc.dart';
import '../../../repo/repository.dart';
import 'game_list_state.dart';

class GameListCubit extends Cubit<GameListState> {
  Repository repository = Repository();

  GameListCubit() : super(GameListInitial());

  // void fetchGameList(result) {
  //   // repository.fetchGameList().then((result) {
  //   if (result != null) {
  //     emit(GameListLoaded(gameList: result));
  //   } else {
  //     print("`"*100);
  //     emit(GameListError(error: "Instant Games List Error"));
  //   }
  //   // });
  // }

  void fetchGameList(gameName) {
    emit(GameListLoaded(gameName: gameName));
  }
}
