import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sabanzuri/model/response/ticket_detail_infiniti_lotto_response.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/screens/ticket/bloc/ticket_event_infiniti_lotto.dart';
import 'package:sabanzuri/screens/ticket/bloc/ticket_state_infiniti_lotto.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/date_format.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/utils/utils.dart';

class TicketBlocInfinitiLotto extends Bloc<TicketEventInfinitiLotto, TicketStateInfinitiLotto> {
  TicketBlocInfinitiLotto() : super(TicketInitialInfinitiLotto()) {
    on<PickFromDateInfinitiLotto>(_onPickFromDate);
    on<PickToDateInfinitiLotto>(_onPickToDate);
    on<GetTicketInfinitiLotto>(_onGetTicket);
  }

  DateTime? toCustomPickedFirstDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime toCustomPickedDate       = DateTime.now().subtract(const Duration(days: 30));
  DateTime fromCustomPickedLastDate = DateTime.now();
  DateTime fromCustomPickedDate     = DateTime.now().subtract(const Duration(days: 30));

  String fromDate = formatDate(
    date: DateTime.now().subtract(const Duration(days: 30)).toString(),
    inputFormat: Format.apiDateFormat2,
    outputFormat: Format.dateFormat9,
  );

  String toDate = formatDate(
    date: DateTime.now().toString(),
    inputFormat: Format.apiDateFormat2,
    outputFormat: Format.dateFormat9,
  );

  FutureOr<void> _onPickFromDate(
      PickFromDateInfinitiLotto event, Emitter<TicketStateInfinitiLotto> emit) async {
    BuildContext context = event.context;
    print("-"*100);
    print("pick from initialDate: $fromCustomPickedDate");
    print("pick from firstDate: null");
    print("pick from lastDate: $fromCustomPickedLastDate");
    print("-"*100);

    DateTime? pickedDate = await showCalendar(
        context,
        fromCustomPickedDate,
        null,
        fromCustomPickedLastDate
    );
    if (pickedDate != null) {
      fromDate = formatDate(
        date: DateFormat(Format.calendarFormat).format(pickedDate),
        inputFormat: Format.calendarFormat,
        outputFormat: Format.dateFormat9,
      );

      toCustomPickedDate = DateFormat("dd-MM-yyyy").parse(fromDate);
      toCustomPickedFirstDate =  DateFormat("dd-MM-yyyy").parse(fromDate);
      /*fromCustomPickedLastDate = toCustomPickedDate;
      toCustomPickedDate = DateFormat("dd-MM-yyyy").parse(fromDate);*/
      emit(FromDateUpdatedInfinitiLotto(date: fromDate));
    }
  }

  FutureOr<void> _onPickToDate(
      PickToDateInfinitiLotto event, Emitter<TicketStateInfinitiLotto> emit) async {
    BuildContext context = event.context;

    print("-"*100);
    print("pick to initialDate: $toCustomPickedDate");
    print("pick to firstDate: $toCustomPickedFirstDate");
    print("pick to lastDate: ${DateTime.now()}");
    print("-"*100);

    DateTime? pickedDate =
        await showCalendar(context, toCustomPickedDate, toCustomPickedFirstDate, DateTime.now());
    if (pickedDate != null) {
      toDate = formatDate(
        date: DateFormat(Format.calendarFormat).format(pickedDate),
        inputFormat: Format.calendarFormat,
        outputFormat: Format.dateFormat9,
      );

      /*fromCustomPickedDate = DateFormat("dd-MM-yyyy").parse(toDate);
      fromCustomPickedLastDate = DateFormat("dd-MM-yyyy").parse(toDate);*/
      fromCustomPickedDate = DateFormat("dd-MM-yyyy").parse(toDate).subtract(const Duration(days: 30));
      fromCustomPickedLastDate = DateFormat("dd-MM-yyyy").parse(toDate);
      print("toDate: $toDate");
      print("fromDate: $fromDate");
      emit(ToDateUpdatedInfinitiLotto(date: toDate));
    }
  }

  FutureOr<void> _onGetTicket(
      GetTicketInfinitiLotto event, Emitter<TicketStateInfinitiLotto> emit) async {
    emit(TicketLoadingInfinitiLotto());
    String startDate = formatDate(
      date: fromDate,
      inputFormat: Format.dateFormat9,
      outputFormat: Format.calendarFormat,
    );
    String endDate = formatDate(
      date: toDate,
      inputFormat: Format.dateFormat9,
      outputFormat: Format.calendarFormat,
    );
    BuildContext context = event.context;
    Map<String, dynamic> request = {
      "orderBy": "DESC",
      "domainName":AppConstants.domainNameInfiniti,
      "limit":AppConstants.ticketLimit,
      "offset": event.offset ?? AppConstants.ticketOffset,
      "fromDate": startDate,
      "playerToken": UserInfo.userToken,
      "playerId": UserInfo.userId,
      "toDate": endDate,
      "txnType": "ticket",
    };
    TicketDetailInfinitiLottoResponse? response = await Repository.getTicketInfinitiLotto(request);
    if (response != null) {
      if (response.errorCode == 0) {
        emit(TicketLoadedInfinitiLotto(ticketList: response.ticketList));

      } else {
        emit(
          TicketLoadingErrorInfinitiLotto(response: response),
        );
      }
    }
  }
}
