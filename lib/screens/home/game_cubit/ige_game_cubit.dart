import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:sabanzuri/model/ige_game_model.dart';
import 'package:sabanzuri/screens/home/game_cubit/ige_game_state.dart';
import 'package:sabanzuri/utils/app_data.dart';

class IgeGameCubit extends Cubit<IgeGameState> {
  IgeGameCubit() : super(IgeGameInitial());

  fetchIgeGameInfo() {
    emit(IgeGameLoading());
    /* Getting data from shared prefs */
    if (AppData.igeGamesData == '') {
      emit(IgeGameError());
      return;
    }
    Map<String, dynamic> jsonMap = jsonDecode(AppData.igeGamesData);
    IgeGameModel gameResponse = IgeGameModel.fromJson(jsonMap);
    if (gameResponse.success) {
      emit(IgeGameLoaded(data: gameResponse));
    } else {
      emit(IgeGameError());
    }
  }
}
