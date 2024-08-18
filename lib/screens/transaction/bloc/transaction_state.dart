part of 'transaction_bloc.dart';

abstract class TransactionState {}

class TransactionInitial extends TransactionState {}

class DateUpdated extends TransactionState {}

class FromDateUpdatedInfinitiLotto extends TransactionState {
  String date;
  FromDateUpdatedInfinitiLotto({required this.date});
}

class ToDateUpdatedInfinitiLotto extends TransactionState {
  String date;
  ToDateUpdatedInfinitiLotto({required this.date});
}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<TxnList>? transactionList;

  TransactionLoaded({this.transactionList = const []});
}

class TransactionLoadingError extends TransactionState {
  final String errorMsg;
  final int errorCode;

  TransactionLoadingError({required this.errorMsg, required this.errorCode});
}
