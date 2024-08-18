part of 'wallet_bloc.dart';

@immutable
abstract class WalletState {}

class WalletInitial extends WalletState {}

class DepositPaymentOptionLoading extends WalletState {

}

class DepositPaymentOptionLoaded extends WalletState {
  final Map<String, dynamic> paymentOption;

  DepositPaymentOptionLoaded({required this.paymentOption});
}

class DepositPaymentOptionError extends WalletState {
  String? errorMsg;
  DepositPaymentOptionError({this.errorMsg});
}

class WithdrawalPaymentOptionLoaded extends WalletState {
  final PaymentOptionResponse? paymentOption;

  WithdrawalPaymentOptionLoaded({required this.paymentOption});
}

class WithdrawalPaymentOptionError extends WalletState {}
