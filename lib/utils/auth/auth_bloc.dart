import 'dart:async';
import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sabanzuri/model/response/registration_response.dart';
import 'package:sabanzuri/model/user/user.dart';
import 'package:sabanzuri/utils/url.dart';
import 'package:sabanzuri/utils/user_info.dart';


part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<UserLogin>(_onLoginEvent);
    on<UserLogout>(_onLogoutEvent);
    on<UpdateUserInfo>(_onUpdateUserEvent);
  }
  String? currencyCode;
  String? referCode;
  String? countryName;
  String? cashBalance;
  String? userName;
  String? totalBalance;
  String? mobNumber;
  String? email;
  String? dob;
  String? gender;
  String? address;
  String? profileImage;
  String? firstName;
  String? lastName;
  String? forceUpdatePassword;
  String? profileType;

  FutureOr<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) {
    if (UserInfo.isLoggedIn()) {
      userName = UserInfo.userName;
      currencyCode = UserInfo.getCurrencyCode;
      referCode = UserInfo.getReferCode;
      countryName = UserInfo.getCountryName;
      cashBalance = UserInfo.cashBalance;
      totalBalance = UserInfo.totalBalance;
      mobNumber = UserInfo.mobNumber;
      email = UserInfo.email;
      dob = UserInfo.dob;
      gender = UserInfo.gender;
      address = UserInfo.address;
      profileImage = UserInfo.profileImage;
      firstName = UserInfo.firstName;
      lastName = UserInfo.lastName;
      forceUpdatePassword = UserInfo.forceUpdatePassword;
      profileType = UserInfo.profileType;
      emit(AuthLoggedIn());
    } else {
      emit(AuthLoggedOut());
    }
  }

  FutureOr<void> _onLoginEvent(UserLogin event, Emitter<AuthState> emit) {
    RegistrationResponse response = event.registrationResponse;
    PlayerLoginInfo playerInfo = response.playerLoginInfo!;
    RamPlayerInfo ramPlayerInfo = response.ramPlayerInfo!;
    WalletBean walletBean = playerInfo.walletBean;
    currencyCode = walletBean.currency ?? "";
    referCode = response.playerLoginInfo?.referFriendCode ?? "";
    cashBalance = walletBean.withdrawableBal != 0.0 ? walletBean.withdrawableBal?.toStringAsFixed(2) : walletBean.cashBalance.toStringAsFixed(2);
    totalBalance = walletBean.withdrawableBal != 0.0 ? walletBean.withdrawableBal?.toStringAsFixed(2) : walletBean.totalBalance?.toStringAsFixed(2);
    firstName = playerInfo.firstName ?? '';
    lastName = playerInfo.lastName ?? '';
    forceUpdatePassword = ramPlayerInfo.forceUpdatePassword ?? '';
    profileType = ramPlayerInfo.profileType ?? '';
    var name = "$firstName $lastName";
    print("walletBean.totalWithdrawableBalance: $cashBalance");
    print("name ------------------------------------>$name ");
    print("name isEmpty ------------------------------------>${name.isEmpty}");
    print("name == " " ------------------------------------>${name == " "}");
    print("playerInfo.userName ------------------------------------>${playerInfo.userName}");
    print("forceUpdatePassword ------------------------------------>$forceUpdatePassword");
    print("profileType ------------------------------------>$profileType");
    print("playerToken ------------------------------------>${response.playerToken}");

    userName = name == " " ? playerInfo.userName : name;
    mobNumber = playerInfo.mobileNo;
    dob = playerInfo.dob;
    gender = playerInfo.gender;
    profileImage = Url.AVATAR_BASE_URL + (playerInfo.avatarPath ?? "");
    email = playerInfo.emailId;
    address = playerInfo.addressLine1;
    UserInfo.setPlayerId(playerInfo.playerId.toString());
    UserInfo.setPlayerToken(response.playerToken!.toString());
    UserInfo.setCurrencyDisplayCode(walletBean.currencyDisplayCode ?? "");
    UserInfo.setUserName(userName!);
    UserInfo.setCurrencyCode(currencyCode ?? "");
    UserInfo.setReferCode(referCode ?? "");
    UserInfo.setCashBalance(cashBalance ?? "0");
    UserInfo.setTotalBalance(totalBalance ?? "0");
    UserInfo.setMobNumber(mobNumber ?? "");
    UserInfo.setEmail(email ?? "");
    UserInfo.setDob(dob ?? "");
    UserInfo.setGender(gender ?? "");
    UserInfo.setAddress(address ?? "");
    UserInfo.setProfileImage(profileImage ?? "");
    UserInfo.setFirstName(firstName ?? "");
    UserInfo.setLastName(lastName ?? "");
    UserInfo.setForceUpdatePassword( forceUpdatePassword ?? "");
    UserInfo.setProfileType( profileType ?? "");
    UserInfo.setRegistrationResponse(jsonEncode(event.registrationResponse));
    print("UserInfo.getRegistrationResponse() -> ${UserInfo.getRegistrationResponse()}");
    emit(AuthLoggedIn());
  }

  FutureOr<void> _onLogoutEvent(UserLogout event, Emitter<AuthState> emit) {
    UserInfo.logout();
    emit(AuthLoggedOut());
  }

  FutureOr<void> _onUpdateUserEvent(
      UpdateUserInfo event, Emitter<AuthState> emit) {
    User user = event.user;

    if (user.userName != null) {
      userName = user.userName.toString();
      UserInfo.setUserName(userName ?? "");
    }
    if (user.cashBalance != null) {
      cashBalance = user.cashBalance.toString();
      UserInfo.setCashBalance(cashBalance ?? "0");
    }
    if (user.totalBalance != null) {
      totalBalance = user.totalBalance.toString();
      UserInfo.setTotalBalance(totalBalance ?? "0");
    }

    if (user.userName != null) {
      userName = user.userName.toString();
      UserInfo.setTotalBalance(userName ?? "");
    }
    if (user.mobNumber != null) {
      mobNumber = user.mobNumber.toString();
      UserInfo.setMobNumber(mobNumber ?? "");
    }
    if (user.email != null) {
      email = user.email.toString();
      UserInfo.setEmail(email ?? "");
    }
    if (user.gender != null) {
      gender = user.gender.toString();
      UserInfo.setGender(gender ?? "");
    }
    if (user.dob != null) {
      dob = user.dob.toString().split(" ")[0];
      UserInfo.setDob(dob ?? "");
    }
    if (user.address != null) {
      address = user.address.toString();
      UserInfo.setAddress(address ?? "");
    }
    if (user.profileImage != null) {
      profileImage = user.profileImage.toString();
      UserInfo.setProfileImage(profileImage ?? "");
    }
    if (user.firstName != null) {
      firstName = user.firstName.toString();
      UserInfo.setFirstName(firstName ?? "");
    }
    if (user.lastName != null) {
      lastName = user.lastName.toString();
      UserInfo.setLastName(lastName ?? "");
    }
    if (user.playerType != null) {
      profileType = user.playerType.toString();
      UserInfo.setProfileType(profileType ?? "");
    }
    emit(UserInfoUpdated(user: user));
  }
}
