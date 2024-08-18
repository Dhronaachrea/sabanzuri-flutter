import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sabanzuri/model/response/CountryListResponse.dart';
import 'package:sabanzuri/model/response/check_availability_response.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/model/response/otp_response.dart';
import 'package:sabanzuri/repo/repository.dart';

part 'otp_event.dart';

part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  OtpBloc() : super(OtpInitial()) {
    on<GetOtp>(_onOtpEvent);
    on<GetCountryList>(_onCountryListEvent);
    on<RegisterCheckMobileNoAvailabilityEvent>(_onCheckMobileNoAvailabilityEvent);
  }

  FutureOr<void> _onOtpEvent(GetOtp event, Emitter<OtpState> emit) async {
    emit(OtpRequesting());
    String mobNumber = event.mobNumber;
    Map<String, dynamic> request = {
      "aliasName": AppConstants.domainNameInfiniti,
      "mobileNo": mobNumber
    };
    OtpResponse? response = await Repository.getOtp(request);
    if (response != null) {
      if (response.errorCode == 0 && response.data != null) {
        emit(OtpReceived(otpResponse: response));
      } else {
        emit(OtpError(otpResponse: response));
      }
    }
  }

  FutureOr<void> _onCountryListEvent(OtpEvent event, Emitter<OtpState> emit) async {
    emit(GetCountryListLoading());
    Map<String, dynamic> request = {};
    CountryListResponse? response = await Repository.getCountryList(request);
    if (response != null) {
      if (response.errorCode == 0 && response.data != null) {
        emit(GetCountryListLoaded(countryListResponse: response));
      } else {
        emit(GetCountryListError(countryListResponse: response));
      }
    }
  }
}

_onCheckMobileNoAvailabilityEvent(RegisterCheckMobileNoAvailabilityEvent event, Emitter<OtpState> emit) async {
  emit(CheckMobileNoAvailabilityLoading());
  String mobileNumber = event.mobileNo;
  BuildContext context = event.context;
  Map<String, dynamic> request = {
    "domainName": AppConstants.domainNameInfiniti,
    "userName": mobileNumber
  };

  CheckAvailabilityResponse? response = await Repository.checkAvailability(request);
  if (response != null) {
    if (response.errorCode == 0) {
      BlocProvider.of<OtpBloc>(context).add(GetOtp(mobNumber: mobileNumber));

    }else {
      emit(CheckMobileNoAvailabilityError(errorMessage: response.respMsg));
    }
  }
}

