import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:sabanzuri/model/response/change_password_response.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/user_info.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<ChangePassword>(_onChangePassword);
    on<InitialChangePassword>(_onInitialChangePassword);
  }

  Future<FutureOr<void>> _onChangePassword(ChangePassword event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading());
    String newPass = event.newPassword;
    String oldPass = event.oldPassword;
    var request = {
      "domainName": AppConstants.domainNameInfiniti,
      "newPassword": newPass,
      "oldPassword": oldPass,
      "playerId": UserInfo.userId,
      "playerToken": UserInfo.userToken,
    };
    ChangePasswordResponseModel? response =
        await Repository.changePassword(request);
    if (response != null) {
      if (response.errorCode == 0) {
        emit(ChangedPassword(changedPasswordResponse: response));
      } else {
        emit(ChangePasswordError(changedPasswordResponse: response));
      }
    }
  }

  Future<FutureOr<void>> _onInitialChangePassword(InitialChangePassword event, Emitter<ChangePasswordState> emit) async {
    emit(ChangePasswordLoading());
    String newPass = event.newPassword;
    var request = {
      "userName": UserInfo.userName,
      "newPassword": newPass,
      "confirmPassword": newPass,
      "merchantPlayerId": UserInfo.userId,
      "domainName": AppConstants.domainNameInfiniti,
      "aliasName": AppConstants.domainNameInfiniti,
      "playerToken": UserInfo.userToken,
      "playerId": UserInfo.userId
    };


    ChangePasswordResponseModel? response = await Repository.changeInitialPassword(request);
    if (response != null) {
      if (response.errorCode == 0) {
        emit(ChangedPassword(changedPasswordResponse: response));
      } else {
        emit(ChangePasswordError(changedPasswordResponse: response));
      }
    }
  }
}
