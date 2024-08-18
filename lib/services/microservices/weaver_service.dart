import 'dart:convert';

import 'package:http/http.dart';
import 'package:sabanzuri/model/response/CheckBonusStatusResponse.dart';
import 'package:sabanzuri/model/response/change_password_response.dart';
import 'package:sabanzuri/model/response/check_availability_response.dart';
import 'package:sabanzuri/model/response/get_balance_response.dart';
import 'package:sabanzuri/model/response/header_response.dart';
import 'package:sabanzuri/model/response/inbox_response.dart';
import 'package:sabanzuri/model/response/ticket_detail_infiniti_lotto_response.dart';
import 'package:sabanzuri/model/response/ticket_response.dart';
import 'package:sabanzuri/model/response/track_status_response.dart';
import 'package:sabanzuri/model/response/transaction_response.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/NewDrawGamesResponse.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/ige_game_response.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/init_game_response.dart';
import 'package:sabanzuri/screens/lobby/lobby_model/sport_lottery_response.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/url.dart';
import 'package:sabanzuri/model/response/version_response.dart';
import 'package:sabanzuri/utils/user_info.dart';

class WeaverService {
  static Map<String, String> headers = {
    "Content-Type": "application/json",
    "merchantCode": AppConstants.merchantCode,
    "cookie": "WZRK_G=e9830c0945ed462da0b45acf2aa41cea; WZRK_S_4R6-WZ8-WR6Z=%7B%22p%22%3A1%7D; connect.sid=s%3AZ9VB3TgGJPMEkHZCGCf2v9Hmlz8HpZxH.uC70gKrXd29cJX7C9qUjNVVwc%2B2Rr124Lwy5HRQd9L4"
  };

  static Map<String, String> infinitiLottoHeaders = {
    "Content-Type": "application/json",
    "password": "password",
    "username": "weaver",
  };

  static Map<String, String> headersInfiniti = {
    "Content-Type": "application/json",
  };

  static Map<String, String> checkBonusHeadersInfiniti = {
    "Content-Type": "application/json",
    "merchantPwd": AppConstants.merchantPwdInfinit,
    "playerId": UserInfo.userId,
    "playerToken": UserInfo.userToken,
    "merchantCode": AppConstants.merchantCode
  };

  static Map<String, String> fetchGameHeaders = {
    "Content-Type": "application/json",
    "username": "weaver",
    "password": "password"
    // "Cookie": "connect.sid=s%3AnbEUCHL2Z2Jp3A8xPNA4l5wwinVBwZ5d.tj6hxWYc5C5Wu5P%2Fuj6Gt2HuVSnpYo5I4qAKicDpOc8"
  };
  static Map<String, String> fetchSportGameHeaders = {
    "Content-Type": "application/json",
    // "Cookie": "connect.sid=s%3Ar44O2hSvQN8e2nTSwoEaDNnS1KsXI5Aq.DtxRlxBGKZ0PeJ8%2B467PJlyRQJANro3WISW8JBIrb98"
  };

  static String errorCodeKey = "errorCode";
  static dynamic sessionExpireCode = 203;

  static Future<VersionResponse?> version(Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.VERSION_API_URL, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return VersionResponse.fromJson(jsonMap);
  }

  static Future<InitGameResponse?> initGames(
      Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.INITIAL_GAME, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return InitGameResponse.fromJson(jsonMap);
  }

