import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:sabanzuri/model/dge_game_model.dart';

import 'package:sabanzuri/utils/app_data.dart';

part 'dge_game_state.dart';

class DgeGameCubit extends Cubit<DgeGameState> {
  DgeGameCubit() : super(DgeGameInitial());

  fetchDgeGameInfo() {
    emit(DgeGameLoading());
    /* Getting data from shared prefs */
    if (AppData.dgeGamesData == '') {
      emit(DgeGameError());
      return;
    }
    Map<String, dynamic> jsonMap = jsonDecode(AppData.dgeGamesData);
    DgeGameModel gameResponse = DgeGameModel.fromJson(jsonMap);

    if (gameResponse.errorCode == 0) {
      emit(DgeGameLoaded(data: gameResponse));
    } else {
      emit(DgeGameError());
    }
  }
}
