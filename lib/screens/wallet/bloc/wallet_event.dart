part of 'wallet_bloc.dart';

@immutable
abstract class WalletEvent {}

class DepositPaymentOption extends WalletEvent {}

class WithdrawalPaymentOption extends WalletEvent {}

class Deposit extends WalletEvent {
  final DepositModel depositModel;
  final BuildContext context;

  Deposit({required this.depositModel, required this.context});
}

class Withdrawal extends WalletEvent {
  final DepositModel depositModel;
  final BuildContext context;
  Withdrawal({required this.depositModel, required this.context});

}
