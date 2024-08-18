import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:sabanzuri/model/response/inbox_response.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/user_info.dart';

part 'inbox_event.dart';

part 'inbox_state.dart';

class InboxBloc extends Bloc<InboxEvent, InboxState> {
  InboxBloc() : super(InboxInitial()) {
    on<GetInbox>(_getInbox);
    on<InboxActivity>(_inboxActivity);
    on<InboxSearch>(_inboxSearch);
  }

  List<PlrInboxList> inboxList = [];
  List<PlrInboxList> searchList = [];

  Future<FutureOr<void>> _getInbox(GetInbox event, Emitter<InboxState> emit) async {
    emit(InboxLoading());
    Map<String, dynamic> request = {
      "domainName": AppConstants.domainNameInfiniti,
      "limit": AppConstants.inboxLimit,
      "offset": event.offset,
      "playerId": UserInfo.userId,
      "playerToken": UserInfo.userToken,
    };
    InboxResponseModel? response = await Repository.getInbox(request);
    if (response != null) {
      if (response.errorCode == 0) {
        inboxList = response.plrInboxList!;
        emit(InboxLoaded(response.plrInboxList));
      } else {
        emit(InboxError(response.errorCode,response.respMsg));
      }
    }
  }

  Future<FutureOr<void>> _inboxActivity(
      InboxActivity event, Emitter<InboxState> emit) async {
    var activity = event.activity;
    var inboxId = event.inboxId;

    emit(InboxLoading());
    Map<String, dynamic> request = {
      "activity": activity,
      "domainName": AppConstants.domainNameInfiniti,
      "inboxIdList": [inboxId],
      "limit": AppConstants.inboxLimit,
      "offset": AppConstants.inboxOffset,
      "playerId": UserInfo.userId,
      "playerToken": UserInfo.userToken,
    };
    InboxResponseModel? response = await Repository.inboxActivity(request);
    if (response != null) {
      if (response.errorCode == 0) {
        //inboxList = response.plrInboxList!;
        emit(InboxDeleteLoaded());
        emit(InboxLoaded(response.plrInboxList));
      } else {
        emit(InboxError(response.errorCode,response.respMsg));
      }
    }
  }

  FutureOr<void> _inboxSearch(InboxSearch event, Emitter<InboxState> emit) {
    var query = event.query;
    var actualInboxList = event.inboxList;

    if (query.isNotEmpty) {
      List<PlrInboxList> tempInboxList = [];
      for (PlrInboxList plrInboxList in actualInboxList) {
        if (plrInboxList.subject!.contains(query) ||
            plrInboxList.subject!.contains(query.toLowerCase()) ||
            plrInboxList.subject!.contains(query.toUpperCase())) {
          tempInboxList.add(plrInboxList);
        }
      }
      if (tempInboxList.isNotEmpty) {
        searchList = tempInboxList;
      } else {
        searchList.clear();
      }
    } else {
      searchList.clear();
    }
    emit(InboxSearchLoaded(searchList));
  }
}
