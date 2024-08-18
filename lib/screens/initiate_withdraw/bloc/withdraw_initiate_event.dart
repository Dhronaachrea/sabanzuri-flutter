
import 'package:flutter/material.dart';

abstract class WithdrawInitiateEvent {}

class WithdrawInitiateInitialEvent extends WithdrawInitiateEvent {}

class WithdrawInitiateCallApiEvent extends WithdrawInitiateEvent {
  BuildContext? context;
  String amount;
  bool? isLimitExceed;
  String? mobileNumber;
  int? paymentTypeId;
  int? providerId;
  int? subTypeId;
  WithdrawInitiateCallApiEvent({required this.context, required this.amount, this.isLimitExceed, this.mobileNumber, this.paymentTypeId, this.providerId, this.subTypeId});
}

class FetchScanNPlayPendingWithdrawalCallApiEvent extends WithdrawInitiateEvent {

  FetchScanNPlayPendingWithdrawalCallApiEvent();
}

class GetConfigValueCallApiEvent extends WithdrawInitiateEvent {}

class WithdrawalPaymentOptionEvent extends WithdrawInitiateEvent {}

class ResendWithdrawalOtpEvent extends WithdrawInitiateEvent {
  int userTxnId;
  ResendWithdrawalOtpEvent({required this.userTxnId});
}


