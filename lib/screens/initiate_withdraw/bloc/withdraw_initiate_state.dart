
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/FetchPendingScanNPlayWithdrawalResponse.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/GetConfigValueResponse.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/WithdrawalInitiateResponse.dart';

abstract class WithdrawInitiateState {
  const WithdrawInitiateState();
}

class WithdrawInitiateInitial extends WithdrawInitiateState {}

class WithdrawInitiateLoading extends WithdrawInitiateState {}

class WithdrawInitiateSuccess extends WithdrawInitiateState {
  final WithdrawalInitiateResponse responseData;
  WithdrawInitiateSuccess(this.responseData);
}

class WithdrawInitiateError extends WithdrawInitiateState {
  final String? errorMessage;
  WithdrawInitiateError(this.errorMessage);
}

class GetConfigValueSuccess extends WithdrawInitiateState {
  final GetConfigValueResponse responseData;
  GetConfigValueSuccess(this.responseData);
}

class GetConfigValueError extends WithdrawInitiateState {
  final String? errorMessage;
  GetConfigValueError(this.errorMessage);
}

class WithdrawalPaymentOptionLoading extends WithdrawInitiateState {}
class WithdrawalPaymentOptionLoaded extends WithdrawInitiateState {
  final Map<String, dynamic> paymentOption;

  WithdrawalPaymentOptionLoaded({required this.paymentOption});
}

class WithdrawalPaymentOptionError extends WithdrawInitiateState {}

class FetchPendingScanNPlayWithdrawalLoading extends WithdrawInitiateState {}

class FetchPendingScanNPlayWithdrawalSuccess extends WithdrawInitiateState {
  final FetchPendingScanNPlayWithdrawalResponse responseData;
  FetchPendingScanNPlayWithdrawalSuccess(this.responseData);
}

class FetchPendingScanNPlayWithdrawalError extends WithdrawInitiateState {
  final String? errorMessage;
  FetchPendingScanNPlayWithdrawalError(this.errorMessage);
}

class ResendWithdrawalOtpSuccess extends WithdrawInitiateState {}
class ResendWithdrawalOtpError extends WithdrawInitiateState {}
