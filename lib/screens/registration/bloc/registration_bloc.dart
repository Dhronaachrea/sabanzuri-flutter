import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/model/response/registration_response.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/auth/auth_bloc.dart';



part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  RegistrationBloc() : super(RegistrationInitial()) {
    on<Registration>(_onRegistrationEvent);
    on<RegistrationUsingScan>(_onRegistrationUsingScanEvent);
  }

  FutureOr<void> _onRegistrationEvent(
      Registration event, Emitter<RegistrationState> emit) async {
    BuildContext context = event.context;
    emit(Registering());
    var request = {
      "countryCode": event.countryCode,
      "currencyCode": event.currencyCode,
      "deviceType": AppConstants.deviceType,
      "domainName": AppConstants.domainNameInfiniti,
      "aliasName": AppConstants.domainNameInfiniti,
      "loginDevice": Platform.isAndroid
          ? AppConstants.androidLoginDevice
          : AppConstants.iosLoginDevice,
      "mobileNo": event.mobNumber,
      "otp": event.otp,
      "password": event.password,
      "requestIp": AppConstants.requestIp,
      "userAgent": FkUserAgent.userAgent,
      "registrationType": "REGISTRATION",
      "referCode": event.referCode,
      "referSource": event.referCode != "" ? "REFER_FRIEND" : "",
    };
    RegistrationResponse? response = await Repository.register(request);
    if (response != null) {
      if (response.errorCode == 0) {
        BlocProvider.of<AuthBloc>(context).add(
          UserLogin(registrationResponse: response),
        );
        emit(Registered(registrationResponse: response));
      } else {
        emit(RegistrationError(registrationResponse: response));
      }
    }
  }

  FutureOr<void> _onRegistrationUsingScanEvent(RegistrationUsingScan event, Emitter<RegistrationState> emit) async {
    BuildContext context = event.context;
    emit(Registering());
    // old request
   /* var request = {
      "countryCode": event.countryCode,
      "currencyCode": event.currencyCode,
      "deviceType": AppConstants.deviceType,
      "domainName": AppConstants.domainNameInfiniti,
      "aliasName": AppConstants.domainNameInfiniti,
      "userName": event.username,
      "hitFromCashier": true,
      "loginDevice": Platform.isAndroid
          ? AppConstants.androidLoginDevice
          : AppConstants.iosLoginDevice,
      "requestIp": AppConstants.requestIp,
      "userAgent": FkUserAgent.userAgent
    };*/


    //new request
    var request = {
      "deviceType": AppConstants.deviceType,
      "aliasName": "poc.igamew.com",
      "loginDevice": AppConstants.loginDevice,
      "requestIp": "127.0.01",
      "userAgent": "NA",
      "data": event.data
    };


    RegistrationResponse? response = await Repository.loginByQr(request);
    print("jsonEncode response 2: ${jsonEncode(response)}");
    if (response != null) {
      if (response.errorCode == 0) {
        BlocProvider.of<AuthBloc>(context).add(
          UserLogin(registrationResponse: response),
        );
        emit(Registered(registrationResponse: response));
      } else {
        emit(RegistrationError(registrationResponse: response));
      }
    }
  }
}
