import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/deposit_response.dart';
import 'package:sabanzuri/model/response/payment_option_response.dart';
import 'package:sabanzuri/model/wallet/deposit_model.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_type.dart';

part 'wallet_event.dart';

part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<DepositPaymentOption>(_depositPaymentOption);
    on<WithdrawalPaymentOption>(_withdrawalPaymentOption);
    on<Deposit>(_deposit);
    on<Withdrawal>(_withdrawal);
  }

  Future<FutureOr<void>> _depositPaymentOption(
      DepositPaymentOption event, Emitter<WalletState> emit) async {
  emit(DepositPaymentOptionLoading());
    Map<String, dynamic> request = {
      "currencyCode": UserInfo.currencyDisplayCode,
      "deviceType": AppConstants.deviceType,
      "domainName": UserInfo.getAliasName(),
      "playerId": UserInfo.userId,
      "playerToken": UserInfo.userToken,
      "txnType": AppConstants.deposit,
      "userAgent": FkUserAgent.userAgent,
    };
    Map<String, dynamic> response = await Repository.getPaymentOption(request);
    if (response["errorCode"] == 0) {
      emit(DepositPaymentOptionLoaded(paymentOption: response));
    } else {
      emit(DepositPaymentOptionError(errorMsg: response["errorMsg"]));
    }
  }

  Future<FutureOr<void>> _withdrawalPaymentOption(
      WithdrawalPaymentOption event, Emitter<WalletState> emit) async {
    Map<String, dynamic> request = {
      "currencyCode": AppConstants.currencyCode,
      "deviceType": AppConstants.deviceType,
      "domainName": AppConstants.domainName,
      "playerId": UserInfo.userId,
      "playerToken": UserInfo.userToken,
      "txnType": AppConstants.withdrawal,
      "userAgent": FkUserAgent.userAgent ?? "",
    };
    PaymentOptionResponse? response = await Repository.getWithdrawPaymentOption(request);
    if (response != null) {
      if (response.errorCode == 0) {
        emit(WithdrawalPaymentOptionLoaded(paymentOption: response));
      } else {
        emit(WithdrawalPaymentOptionError());
      }
    }
  }

  Future<FutureOr<void>> _deposit(
      Deposit event, Emitter<WalletState> emit) async {
    DepositModel depositModel = event.depositModel;
    BuildContext context = event.context;
    Map<String, dynamic> request = {
      "amount": depositModel.amount,
      "currencyCode": depositModel.currencyCode,
      "deviceType": AppConstants.deviceType,
      "domainName": AppConstants.domainName,
      "paymentAccId": depositModel.paymentAccId,
      "paymentTypeCode": depositModel.paymentTypeCode,
      "paymentTypeId": depositModel.paymentTypeId,
      "playerId": UserInfo.userId,
      "playerToken": UserInfo.userToken,
      "subTypeId": depositModel.subTypeId,
      "txnType": "DEPOSIT",
      "userAgent": FkUserAgent.userAgent ?? "",
    };
    // var response = await Repository.depositRequest(request);
    Navigator.pushNamed(
      context,
      Screen.deposit_webview,
      arguments: request,
    ).then((depositResponse) {
      if (depositResponse?.toString() != null) {
        _processDepositResponse(depositResponse.toString(), context);
      }
    });
  }

  _processDepositResponse(depositResponse, BuildContext context) {
    DepositResponse depositResponseModel =
        depositResponseFromJson(depositResponse);

    if (depositResponseModel.errorCode == 0) {
      log("\n Response: $depositResponseModel");
      fetchHeaderInfo(context);
      Alert.show(
        context: context,
        subtitle: depositResponseModel.respMsg ?? "",
        buttonText: context.l10n.done.toUpperCase(),
        title: context.l10n.deposit,
        type: AlertType.success,
      );
    } else {
      log("\n Response else: $depositResponseModel");
      Alert.show(
        context: context,
        subtitle: depositResponseModel.errorMsg ?? "",
        buttonText: context.l10n.done.toUpperCase(),
        title: context.l10n.deposit,
        type: AlertType.error,
      );
    }
  }

  Future<FutureOr<void>> _withdrawal(
      Withdrawal event, Emitter<WalletState> emit) async {
    DepositModel depositModel = event.depositModel;
    BuildContext context = event.context;
    Map<String, dynamic> request = {
      "amount": depositModel.amount,
      "currencyCode": depositModel.currencyCode,
      "deviceType": AppConstants.deviceType,
      "domainName": AppConstants.domainName,
      "paymentAccId": depositModel.paymentAccId,
      "paymentTypeCode": depositModel.paymentTypeCode,
      "paymentTypeId": depositModel.paymentTypeId,
      "playerId": UserInfo.userId,
      "playerToken": UserInfo.userToken,
      "subTypeId": depositModel.subTypeId,
      "txnType": "WITHDRAWAL",
      "userAgent": FkUserAgent.userAgent ?? "",
    };
    DepositResponse? response = await Repository.withdrawalRequest(request);
    if (response != null) {
      if (response.errorCode == 0) {
        log("\n withdrawal Response: $response");
        fetchHeaderInfo(context);
        Alert.show(
          context: context,
          subtitle: response.respMsg ?? "",
          buttonText: context.l10n.done.toUpperCase(),
          title: context.l10n.withdrawal,
          type: AlertType.success,
        );
      } else {
        log("\n withdrawal Response else: $response");
        Alert.show(
          context: context,
          subtitle: response.errorMsg ?? "",
          buttonText: context.l10n.done.toUpperCase(),
          title: context.l10n.withdrawal,
          type: AlertType.error,
        );
      }
    }
  }
}