  static Future<NewDrawGamesResponse> drawGames(
      Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.FETCH_GAMEDATA_INFINIT, RequestType.put, request, fetchGameHeaders);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return NewDrawGamesResponse.fromJson(jsonMap);
  }

  static Future<IgeGameResponse?> igeGames(Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.FETCH_IGE_GAME, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return IgeGameResponse.fromJson(jsonMap);
  }

  static Future<dynamic> igeGamesSplash(Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.FETCH_IGE_GAME, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return jsonMap;
  }

  static Future<SportLotteryResponse?> sportLotteryGames(
      Map<String, dynamic> request) async {
    Map<String, String> queryParams = {
      'domain': AppConstants.domainNameInfiniti,
      'currency': "EUR",
      "merchant": "WEAVER"
    };
    final Response? response = await ApiService.makeRequest(
        Url.FETCH_SPORT_LOTTERY_GAME,
        RequestType.get,
        queryParams,
        fetchSportGameHeaders);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return SportLotteryResponse.fromJson(jsonMap);
  }

  static Future<HeaderResponse?> fetchHeader(
      Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.FETCH_HEADER_URL, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return HeaderResponse.fromJson(jsonMap);
  }

  static Future<GetBalanceResponse?> getBalance(
      Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.GET_BALANCE_INFINIT, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return GetBalanceResponse.fromJson(jsonMap);
  }

  static Future<CheckBonusStatusResponse?> checkBonusStatus(
      Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
      Url.CHECK_BONUS_STATUS_INFINITI,
      RequestType.post,
      request,
      checkBonusHeadersInfiniti,
    );

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return CheckBonusStatusResponse.fromJson(jsonMap);
  }

  static Future<GetBalanceResponse?> refreshBalance(
      Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.GET_BALANCE_INFINIT, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return GetBalanceResponse.fromJson(jsonMap);
  }

  static Future uploadAvatar(request, file) async {
    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
    };
    Response? response = await ApiService.makeMultipartRequest(
        Url.UPLOAD_AVATAR_URL, request, headers, [file]);

    String? jsonString = response?.body;
    if (jsonString == null) return null;

    Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    return jsonMap;
  }

  static Future<TicketResponse?> getTicket(Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.TICKET_DETAILS_URL, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return TicketResponse.fromJson(jsonMap);
  }

  static Future<TicketDetailInfinitiLottoResponse?> getTicketInfinitiLotto(
      Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.TICKET_DETAILS_URL_INFINITI,
        RequestType.post,
        request,
        infinitiLottoHeaders);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return TicketDetailInfinitiLottoResponse.fromJson(jsonMap);
  }

  static Future<TransactionResponseModel?> getTransaction(
      Map<String, dynamic> request) async {
    headers["playerId"] = UserInfo.userId;
    headers["playerToken"] = UserInfo.userToken;
    headers["merchantCode"] = AppConstants.merchantCode;
    final Response? response = await ApiService.makeRequest(
        Url.TRANSACTION_REQUEST_URL_INFINITI,
        RequestType.post,
        request,
        headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return TransactionResponseModel.fromJson(jsonMap);
  }

  static Future<InboxResponseModel?> getInbox(
      Map<String, dynamic> request) async {
    /*headers["playerId"] = UserInfo.userId;
    headers["playerToken"] = UserInfo.userToken;
    headers["merchantCode"] = AppConstants.merchantCode;*/
    final Response? response = await ApiService.makeRequest(
        Url.INBOX_URL_INFINITI, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return InboxResponseModel.fromJson(jsonMap);
  }

  static Future<InboxResponseModel?> inboxActivity(
      Map<String, dynamic> request) async {
    /*headers["playerId"] = UserInfo.userId;
    headers["playerToken"] = UserInfo.userToken;
    headers["merchantCode"] = AppConstants.merchantCode;*/
    final Response? response = await ApiService.makeRequest(
        Url.INBOX_ACTIVITY_URL_INFINITI, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return InboxResponseModel.fromJson(jsonMap);
  }

  static Future<ChangePasswordResponseModel?> changePassword(
      Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.CHANGE_PASSWORD_URL_INFINITI,
        RequestType.post,
        request,
        headersInfiniti);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return ChangePasswordResponseModel.fromJson(jsonMap);
  }

  static Future<ChangePasswordResponseModel?> changeInitialPassword(Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.FORCE_PASSWORD_CHANGE,
        RequestType.post,
        request,
        checkBonusHeadersInfiniti);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return ChangePasswordResponseModel.fromJson(jsonMap);
  }

  static Future<ChangePasswordResponseModel?> sendOtp(
      Map<String, dynamic> request) async {
    headers["playerId"] = UserInfo.userId;
    headers["playerToken"] = UserInfo.userToken;
    headers["merchantCode"] = AppConstants.merchantCodeInfiniti;
    final Response? response = await ApiService.makeRequest(
        Url.FORGOT_PASSWORD_URL, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return ChangePasswordResponseModel.fromJson(jsonMap);
  }

  static Future<ChangePasswordResponseModel?> resetPassword(
      Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.RESET_PASSWORD_URL, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return ChangePasswordResponseModel.fromJson(jsonMap);
  }

  static Future<CheckAvailabilityResponse?> checkAvailability(
      Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.CHECK_AVAILABILITY_URL, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return CheckAvailabilityResponse.fromJson(jsonMap);
  }

  static Future<ChangePasswordResponseModel?> inviteFriend(
      Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.INVITE_FRIEND, RequestType.post, request, fetchGameHeaders);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return ChangePasswordResponseModel.fromJson(jsonMap);
  }

  static Future<TrackStatusResponseModel?> trackStatus(
      Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.TRACK_STATUS, RequestType.post, request, fetchGameHeaders);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return TrackStatusResponseModel.fromJson(jsonMap);
  }
}
