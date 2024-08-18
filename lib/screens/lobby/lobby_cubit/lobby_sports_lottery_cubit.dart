import 'package:bloc/bloc.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/screens/lobby/lobby_cubit/lobby_sports_lottery_state.dart';

class LobbySportLotteryCubit extends Cubit<LobbySportLotteryState> {
  Repository repository = Repository();

  LobbySportLotteryCubit() : super(LobbySportLotteryInitial());

  void fetchSportLotteryGames(request) {
    emit(LobbySportLotteryLoading());
    if (request != null) {
      repository.fetchSportLotteryGames(request).then((result) {
        if (result != null) {
          emit(LobbySportLotteryLoaded(sportLotteryResponse: result));
        } else {
          emit(LobbySportLotteryError(error: 'Server Error'));
        }
      });
    }
  }
}
