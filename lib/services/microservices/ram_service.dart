import 'package:http/http.dart';
import 'package:sabanzuri/model/response/CountryListResponse.dart';
import 'package:sabanzuri/model/response/FullRegistrationOtpResponse.dart';
import 'package:sabanzuri/model/response/otp_response.dart';
import 'package:sabanzuri/model/response/update_profile_response.dart';

import 'package:sabanzuri/services/api_service.dart';

import 'package:sabanzuri/utils/url.dart';

import 'package:sabanzuri/utils/app_constants.dart';

import 'package:sabanzuri/model/response/registration_response.dart';
import 'package:sabanzuri/utils/user_info.dart';

class RamService {
  static Map<String, String> headers = {
    "merchantCode": AppConstants.merchantCode,
    "Content-Type": "application/json",
  };

  static Map<String, String> headersOverallUpdateProfile = {
    "merchantCode": AppConstants.merchantCode,
    "Content-Type": "application/json",
  };

  static Map<String, String> headersInfiniti = {
    "Content-Type": "application/json",
    "merchantCode": AppConstants.merchantCodeInfiniti,
  };

  static Future<CountryListResponse?> getCountryList(
      Map<String, dynamic> request) async {
    final response = await ApiService.makeRequest(
        Url.COUNTRY_LIST_URL, RequestType.get, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return CountryListResponse.fromJson(jsonMap);
  }

  static Future<OtpResponse?> getOtp(Map<String, dynamic> request) async {
    final response = await ApiService.makeRequest(
        Url.GET_OTP_URL, RequestType.get, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return OtpResponse.fromJson(jsonMap);
  }

  static Future<RegistrationResponse?> register(
      Map<String, dynamic> request) async {
    headers["accept"] = "*/*";
    final response = await ApiService.makeRequest(
        Url.REGISTRATION_URl, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return RegistrationResponse.fromJson(jsonMap);
  }

  static Future<RegistrationResponse?> login(
      Map<String, dynamic> request) async {
    headersInfiniti["accept"] = "*/*";
    final response = await ApiService.makeRequest(
        Url.LOGIN_URl_INFINITI, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return RegistrationResponse.fromJson(jsonMap);
  }

  static Future<RegistrationResponse?> loginByQr(Map<String, dynamic> request) async {
    headersInfiniti["accept"] = "*/*";
    final response = await ApiService.makeRequest(Url.LOGIN_BY_QRCODE, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return RegistrationResponse.fromJson(jsonMap);
  }

  static Future<UpdateProfileResponse?> updateProfile(
      Map<String, String> request) async {
    headersOverallUpdateProfile["playerId"] = UserInfo.userId;
    headersOverallUpdateProfile["playerToken"] = UserInfo.userToken;
    headersOverallUpdateProfile["Content-Type"] = "*/*";
    Response? response = await ApiService.makeMultipartRequest(Url.UPDATE_PLAYER_PROFILE, request, headersOverallUpdateProfile, null);
    // Response? response = await ApiService.makeMultipartRequest(Url.UPDATE_PLAYER_PROFILE,RequestType.post, request, headersOverallUpdateProfile);
    print("get update respose ---> $response");
    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return UpdateProfileResponse.fromJson(jsonMap);
  }

  static Future<FullRegistrationOtpResponse?> callGetOtpProfileUpdate(
      Map<String, String> request) async {
    headersOverallUpdateProfile["playerId"] = UserInfo.userId;
    headersOverallUpdateProfile["playerToken"] = UserInfo.userToken;
    headersOverallUpdateProfile["Content-Type"] = "*/*";
    headersOverallUpdateProfile["merchantCode"] = AppConstants.merchantCode;

    Response? response = await ApiService.makeRequest(
        Url.UPDATE_PROFILE_TYPE_OTP, RequestType.get, request, headersOverallUpdateProfile);
    print("get respose ---> $response");
    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return FullRegistrationOtpResponse.fromJson(jsonMap);
  }
}
