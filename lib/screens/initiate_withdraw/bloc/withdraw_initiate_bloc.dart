import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/model/response/ResendWithdrawalOtpResponse.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/FetchPendingScanNPlayWithdrawalResponse.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/GetConfigValueResponse.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/WithdrawalInitiateResponse.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/withdraw_initiate_event.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/withdraw_initiate_state.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/utils/utils.dart';



class WithdrawalInitiateBloc extends Bloc<WithdrawInitiateEvent, WithdrawInitiateState> {

  WithdrawalInitiateBloc() : super(WithdrawInitiateInitial()) {
    on<WithdrawInitiateCallApiEvent>(callWithdrawInitiateCallApi);
    on<FetchScanNPlayPendingWithdrawalCallApiEvent>(callFetchScanNPlayPendingWithdrawalCallApi);
    on<GetConfigValueCallApiEvent>(callGetConfigValueCallApi);
    on<WithdrawalPaymentOptionEvent>(callWithdrawalPaymentOption);
    on<ResendWithdrawalOtpEvent>(callResendWithdrawalOtp);

  }

  callWithdrawInitiateCallApi(WithdrawInitiateCallApiEvent event, Emitter<WithdrawInitiateState> emit) async{
    emit(WithdrawInitiateLoading());
    print("playerId: ${UserInfo.userId}");
    print("playerToken: ${UserInfo.userToken}");
    print("event.amount: ${event.amount}");
//poc.igamew.com
    /*Map<String, dynamic> request = {
      "domainName"      : AppConstants.domainNameInfiniti,
      "aliasId"         : 50,//0
      "currencyId"      : 10,//0
      "amount"          : event.amount,
      "paymentTypeId"   : 17,//10
      "paymentAccId"    : 0,
      "subTypeId"       : 94,//41
      "providerId"      : 30,//11
      "deviceType"      : "PC",
      "txnType"         : "WITHDRAWAL",
      "playerId"        : UserInfo.userId,
      "description"     : "withdrawal test",
      "currencyCode"    : "EUR",
      "merchantCode"    : AppConstants.merchantCode,
      "userAgent"       : AppConstants.userAgentInfiniti,
      "pgCurrencyCode"  : "EUR",
      "aliasName"       : AppConstants.domainNameInfiniti,
      "playerToken"     : UserInfo.userToken
    };*/

    BuildContext? context = event.context ?? navigatorKey.currentContext;

    Map<String, dynamic>  request = {
      "amount": event.amount,
      "currencyCode": UserInfo.getCurrencyCode,
      "pgCurrencyCode":UserInfo.getCurrencyCode,
      "deviceType": AppConstants.deviceType,
      "domainName": UserInfo.getAliasName(),
      "merchantCode": AppConstants.merchantCode,
      "paymentTypeId": event.paymentTypeId,
      "providerId": event.providerId,
      "playerId": UserInfo.userId,
      "playerToken": UserInfo.userToken,
      "subTypeId": event.subTypeId,
      "txnType": "WITHDRAWAL"
    };



    if (event.isLimitExceed != null) {
      request["accNum"] = event.mobileNumber;
    }

    print("------->");

    WithdrawalInitiateResponse? response = await Repository.callWithdrawalInitiateApi(request);

    print("response: ${jsonEncode(response)}");

    if(response != null) {
      if(response.errorCode == 0) {
        /*if (context != null) {
          BlocProvider.of<AuthBloc>(context).add(
            UserLogout(),
          );
        }*/
                     return                                          
        emit(WithdrawInitiateSuccess(response));

      } else {
        emit(WithdrawInitiateError(response.respMsg ?? "Something went wrong"));
      }
    } else {
      emit(WithdrawInitiateError("Something went wrong, Please try after time"));
    }
  }

  callFetchScanNPlayPendingWithdrawalCallApi(FetchScanNPlayPendingWithdrawalCallApiEvent event, Emitter<WithdrawInitiateState> emit) async{
    emit(FetchPendingScanNPlayWithdrawalLoading());
    print("playerId: ${UserInfo.userId}");
    print("playerToken: ${UserInfo.userToken}");

    Map<String, dynamic> request = {
      "domainName"      : "ice.igamew.com",
      "playerId"        : UserInfo.userId,
      "playerToken"     : UserInfo.userToken
    };

    print("------->");

    FetchPendingScanNPlayWithdrawalResponse? response = await Repository.callFetchScanNPlayPendingWithdrawalApi(request);

    print("response: ${jsonEncode(response)}");

    if(response != null) {
      if(response.errorCode == 0) {
        emit(FetchPendingScanNPlayWithdrawalSuccess(response));

      } else {
        emit(FetchPendingScanNPlayWithdrawalError(response.errorMsg ?? "Something went wrong"));
      }
    } else {
      emit(FetchPendingScanNPlayWithdrawalError("Something went wrong, Please try after time"));
    }
  }

  callGetConfigValueCallApi(GetConfigValueCallApiEvent event, Emitter<WithdrawInitiateState> emit) async{
    emit(WithdrawInitiateLoading());

    Map<String, dynamic> request = {
      "domainName"      : AppConstants.domainNameInfiniti,
    };


    GetConfigValueResponse? response = await Repository.callGetConfigValueApi(request);

    print("response: ${jsonEncode(response)}");

    if(response != null) {
      if(response.responseCode == 0) {
        emit(GetConfigValueSuccess(response));

      } else {
        emit(GetConfigValueError(response.responseMessage ?? "Something went wrong"));
      }
    } else {
      emit(GetConfigValueError("Something went wrong, Please try after time"));
    }
  }

  Future<FutureOr<void>> callWithdrawalPaymentOption(WithdrawalPaymentOptionEvent event, Emitter<WithdrawInitiateState> emit) async {
    print("=============> ${UserInfo.getAliasName()}");
    emit(WithdrawalPaymentOptionLoading());
    Map<String, dynamic> request = {
      "currencyCode": UserInfo.currencyDisplayCode,
      "deviceType": AppConstants.deviceType, // now its config for pc
      "domainName": UserInfo.getAliasName(),
      "playerId": UserInfo.userId,
      "playerToken": UserInfo.userToken,
      "txnType": AppConstants.withdrawal,
      "userAgent": "Dalvik/2.1.0 (Linux; U; Android 12; sdk_gphone64_arm64 Build/SPB5.210812.003)",
    };
    Map<String, dynamic> response = await Repository.getWithdrawalPaymentOption(request);
    if (response["errorCode"] == 0) {
      emit(WithdrawalPaymentOptionLoaded(paymentOption: response));
    } else {
      emit(WithdrawalPaymentOptionError());
    }
  }


  Future<FutureOr<void>> callResendWithdrawalOtp(ResendWithdrawalOtpEvent event, Emitter<WithdrawInitiateState> emit) async {

    Map<String, dynamic> request = {
      "merchantAliasName":UserInfo.getAliasName(),
      "userTxnId":98216
    };

    ResendWithdrawalOtpResponse? response = await Repository.callResendWithdrawalOtp(request);
    if (response?.errorCode == 0) {
      emit(ResendWithdrawalOtpSuccess());
    } else {
      emit(ResendWithdrawalOtpError());
    }
  }

}
