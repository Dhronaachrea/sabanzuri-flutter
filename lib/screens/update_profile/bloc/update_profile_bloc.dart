import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sabanzuri/model/response/FullRegistrationOtpResponse.dart';
import 'package:sabanzuri/model/response/update_profile_response.dart';
import 'package:sabanzuri/model/user/user.dart';
import 'package:sabanzuri/repo/repository.dart';
import 'package:sabanzuri/screens/initiate_withdraw/bloc/model/response/GetConfigValueResponse.dart';
import 'package:sabanzuri/utils/app_constants.dart';
import 'package:sabanzuri/utils/auth/auth_bloc.dart';
import 'package:sabanzuri/utils/user_info.dart';

part 'update_profile_event.dart';

part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  UpdateProfileBloc() : super(UpdateProfileInitial()) {
    on<OnUpdateProfile>(_onUpdateProfile);
    on<GetOtpApi>(_onCallGetOtpApi);
    on<GetConfigValueCallApiEvent>(_onCallGetConfigValueCallApi);
  }

  FutureOr<void> _onUpdateProfile(OnUpdateProfile event, Emitter<UpdateProfileState> emit) async {

    User user = event.user;
    var context = event.context;
    emit(UpdatingProfile());
    Map<String, String> request = {
      // 'domainName': AppConstants.domainName,
      'domainName': "poc.igamew.com",
      'merchantPlayerId': UserInfo.userId,
      'firstName': user.firstName ?? "",
      'lastName': user.lastName ?? "",
      'dob': user.dob ?? "",
      'emailId': user.email ?? "",
      'addressLine1': user.address ?? "",
      'gender': user.gender ?? ""
    };

    if( UserInfo.profileType == "ANONYMOUS") {
      request["updateType"] = "REGISTRATION";
      request["userName"]   = user.mobNumber ?? "";
      request["password"]   = user.password ?? "";
      request["otp"]        = user.otp ?? "";
    }

    log("request: $request");
    UpdateProfileResponse? response = await Repository.updateProfile(request);
    if (response != null) {
      if (response.errorCode == 0) {
        var playerInfo = response.data?.playerInfo;
        var playerMater = response.data?.playerMaster;
        String? firstName = playerInfo?.firstName;
        String? lastName = playerInfo?.lastName;
        String? userName;
        if (firstName != null) {
          userName = firstName;
        }
        if (lastName != null) {
          userName = lastName;
        }
        if (firstName != null && lastName != null) {
          userName = firstName + " " + lastName;
        }

        BlocProvider.of<AuthBloc>(context).add(
          UpdateUserInfo(
            user: User(
              firstName: playerInfo?.firstName,
              lastName: playerInfo?.lastName,
              userName: userName,
              dob: playerInfo?.dateOfBirth,
              address: playerInfo?.addressOne,
              gender: playerInfo?.gender,
              email: playerMater?.emailId,
              playerType: playerInfo?.playerType
            ),
          ),
        );
        emit(UpdatedProfile(successMsg: response.errorMessage ?? ""));
      } else {
        emit(UpdateProfileError(errorMsg: response.errorMessage ?? ""));
      }
    }
  }

  FutureOr<void> _onCallGetOtpApi(GetOtpApi event, Emitter<UpdateProfileState> emit) async {
    emit(UpdatingProfile());
    String? mobileNo = event.mobileNo;
    var context = event.context;
    // emit(UpdatingProfile());
    Map<String, String> request = {
      'domainName': "poc.igamew.com",
      'mobileNo': mobileNo ?? "",
      'otpType': "MOBILE_UPDATE",
      'resend': event.isResendOtp ? "YES" : "NO"
    };

    log("request: $request");
    FullRegistrationOtpResponse? response = await Repository.callGetOtpProfileUpdate(request);

    if (response != null) {
      if (response.errorCode == 0) {
        String msg = response.data ?? "--";
        print("msg ------------->$msg");
        emit(GetOtpSuccess(msg: msg, isResendOtp: event.isResendOtp));
      } else {
        emit(UpdateProfileError(errorMsg: response.errorMessage ?? ""));
      }
    }
  }


  _onCallGetConfigValueCallApi(GetConfigValueCallApiEvent event, Emitter<UpdateProfileState> emit) async{

    Map<String, dynamic> request = {
      "domainName"      : AppConstants.domainNameInfiniti,
    };

    GetConfigValueResponse? response = await Repository.callGetConfigValueApi(request);

    if(response != null) {
      if(response.responseCode == 0) {
        List<String> requiredFieldList = response.responseData?.data?.AnonymousToReg?.split(",") ?? [];
        emit(GetConfigValueSuccess(requiredFieldList));

      } else {
        emit(GetConfigValueError(response.responseMessage ?? "Something went wrong"));
      }
    } else {
      emit(GetConfigValueError("Something went wrong, Please try after time"));
    }
  }


}
