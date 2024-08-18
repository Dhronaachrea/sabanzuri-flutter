import 'package:sabanzuri/model/response/ticket_detail_infiniti_lotto_response.dart';

abstract class TicketStateInfinitiLotto {}

class TicketInitialInfinitiLotto extends TicketStateInfinitiLotto {}

class FromDateUpdatedInfinitiLotto extends TicketStateInfinitiLotto {
  String date;
  FromDateUpdatedInfinitiLotto({required this.date});
}

class ToDateUpdatedInfinitiLotto extends TicketStateInfinitiLotto {
  String date;
  ToDateUpdatedInfinitiLotto({required this.date});
}

class TicketLoadingInfinitiLotto extends TicketStateInfinitiLotto {}

class TicketLoadedInfinitiLotto extends TicketStateInfinitiLotto {
  final List<TicketList>? ticketList;

  TicketLoadedInfinitiLotto({this.ticketList = const []});
}

class TicketLoadingErrorInfinitiLotto extends TicketStateInfinitiLotto {
  final TicketDetailInfinitiLottoResponse response;

  TicketLoadingErrorInfinitiLotto({required this.response});
}
