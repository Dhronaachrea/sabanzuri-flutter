import 'package:sabanzuri/utils/shared_prefs.dart';

class AppData {
  static final AppData _instance = AppData._ctor();

  factory AppData() {
    return _instance;
  }

  AppData._ctor();

  static setDgeGameData(String data) {
    SharedPrefUtils.dgeGamesData = data;
  }

  static setIgeGameData(String data) {
    SharedPrefUtils.igeGamesData = data;
  }

  static setIsDarkThemeOn(String data) {
    SharedPrefUtils.isDarkThemeOn = data;
  }

  static setVersionResponse(String data) {
    SharedPrefUtils.versionResponse = data;
  }

  static String get dgeGamesData => SharedPrefUtils.dgeGamesData;

  static String get igeGamesData => SharedPrefUtils.igeGamesData;

  static String get isDarkThemeOn => SharedPrefUtils.isDarkThemeOn;

  static String get versionResponse => SharedPrefUtils.versionResponse;
}
