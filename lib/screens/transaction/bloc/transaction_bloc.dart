import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sabanzuri/model/response/transaction_response.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/date_format.dart';
import 'package:sabanzuri/utils/user_info.dart';
import 'package:sabanzuri/utils/utils.dart';

part 'transaction_event.dart';

part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionInitial()) {
    on<PickFromDate>(_onPickFromDate);
    on<PickToDate>(_onPickToDate);
    on<GetTransaction>(_onGetTransaction);
  }

  DateTime? toCustomPickedFirstDate   = DateTime.now().subtract(const Duration(days: 30));
  DateTime toCustomPickedDate         = DateTime.now().subtract(const Duration(days: 30));
  DateTime fromCustomPickedLastDate   = DateTime.now();
  DateTime fromCustomPickedDate       = DateTime.now().subtract(const Duration(days: 30));

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
      PickFromDate event, Emitter<TransactionState> emit) async {
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
      //fromCustomPickedLastDate = toCustomPickedDate;
      //toCustomPickedDate = DateFormat("dd-MM-yyyy").parse(fromDate);
      emit(FromDateUpdatedInfinitiLotto(date: fromDate));
    }
  }

  FutureOr<void> _onPickToDate(
      PickToDate event, Emitter<TransactionState> emit) async {
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
      /*fromCustomPickedDate      = DateFormat("dd-MM-yyyy").parse(toDate);
      fromCustomPickedLastDate  = DateFormat("dd-MM-yyyy").parse(toDate);*/
      fromCustomPickedDate = DateFormat("dd-MM-yyyy").parse(toDate).subtract(const Duration(days: 30));
      fromCustomPickedLastDate = DateFormat("dd-MM-yyyy").parse(toDate);
      emit(ToDateUpdatedInfinitiLotto(date: toDate));
    }
  }

  Future<FutureOr<void>> _onGetTransaction(
      GetTransaction event, Emitter<TransactionState> emit) async {
    String txnType = event.txnType;
    emit(TransactionLoading());
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
    Map<String, String> request = {
      "domainName": AppConstants.domainNameInfiniti,
      "fromDate": startDate,
      "toDate": endDate,
      "limit": AppConstants.ticketLimit,
      "offset": event.offset != null ? event.offset.toString() : AppConstants.ticketOffset,
      "playerId": UserInfo.userId,
      "playerToken": UserInfo.userToken,
      "txnType": txnType,
    };
    TransactionResponseModel? response =
        await Repository.getTransaction(request);
    if (response != null) {
      if (response.errorCode == 0) {
        emit(TransactionLoaded(transactionList: response.txnList));
      } else {
        emit(TransactionLoadingError(errorMsg: response.respMsg ?? "Transaction Loading Error", errorCode: response.errorCode ?? -1),);
      }
    }
  }
}
