import 'package:http/http.dart';
import 'package:sabanzuri/model/response/ResendWithdrawalOtpResponse.dart';
import 'package:sabanzuri/model/response/deposit_response.dart';
import 'package:sabanzuri/model/response/payment_option_response.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/FetchPendingScanNPlayWithdrawalResponse.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/GetConfigValueResponse.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/WithdrawalInitiateResponse.dart';
import 'package:sabanzuri/services/api_service.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/url.dart';
import 'package:sabanzuri/utils/user_info.dart';

class CashierService {
  static var headers = {
    "merchantCode": AppConstants.merchantCode,
    "Content-Type": "application/json"
  };

  static Future<Map<String,dynamic>> getPaymentOption(
      Map<String, dynamic> request) async {
    headers["playerId"] = UserInfo.userId;
    headers["playerToken"] = UserInfo.userToken;
    final Response? response = await ApiService.makeRequest(
        Url.PAYMENT_OPTION, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return jsonMap;
    // return PaymentOptionResponse.fromJson(jsonMap);
  }

  static Future<PaymentOptionResponse?> getWithdrawPaymentOption( // old
      Map<String, dynamic> request) async {
    headers["playerId"] = UserInfo.userId;
    headers["playerToken"] = UserInfo.userToken;
    final Response? response = await ApiService.makeRequest(
        Url.PAYMENT_OPTION, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    // return jsonMap;
    return PaymentOptionResponse.fromJson(jsonMap);
  }
  static Future<Map<String, dynamic>> getWithdrawalPaymentOption( // withdrawal initiate screen
      Map<String, dynamic> request) async {
    headers["playerId"] = UserInfo.userId;
    headers["playerToken"] = UserInfo.userToken;
    final Response? response = await ApiService.makeRequest(
        Url.PAYMENT_OPTION, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');

    return jsonMap;
  }

  static Future<DepositResponse?> withdrawalRequest(
      Map<String, dynamic> request) async {
    headers["playerId"] = UserInfo.userId;
    headers["playerToken"] = UserInfo.userToken;
    final Response? response = await ApiService.makeRequest(
        Url.WITHDRAWAL_REQUEST_URL, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return DepositResponse.fromJson(jsonMap);
  }

  static Future<WithdrawalInitiateResponse?> callWithdrawalInitiateApi(
      Map<String, dynamic> request) async {
    headers["playerId"] = UserInfo.userId;
    headers["playerToken"] = UserInfo.userToken;
    headers["merchantCode"] = AppConstants.merchantCode;
    final Response? response = await ApiService.makeRequest(
        Url.WITHDRAWAL_INITIATE_REQUEST_URL, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return WithdrawalInitiateResponse.fromJson(jsonMap);
  }

  static Future<FetchPendingScanNPlayWithdrawalResponse?> callFetchScanNPlayPendingWithdrawalApi(
      Map<String, dynamic> request) async {
    headers["playerId"]     = UserInfo.userId;
    headers["playerToken"]  = UserInfo.userToken;
    headers["merchantCode"] = AppConstants.merchantCode;
    headers["merchantId"]   = "1";
    final Response? response = await ApiService.makeRequest(
        Url.FETCH_PENDING_WITHDRAWAL, RequestType.get, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return FetchPendingScanNPlayWithdrawalResponse.fromJson(jsonMap);
  }

  static Future<GetConfigValueResponse?> callGetConfigValueApi(
      Map<String, dynamic> request) async {
    final Response? response = await ApiService.makeRequest(
        Url.GET_CONFIG_VALUE, RequestType.get, request, null);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return GetConfigValueResponse.fromJson(jsonMap);
  }

  static Future<ResendWithdrawalOtpResponse?> callResendWithdrawalOtp(
      Map<String, dynamic> request) async {
    headers["playerId"] = UserInfo.userId;
    headers["playerToken"] = UserInfo.userToken;
    final Response? response = await ApiService.makeRequest(
        Url.RESEND_WITHDRAWAL_OTP_URL, RequestType.post, request, headers);

    Map<String, dynamic> jsonMap = ApiService.getResponse(response, '');
    return ResendWithdrawalOtpResponse.fromJson(jsonMap);
  }
}
