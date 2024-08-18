import 'package:flutter/cupertino.dart';

abstract class TicketEventInfinitiLotto {}

class PickFromDateInfinitiLotto extends TicketEventInfinitiLotto {
  final BuildContext context;

  PickFromDateInfinitiLotto({required this.context});
}

class PickToDateInfinitiLotto extends TicketEventInfinitiLotto {
  final BuildContext context;

  PickToDateInfinitiLotto({required this.context});
}

class GetTicketInfinitiLotto extends TicketEventInfinitiLotto {
  final BuildContext context;
  final int? offset;

  GetTicketInfinitiLotto({required this.context, required this.offset});
}
