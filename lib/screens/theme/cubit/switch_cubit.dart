import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:sabanzuri/screens/theme/theme_data.dart';
import 'package:sabanzuri/utils/app_data.dart';

part 'switch_state.dart';

class SwitchCubit extends Cubit<SwitchState> {
  SwitchCubit()
      : super(
          SwitchState(
              isDarkThemeOn: AppData.isDarkThemeOn == "N" ? true : false),
        );

  void toggleSwitch(bool value) {
    AppData.setIsDarkThemeOn(value ? "N" : "Y");
    emit(state.copyWith(changeState: value));
  }
}
