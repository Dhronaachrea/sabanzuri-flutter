import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static const _APP_PREF = "APP_PREF";
  static const _USER_PREF = "USER_PREF";

  static const _DGE_GAMES_DATA = "DgeGamesData";
  static const _IGE_GAMES_DATA = "IgeGamesData";
  static const _IS_DARK_THEME_ON = "isDarkThemeOn";

  static const _PLAYER_TOKEN = "playerToken";
  static const _PLAYER_ID = "playerId";
  static const _CURRENCY_DISPLAY_CODE = "currencyDisplayCode";
  static const _PLAYER_USER_NAME = "userName";
  static const _REGISTRATION_RESPONSE = "registrationResponse";
  static const _VERSION_RESPONSE = "versionResponse";
  static const _CASH_BALANCE = "cashBalance";
  static const _TOTAL_BALANCE = "totalBalance";
  static const _MOB_NUMBER = "mobNumber";
  static const _EMAIL = "email";
  static const _GENDER = "gender";
  static const _DOB = "dob";
  static const _ADDRESS = "address";
  static const _PROFILE_IMAGE = "profileImage";
  static const _FIRST_NAME = "firstName";
  static const _LAST_NAME = "lastName";
  static const _CURRENCY_CODE = "currencyCode";
  static const _REFER_CODE = "referCode";
  static const _COUNTRY_NAME = "countryName";
  static const _FORCE_UPDATE_PASSWORD = "forceUpdatePassword";
  static const _PROFILE_TYPE = "profileType";

  static final SharedPrefUtils _instance = SharedPrefUtils._ctor();

  factory SharedPrefUtils() {
    return _instance;
  }

  SharedPrefUtils._ctor();

  static late SharedPreferences _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // APP_DATA functions

  static setAppStringValue(String key, String value) {
    final String? storedData =
        _prefs.containsKey(_APP_PREF) ? _prefs.getString(_APP_PREF)! : null;
    Map newData = {key: value};
    Map newDataMap = {};

    if (storedData != null) {
      newDataMap.addAll(jsonDecode(storedData));
      newDataMap.addAll(newData);
    } else {
      newDataMap = newData;
    }

    _prefs.setString(_APP_PREF, jsonEncode(newDataMap));
  }

  static String getAppStringValue(String key) {
    Map<String, dynamic> allPrefs = _prefs.getString(_APP_PREF) != null
        ? jsonDecode(_prefs.getString(_APP_PREF) ?? '')
        : {};

    return allPrefs[key] ?? "";
  }

  static Map<String, dynamic> getAllAppPrefs() {
    Map<String, dynamic> allPrefs = _prefs.containsKey(_APP_PREF)
        ? jsonDecode(_prefs.getString(_APP_PREF)!)
        : {};
    return allPrefs;
  }

  // USER_DATA functions

  static setUserStringValue(String key, String value) {
    final String? storedData =
        _prefs.containsKey(_USER_PREF) ? _prefs.getString(_USER_PREF) : null;
    Map newData = {key: value};
    Map newDataMap = {};

    if (storedData != null) {
      newDataMap.addAll(jsonDecode(storedData));
      newDataMap.addAll(newData);
    } else {
      newDataMap = newData;
    }

    _prefs.setString(_USER_PREF, jsonEncode(newDataMap));
  }

  static String getUserStringValue(String key) {
    Map<String, dynamic> allPrefs = _prefs.getString(_USER_PREF) != null
        ? jsonDecode(_prefs.getString(_USER_PREF) ?? '')
        : {};
    return allPrefs[key] ?? '';
  }

  static Map<String, dynamic> getAllUserPrefs() {
    Map<String, dynamic> allPrefs = _prefs.containsKey(_USER_PREF)
        ? jsonDecode(_prefs.getString(_USER_PREF)!)
        : {};
    return allPrefs;
  }

  static removeValue(String key) {
    return _prefs.remove(key);
  }

  static String get playerToken => getUserStringValue(_PLAYER_TOKEN);

  static String get playerId => getUserStringValue(_PLAYER_ID);

  static String get currencyDisplayCode => getUserStringValue(_CURRENCY_DISPLAY_CODE);

  static String get userName => getUserStringValue(_PLAYER_USER_NAME);

  static String get registrationResponse =>
      getUserStringValue(_REGISTRATION_RESPONSE);

  static String get versionResponse => getAppStringValue(_VERSION_RESPONSE);

  static String get cashBalance => getUserStringValue(_CASH_BALANCE);

  static String get totalBalance => getUserStringValue(_TOTAL_BALANCE);

  static String get mobNumber => getUserStringValue(_MOB_NUMBER);

  static String get email => getUserStringValue(_EMAIL);

  static String get gender => getUserStringValue(_GENDER);

  static String get dob => getUserStringValue(_DOB);

  static String get address => getUserStringValue(_ADDRESS);

  static String get profileImage => getUserStringValue(_PROFILE_IMAGE);

  static String get firstName => getUserStringValue(_FIRST_NAME);

  static String get lastName => getUserStringValue(_LAST_NAME);

  static String get forceUpdatePassword => getUserStringValue(_FORCE_UPDATE_PASSWORD);

  static String get profileType => getUserStringValue(_PROFILE_TYPE);

  static String get dgeGamesData => getAppStringValue(_DGE_GAMES_DATA);

  static String get igeGamesData => getAppStringValue(_IGE_GAMES_DATA);

  static String get isDarkThemeOn => getAppStringValue(_IS_DARK_THEME_ON);

  static String get getCurrencyCode => getUserStringValue(_CURRENCY_CODE);

  static String get getReferCode => getUserStringValue(_REFER_CODE);

  static String get getCountryName => getUserStringValue(_COUNTRY_NAME);

  static set playerToken(String value) =>
      setUserStringValue(_PLAYER_TOKEN, value);

  static set playerId(String value) => setUserStringValue(_PLAYER_ID, value);

  static set currencyDisplayCode(String value) => setUserStringValue(_CURRENCY_DISPLAY_CODE, value);

  static set userName(String value) =>
      setUserStringValue(_PLAYER_USER_NAME, value);

  static set registrationResponse(String value) =>
      setUserStringValue(_REGISTRATION_RESPONSE, value);

  static set versionResponse(String value) =>
      setAppStringValue(_VERSION_RESPONSE, value);

  static set cashBalance(String value) =>
      setUserStringValue(_CASH_BALANCE, value);

  static set totalBalance(String value) =>
      setUserStringValue(_TOTAL_BALANCE, value);

  static set mobNumber(String value) => setUserStringValue(_MOB_NUMBER, value);

  static set email(String value) => setUserStringValue(_EMAIL, value);

  static set gender(String value) => setUserStringValue(_GENDER, value);

  static set dob(String value) => setUserStringValue(_DOB, value);

  static set address(String value) => setUserStringValue(_ADDRESS, value);

  static set profileImage(String value) =>
      setUserStringValue(_PROFILE_IMAGE, value);

  static set firstName(String value) => setUserStringValue(_FIRST_NAME, value);

  static set lastName(String value) => setUserStringValue(_LAST_NAME, value);

  static set forceUpdatePassword(String value) => setUserStringValue(_FORCE_UPDATE_PASSWORD, value);

  static set profileType(String value) => setUserStringValue(_PROFILE_TYPE, value);

  static set dgeGamesData(String value) =>
      setAppStringValue(_DGE_GAMES_DATA, value);

  static set igeGamesData(String value) =>
      setAppStringValue(_IGE_GAMES_DATA, value);

  static set isDarkThemeOn(String value) =>
      setAppStringValue(_IS_DARK_THEME_ON, value);

  static set setCurrencyCode(String value) =>
      setUserStringValue(_CURRENCY_CODE, value);

  static set setReferCode(String value) =>
      setUserStringValue(_REFER_CODE, value);

  static set setCountryName(String value) =>
      setUserStringValue(_COUNTRY_NAME, value);
}

enum PrefType { APP_PREF, USER_PREF }

extension PrefExtension on PrefType {
  String get value {
    switch (this) {
      case PrefType.APP_PREF:
        return SharedPrefUtils._APP_PREF;
      case PrefType.USER_PREF:
        return SharedPrefUtils._USER_PREF;
    }
  }
}
