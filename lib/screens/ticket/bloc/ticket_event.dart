part of 'ticket_bloc.dart';

@immutable
abstract class TicketEvent {}

class PickFromDate extends TicketEvent {
  final BuildContext context;

  PickFromDate({required this.context});
}

class PickToDate extends TicketEvent {
  final BuildContext context;

  PickToDate({required this.context});
}

class GetTicket extends TicketEvent {
  final BuildContext context;

  GetTicket({required this.context});
}
