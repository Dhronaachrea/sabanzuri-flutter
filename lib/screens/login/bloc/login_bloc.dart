import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/utils.dart';
import 'package:sabanzuri/model/response/registration_response.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/utils/auth/auth_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<Login>(_onLoginEvent);
  }

  FutureOr<void> _onLoginEvent(Login event, Emitter<LoginState> emit) async {
    emit(Logging());

    String password = encryptMd5(event.password);
    String encryptedPassword = encryptMd5(password + AppConstants.loginTokenInfiniti);
    BuildContext context = event.context;


    /*var request = {
      "deviceType": AppConstants.deviceType,
      "domainName": AppConstants.domainName,
      "fcmIdAndroid": "NA",
      "loginDevice": AppConstants.loginDevice,
      "loginToken": AppConstants.loginToken,
      "password": encryptedPassword,
      "requestIp": AppConstants.requestIp,
      "trackingCipher": "",
      "userAgent": FkUserAgent.userAgent,
      "userName": event.mobNumber
    };*/

    /*{
      "userName": "clientdemo123",
    "password": "1941e56ae567a6e655c73428b5efdcc9",
    "loginToken": "duneZvJEQi5slDeevoVUEZOmE6pvVcl9MWVFED4lWaA",
    "requestIp": "192.168.131.253",
    "trackingCipher": "",
    "domainName": "ice.igamew.com",
    "deviceType": "PC",
    "userAgent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36",
    "loginDevice": "PC_BROWSER"
    }*/

    var request = {
      "userName": event.mobNumber,
      "password": encryptedPassword,
      "loginToken": AppConstants.loginTokenInfiniti,
      "requestIp": "192.168.131.253",
      "trackingCipher": "",
      "loginDevice": Platform.isAndroid
          ? AppConstants.androidLoginDevice
          : AppConstants.iosLoginDevice,
      "domainName": AppConstants.domainNameInfiniti,
      "deviceType": AppConstants.deviceType,
      "userAgent": AppConstants.userAgentInfiniti,
    };

    RegistrationResponse? response = await Repository.login(request);
    if (response != null) {
      if (response.errorCode == 0) {
        BlocProvider.of<AuthBloc>(context).add(
          UserLogin(registrationResponse: response),
        );
        emit(LoggedIn(response: response));
      } else {
        emit(LoginError(errorMessage: response.errorMessage ?? "Login Error"));
      }
    }
  }
}
