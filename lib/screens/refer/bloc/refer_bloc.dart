import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sabanzuri/model/response/change_password_response.dart';
import 'package:sabanzuri/model/response/track_status_response.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/screens/refer/model/friend_contact_model.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/user_info.dart';

part 'refer_event.dart';

part 'refer_state.dart';

class ReferBloc extends Bloc<ReferEvent, ReferState> {
  ReferBloc() : super(ReferInitial()) {
    on<InviteNow>(_onInviteNow);
    on<TrackStatus>(_onTrackStatus);
  }

  FutureOr<void> _onInviteNow(InviteNow event, Emitter<ReferState> emit) async {
    emit(Inviting());
    var contactDetails = event.contactDetails;
    List<Map<String, String>> contactDetailsList = contactDetails
        .map((element) => {
              "firstName": element!.name,
              "lastName": "",
              "emailId": element.emailId,
              "mobileNo": ""
            })
        .toList();
    var request = {
      "referalList": contactDetailsList,
      "referType": "mailRefer",
      "inviteMode": "EMAIL",
      "domainName": AppConstants.domainNameInfiniti,
      "deviceType": "ALL",
      "userAgent": AppConstants.userAgentInfiniti,
      "playerToken": UserInfo.userToken,
      "playerId": UserInfo.userId,
    };
    ChangePasswordResponseModel? response =
        await Repository.inviteFriend(request);
    if (response != null) {
      if (response.errorCode == 0) {
        emit(Invited(response: response));
      } else {
        emit(InvitationError(response: response));
      }
    }
  }

  FutureOr<void> _onTrackStatus(
      TrackStatus event, Emitter<ReferState> emit) async {
    emit(TrackingStatus());
    var request = {
      "domainName": AppConstants.domainNameInfiniti,
      "deviceType": "PC",
      "userAgent": AppConstants.userAgentInfiniti,
      "playerToken": UserInfo.userToken,
      "playerId": UserInfo.userId
    };
    TrackStatusResponseModel? response = await Repository.trackStatus(request);
    if (response != null) {
      if (response.errorCode == 0) {
        emit(TrackedStatus(response: response));
      } else {
        emit(TrackStatusError(response: response));
      }
    }
  }
}
