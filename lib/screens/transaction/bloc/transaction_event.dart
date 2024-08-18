part of 'transaction_bloc.dart';

@immutable
abstract class TransactionEvent {}

class PickFromDate extends TransactionEvent {
  final BuildContext context;

  PickFromDate({required this.context});
}

class PickToDate extends TransactionEvent {
  final BuildContext context;

  PickToDate({required this.context});
}

class GetTransaction extends TransactionEvent {
  final BuildContext context;
  final String txnType;
  final int? offset;

  GetTransaction({required this.context, required this.txnType, this.offset});
}
