import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:sabanzuri/l10n/l10n.dart';
import 'package:sabanzuri/model/response/change_password_response.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/screens.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_dialog.dart';
import 'package:sabanzuri/widgets/popup/alert/alert_type.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<SendOtp>(_sendOtp);
    on<VerifyPassOtp>(_verifyPassOtp);
    on<CancelOtpVerification>(_cancelOtpVerification);
  }

  Future<FutureOr<void>> _sendOtp(
      SendOtp event, Emitter<ForgotPasswordState> emit) async {
    emit(SendingOtp());
    String mobNumber = event.mobNumber;
    var request = {
      "domainName": AppConstants.domainNameInfiniti,
      "confirmPassword": "",
      "mobileNo": mobNumber,
      "newPassword": "",
      "otp": ""
    };
    ChangePasswordResponseModel? response = await Repository.sendOtp(request);
    if (response != null) {
      if (response.errorCode == 0) {
        emit(
          SentOtp(passwordResponseModel: response),
        );
      } else {
        emit(
          SendOtpError(passwordResponseModel: response),
        );
      }
    }
  }

  Future<FutureOr<void>> _verifyPassOtp(
      VerifyPassOtp event, Emitter<ForgotPasswordState> emit) async {
    emit(VerifyingOtp());
    BuildContext context = event.context;
    String otp = event.otp;
    String password = event.password;
    String confPassword = event.confPassword;
    String mobNumber = event.mobNumber;
    var request = {
      "domainName": AppConstants.domainNameInfiniti,
      "confirmPassword": confPassword,
      "mobileNo": mobNumber,
      "newPassword": password,
      "otp": otp
    };
    ChangePasswordResponseModel? response =
        await Repository.resetPassword(request);
    if (response != null) {
      if (response.errorCode == 0) {
        emit(VerifiedOtp(passwordResponseModel: response));
      } else {
        emit(
          VerifyOtpError(passwordResponseModel: response),
        );
      }
    }
  }

  FutureOr<void> _cancelOtpVerification(
      CancelOtpVerification event, Emitter<ForgotPasswordState> emit) {
    emit(ForgotPasswordInitial());
  }
}
