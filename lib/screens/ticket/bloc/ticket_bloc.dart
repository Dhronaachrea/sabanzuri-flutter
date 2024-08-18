import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sabanzuri/model/response/ticket_response.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/date_format.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/utils/utils.dart';

part 'ticket_event.dart';

part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  TicketBloc() : super(TicketInitial()) {
    on<PickFromDate>(_onPickFromDate);
    on<PickToDate>(_onPickToDate);
    on<GetTicket>(_onGetTicket);
  }

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
      PickFromDate event, Emitter<TicketState> emit) async {
    BuildContext context = event.context;
    DateTime? pickedDate = await showCalendar(
        context,
        DateTime.now().subtract(const Duration(days: 30)),
        null,
        DateTime.now());
    if (pickedDate != null) {
      fromDate = formatDate(
        date: DateFormat(Format.calendarFormat).format(pickedDate),
        inputFormat: Format.calendarFormat,
        outputFormat: Format.dateFormat9,
      );
      emit(DateUpdated());
    }
  }

  FutureOr<void> _onPickToDate(
      PickToDate event, Emitter<TicketState> emit) async {
    BuildContext context = event.context;
    DateTime? pickedDate =
        await showCalendar(context, DateTime.now(), null, DateTime.now());
    if (pickedDate != null) {
      toDate = formatDate(
        date: DateFormat(Format.calendarFormat).format(pickedDate),
        inputFormat: Format.calendarFormat,
        outputFormat: Format.dateFormat9,
      );
      emit(DateUpdated());
    }
  }

  FutureOr<void> _onGetTicket(
      GetTicket event, Emitter<TicketState> emit) async {
    emit(TicketLoading());
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
    Map<String, String> request = {
      "domainName": AppConstants.domainName,
      "fromDate": startDate,
      "limit": AppConstants.ticketLimit,
      "offset": AppConstants.ticketOffset,
      "playerId": UserInfo.userId,
      "playerToken": UserInfo.userToken,
      "toDate": endDate,
      "txnType": AppConstants.ticketTxnType,
    };
    TicketResponse? response = await Repository.getTicket(request);
    if (response != null) {
      if (response.errorCode == 0) {
        emit(TicketLoaded(ticketList: response.ticketList));
      } else {
        emit(
          TicketLoadingError(error: "Ticket Loading Error"),
        );
      }
    }
  }
}
