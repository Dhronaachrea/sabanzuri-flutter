import 'dart:convert';

import 'package:sabanzuri/model/response/registration_response.dart';
import 'package:sabanzuri/utils/shared_prefs.dart';

class UserInfo {
  static final UserInfo _instance = UserInfo._ctor();
  static RegistrationResponse? registrationResponse;

  factory UserInfo() {
    return _instance;
  }

  UserInfo._ctor();

  static setPlayerToken(String token) {
    SharedPrefUtils.playerToken = token;
  }

  static setCurrencyDisplayCode(String currencyCode) {
    SharedPrefUtils.currencyDisplayCode = currencyCode;
  }

  static setPlayerId(String playerId) {
    SharedPrefUtils.playerId = playerId;
  }

  static setUserName(String userName) {
    SharedPrefUtils.userName = userName;
  }

  static setCashBalance(String cashBalance) {
    SharedPrefUtils.cashBalance = cashBalance;
  }

  static setTotalBalance(String totalBalance) {
    SharedPrefUtils.totalBalance = totalBalance;
  }

  static setMobNumber(String mobNumber) {
    SharedPrefUtils.mobNumber = mobNumber;
  }

  static setEmail(String email) {
    SharedPrefUtils.email = email;
  }


  static setGender(String gender) {
    SharedPrefUtils.gender = gender;
  }

  static setDob(String dob) {
    SharedPrefUtils.dob = dob;
  }

  static setAddress(String address) {
    SharedPrefUtils.address = address;
  }

  static setProfileImage(String profileImage) {
    SharedPrefUtils.profileImage = profileImage;
  }

  static setFirstName(String firstName) {
    SharedPrefUtils.firstName = firstName;
  }

  static setLastName(String lastName) {
    SharedPrefUtils.lastName = lastName;
  }

  static setForceUpdatePassword(String isForceUpdatePassword) {
    SharedPrefUtils.forceUpdatePassword = isForceUpdatePassword;
  }

  static setProfileType(String profileTYpe) {
    SharedPrefUtils.profileType = profileTYpe;
  }

  static setCurrencyCode(String currencyCode) {
    SharedPrefUtils.setCurrencyCode = currencyCode;
  }

  static setReferCode(String referCode) {
    SharedPrefUtils.setReferCode = referCode;
  }

  static setCountryName(String countryName) {
    SharedPrefUtils.setCountryName = countryName;
  }

  static bool isLoggedIn() {
    return SharedPrefUtils.playerToken != '';
  }

  static setRegistrationResponse(String registrationResponse) {
    SharedPrefUtils.registrationResponse = registrationResponse;
  }

  static String getRegistrationResponse() {
    return SharedPrefUtils.registrationResponse;
  }

  static logout() async {
    SharedPrefUtils.removeValue(PrefType.USER_PREF.value);
    /*SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(PrefType.USER_PREF.value);*/
  }



  static String get userToken => SharedPrefUtils.playerToken;

  static String get currencyDisplayCode => SharedPrefUtils.currencyDisplayCode;

  static String get userId => SharedPrefUtils.playerId;

  static String get userName => SharedPrefUtils.userName;

  static String get cashBalance => SharedPrefUtils.cashBalance;

  static String get totalBalance => SharedPrefUtils.totalBalance;

  static String get mobNumber => SharedPrefUtils.mobNumber;

  static String get email => SharedPrefUtils.email;

  static String get dob => SharedPrefUtils.dob;

  static String get gender => SharedPrefUtils.gender;

  static String get address => SharedPrefUtils.address;

  static String get profileImage => SharedPrefUtils.profileImage;

  static String get firstName => SharedPrefUtils.firstName;

  static String get lastName => SharedPrefUtils.lastName;

  static String get forceUpdatePassword => SharedPrefUtils.forceUpdatePassword;

  static String get profileType => SharedPrefUtils.profileType;

  static String get getCurrencyCode => SharedPrefUtils.getCurrencyCode;

  static String get getReferCode => SharedPrefUtils.getReferCode;

  static String get getCountryName => SharedPrefUtils.getCountryName;

  static String getAliasName() {
    RegistrationResponse? response = RegistrationResponse.fromJson(jsonDecode(getRegistrationResponse()));
    return response.ramPlayerInfo?.aliasName ?? "";
  }

}
