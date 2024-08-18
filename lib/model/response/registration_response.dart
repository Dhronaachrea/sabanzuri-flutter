import 'dart:convert';

RegistrationResponse registrationResponseFromJson(String str) =>
    RegistrationResponse.fromJson(json.decode(str));

String registrationResponseToJson(RegistrationResponse data) =>
    json.encode(data.toJson());

class RegistrationResponse {
  RegistrationResponse({
    this.firstDepositCampTrackId,
    this.mapping,
    this.domainName,
    this.firstDepositReferSource,
    required this.playerLoginInfo,
    this.rummyDeepLink,
    this.firstDepositReferSourceId,
    this.profileStatus,
    this.errorCode,
    this.firstDepositSubSourceId,
    this.ramPlayerInfo,
    this.playerToken,
    this.errorMessage,
    this.respMsg,
  });

  int? firstDepositCampTrackId;
  Mapping? mapping;
  String? domainName;
  String? firstDepositReferSource;
  PlayerLoginInfo? playerLoginInfo;
  String? rummyDeepLink;
  int? firstDepositReferSourceId;
  String? profileStatus;
  int? errorCode;
  int? firstDepositSubSourceId;
  RamPlayerInfo? ramPlayerInfo;
  String? playerToken;
  String? errorMessage;
  String? respMsg;

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) =>
      RegistrationResponse(
        firstDepositCampTrackId: json["firstDepositCampTrackId"],
        mapping:
            json["mapping"] != null ? Mapping.fromJson(json["mapping"]) : null,
        domainName: json["domainName"],
        firstDepositReferSource: json["firstDepositReferSource"],
        playerLoginInfo:
            json["playerLoginInfo"] != null && json["playerLoginInfo"] != ""
                ? PlayerLoginInfo.fromJson(json["playerLoginInfo"])
                : null,
        rummyDeepLink: json["rummyDeepLink"],
        firstDepositReferSourceId: json["firstDepositReferSourceId"],
        profileStatus: json["profileStatus"],
        errorCode: json["errorCode"],
        firstDepositSubSourceId: json["firstDepositSubSourceId"],
        ramPlayerInfo: json["ramPlayerInfo"] != null
            ? RamPlayerInfo.fromJson(json["ramPlayerInfo"])
            : null,
        playerToken: json["playerToken"],
        errorMessage: json["errorMessage"],
        respMsg: json["respMsg"],
      );

  Map<String, dynamic> toJson() => {
        "firstDepositCampTrackId": firstDepositCampTrackId,
        "mapping": mapping?.toJson(),
        "domainName": domainName,
        "firstDepositReferSource": firstDepositReferSource,
        "playerLoginInfo": playerLoginInfo?.toJson(),
        "rummyDeepLink": rummyDeepLink,
        "firstDepositReferSourceId": firstDepositReferSourceId,
        "profileStatus": profileStatus,
        "errorCode": errorCode,
        "firstDepositSubSourceId": firstDepositSubSourceId,
        "ramPlayerInfo": ramPlayerInfo?.toJson(),
        "playerToken": playerToken,
        "errorMessage": errorMessage,
        "respMsg": respMsg,
      };
}

class Mapping {
  Mapping();

  factory Mapping.fromJson(Map<String, dynamic> json) => Mapping();

  Map<String, dynamic> toJson() => {};
}

class PlayerLoginInfo {
  PlayerLoginInfo({
    this.unreadMsgCount,
    this.lastName,
    this.country,
    required this.walletBean,
    this.gender,
    this.autoPassword,
    this.regDevice,
    this.isSmsService,
    this.ageVerified,
    this.emailId,
    this.dateOfBirth,
    this.addressLine1,
    this.lastLoginDate,
    this.firstLoginDate,
    this.communicationCharge,
    this.countryCode,
    this.playerType,
    this.registrationDate,
    this.state,
    this.playerStatus,
    this.referSource,
    this.addressVerified,
    this.playerId,
    this.affilateId,
    this.referFriendCode,
    this.phoneVerified,
    this.avatarPath,
    this.mobileNo,
    required this.userName,
    this.registrationIp,
    this.olaPlayer,
    this.lastLoginIp,
    this.isPlay2X,
    this.firstName,
    this.emailVerified,
    this.dob,
    this.commonContentPath,
    this.isEmailService,
    this.firstDepositDate,
  });

  int? unreadMsgCount;
  String? lastName;
  String? country;
  WalletBean walletBean;
  String? gender;
  String? autoPassword;
  String? regDevice;
  String? isSmsService;
  String? ageVerified;
  String? emailId;
  String? dateOfBirth;
  String? addressLine1;
  DateTime? lastLoginDate;
  DateTime? firstLoginDate;
  String? communicationCharge;
  String? countryCode;
  String? playerType;
  DateTime? registrationDate;
  String? state;
  String? playerStatus;
  String? referSource;
  String? addressVerified;
  int? playerId;
  int? affilateId;
  String? referFriendCode;
  String? phoneVerified;
  String? avatarPath;
  String? mobileNo;
  String userName;
  String? registrationIp;
  String? olaPlayer;
  String? lastLoginIp;
  String? isPlay2X;
  String? firstName;
  String? emailVerified;
  String? dob;
  String? commonContentPath;
  String? isEmailService;
  String? firstDepositDate;

  factory PlayerLoginInfo.fromJson(Map<String, dynamic> json) =>
      PlayerLoginInfo(
        unreadMsgCount: json["unreadMsgCount"],
        lastName: json["lastName"],
        country: json["country"],
        walletBean: WalletBean.fromJson(json["walletBean"]),
        gender: json["gender"],
        autoPassword: json["autoPassword"],
        regDevice: json["regDevice"],
        isSmsService: json["isSmsService"],
        ageVerified: json["ageVerified"],
        emailId: json["emailId"],
        dateOfBirth: json["dateOfBirth"],
        addressLine1: json["addressLine1"],
        lastLoginDate:
            json["lastLoginDate"] != null && json["lastLoginDate"] != ""
                ? DateTime.parse(json["lastLoginDate"])
                : DateTime.now(),
        firstLoginDate:
            json["firstLoginDate"] != null && json["firstLoginDate"] != ""
                ? DateTime.parse(json["firstLoginDate"])
                : DateTime.now(),
        communicationCharge: json["communicationCharge"],
        countryCode: json["countryCode"],
        playerType: json["playerType"],
        registrationDate: DateTime.parse(json["registrationDate"]),
        state: json["state"],
        playerStatus: json["playerStatus"],
        referSource: json["referSource"],
        addressVerified: json["addressVerified"],
        playerId: json["playerId"],
        affilateId: json["affilateId"],
        referFriendCode: json["referFriendCode"],
        phoneVerified: json["phoneVerified"],
        avatarPath: json["avatarPath"],
        mobileNo: json["mobileNo"],
        userName: json["userName"],
        registrationIp: json["registrationIp"],
        olaPlayer: json["olaPlayer"],
        lastLoginIp: json["lastLoginIP"],
        isPlay2X: json["isPlay2x"],
        firstName: json["firstName"],
        emailVerified: json["emailVerified"],
        dob: json["dob"],
        commonContentPath: json["commonContentPath"],
        isEmailService: json["isEmailService"],
        firstDepositDate: json["firstDepositDate"],
      );

  Map<String, dynamic> toJson() => {
        "unreadMsgCount": unreadMsgCount,
        "lastName": lastName,
        "country": country,
        "walletBean": walletBean.toJson(),
        "gender": gender,
        "autoPassword": autoPassword,
        "regDevice": regDevice,
        "isSmsService": isSmsService,
        "ageVerified": ageVerified,
        "addressLine1": addressLine1,
        "lastLoginDate": lastLoginDate?.toIso8601String(),
        "firstLoginDate": firstLoginDate?.toIso8601String(),
        "communicationCharge": communicationCharge,
        "countryCode": countryCode,
        "playerType": playerType,
        "registrationDate": registrationDate?.toIso8601String(),
        "state": state,
        "playerStatus": playerStatus,
        "referSource": referSource,
        "addressVerified": addressVerified,
        "playerId": playerId,
        "affilateId": affilateId,
        "referFriendCode": referFriendCode,
        "phoneVerified": phoneVerified,
        "avatarPath": avatarPath,
        "mobileNo": mobileNo,
        "userName": userName,
        "registrationIp": registrationIp,
        "olaPlayer": olaPlayer,
        "lastLoginIP": lastLoginIp,
        "isPlay2x": isPlay2X,
        "firstName": firstName,
        "emailVerified": emailVerified,
        "dob": dob,
        "commonContentPath": commonContentPath,
        "isEmailService": isEmailService,
        "firstDepositDate": firstDepositDate,
      };
}

class WalletBean {
  WalletBean({
    this.totalBalance,
    required this.cashBalance,
    this.depositBalance,
    this.winningBalance,
    this.bonusBalance,
    this.withdrawableBal,
    this.practiceBalance,
    this.currency,
    this.currencyDisplayCode,
    this.preferredWallet,
    this.totalDepositBalance,
    this.totalWithdrawableBalance,
  });

  double? totalBalance;
  double cashBalance;
  double? depositBalance;
  double? winningBalance;
  double? bonusBalance;
  double? withdrawableBal;
  double? practiceBalance;
  String? currency;
  String? currencyDisplayCode;
  String? preferredWallet;
  double? totalDepositBalance;
  double? totalWithdrawableBalance;

  factory WalletBean.fromJson(Map<String, dynamic> json) => WalletBean(
        totalBalance: json["totalBalance"],
        cashBalance: json["cashBalance"],
        depositBalance: json["depositBalance"],
        winningBalance: json["winningBalance"],
        bonusBalance: json["bonusBalance"],
        withdrawableBal: json["withdrawableBal"],
        practiceBalance: json["practiceBalance"],
        currency: json["currency"],
        currencyDisplayCode: json["currencyDisplayCode"],
        preferredWallet: json["preferredWallet"],
        totalDepositBalance: json["totalDepositBalance"],
        totalWithdrawableBalance: json["totalWithdrawableBalance"],
      );

  Map<String, dynamic> toJson() => {
        "totalBalance": totalBalance,
        "cashBalance": cashBalance,
        "depositBalance": depositBalance,
        "winningBalance": winningBalance,
        "bonusBalance": bonusBalance,
        "withdrawableBal": withdrawableBal,
        "practiceBalance": practiceBalance,
        "currency": currency,
        "currencyDisplayCode": currencyDisplayCode,
        "preferredWallet": preferredWallet,
        "totalDepositBalance": totalDepositBalance,
        "totalWithdrawableBalance": totalWithdrawableBalance,
      };
}

class RamPlayerInfo {
  RamPlayerInfo({
    this.id,
    this.merchantId,
    this.domainId,
    this.playerId,
    this.addressVerified,
    this.nameVerified,
    this.emailVerified,
    this.mobileVerified,
    this.ageVerified,
    this.emailId,
    this.dateOfBirth,
    this.addressLine1,
    this.taxationIdVerified,
    this.securityQuestionVerified,
    this.idVerified,
    this.bankVerified,
    this.addressVerifiedAt,
    this.profileStatus,
    this.kycStatus,
    this.emailVerifiedAt,
    this.mobileVerifiedAt,
    this.ageVerifiedAt,
    this.taxationIdVerifiedAt,
    this.securityQuestionVerifiedAt,
    this.idVerifiedAt,
    this.bankVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.profileExpiredAt,
    this.docUploaded,
    this.uploadPendingDate,
    this.verifiedBy,
    this.verificationAssignAt,
    this.verificationModeAt,
    this.addressVerifiedBy,
    this.idVerifiedBy,
    this.bankVerifiedBy,
    this.isMpinExist,
    this.forceUpdatePassword,
    this.profileType,
    this.aliasName,
  });

  int? id;
  int? merchantId;
  int? domainId;
  int? playerId;
  String? addressVerified;
  String? nameVerified;
  String? emailVerified;
  String? mobileVerified;
  String? ageVerified;
  String? emailId;
  String? dateOfBirth;
  String? addressLine1;
  String? taxationIdVerified;
  String? securityQuestionVerified;
  String? idVerified;
  String? bankVerified;
  String? addressVerifiedAt;
  String? profileStatus;
  String? kycStatus;
  String? emailVerifiedAt;
  String? mobileVerifiedAt;
  String? ageVerifiedAt;
  String? taxationIdVerifiedAt;
  String? securityQuestionVerifiedAt;
  String? idVerifiedAt;
  String? bankVerifiedAt;
  String? createdAt;
  String? updatedAt;
  dynamic profileExpiredAt;
  String? docUploaded;
  dynamic uploadPendingDate;
  dynamic verifiedBy;
  dynamic verificationAssignAt;
  dynamic verificationModeAt;
  dynamic addressVerifiedBy;
  dynamic idVerifiedBy;
  dynamic bankVerifiedBy;
  String? isMpinExist;
  String? forceUpdatePassword;
  String? profileType;
  String? aliasName;

  factory RamPlayerInfo.fromJson(Map<String, dynamic> json) => RamPlayerInfo(
        id: json["id"],
        merchantId: json["merchantId"],
        domainId: json["domainId"],
        playerId: json["playerId"],
        addressVerified: json["addressVerified"],
        nameVerified: json["nameVerified"],
        emailVerified: json["emailVerified"],
        mobileVerified: json["mobileVerified"],
        ageVerified: json["ageVerified"],
        emailId: json["emailId"],
    dateOfBirth: json["dateOfBirth"],
        addressLine1: json["addressLine1"],
        taxationIdVerified: json["taxationIdVerified"],
        securityQuestionVerified: json["securityQuestionVerified"],
        idVerified: json["idVerified"],
        bankVerified: json["bankVerified"],
        addressVerifiedAt: json["addressVerifiedAt"],
        profileStatus: json["profileStatus"],
        kycStatus: json["kycStatus"],
        emailVerifiedAt: json["emailVerifiedAt"],
        mobileVerifiedAt: json["mobileVerifiedAt"],
        ageVerifiedAt: json["ageVerifiedAt"],
        taxationIdVerifiedAt: json["taxationIdVerifiedAt"],
        securityQuestionVerifiedAt: json["securityQuestionVerifiedAt"],
        idVerifiedAt: json["idVerifiedAt"],
        bankVerifiedAt: json["bankVerifiedAt"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        profileExpiredAt: json["profileExpiredAt"],
        docUploaded: json["docUploaded"],
        uploadPendingDate: json["uploadPendingDate"],
        verifiedBy: json["verifiedBy"],
        verificationAssignAt: json["verificationAssignAt"],
        verificationModeAt: json["verificationModeAt"],
        addressVerifiedBy: json["addressVerifiedBy"],
        idVerifiedBy: json["idVerifiedBy"],
        bankVerifiedBy: json["bankVerifiedBy"],
        isMpinExist: json["isMpinExist"],
        forceUpdatePassword: json["forceUpdatePassword"],
        profileType: json["profileType"],
        aliasName: json["aliasName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "merchantId": merchantId,
        "domainId": domainId,
        "playerId": playerId,
        "addressVerified": addressVerified,
        "nameVerified": nameVerified,
        "emailVerified": emailVerified,
        "mobileVerified": mobileVerified,
        "ageVerified": ageVerified,
        "emailId": emailId,
        "dateOfBirth": dateOfBirth,
        "addressLine1": addressLine1,
        "taxationIdVerified": taxationIdVerified,
        "securityQuestionVerified": securityQuestionVerified,
        "idVerified": idVerified,
        "bankVerified": bankVerified,
        "addressVerifiedAt": addressVerifiedAt,
        "profileStatus": profileStatus,
        "kycStatus": kycStatus,
        "emailVerifiedAt": emailVerifiedAt,
        "mobileVerifiedAt": mobileVerifiedAt,
        "ageVerifiedAt": ageVerifiedAt,
        "taxationIdVerifiedAt": taxationIdVerifiedAt,
        "securityQuestionVerifiedAt": securityQuestionVerifiedAt,
        "idVerifiedAt": idVerifiedAt,
        "bankVerifiedAt": bankVerifiedAt,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "profileExpiredAt": profileExpiredAt,
        "docUploaded": docUploaded,
        "uploadPendingDate": uploadPendingDate,
        "verifiedBy": verifiedBy,
        "verificationAssignAt": verificationAssignAt,
        "verificationModeAt": verificationModeAt,
        "addressVerifiedBy": addressVerifiedBy,
        "idVerifiedBy": idVerifiedBy,
        "bankVerifiedBy": bankVerifiedBy,
        "isMpinExist": isMpinExist,
        "forceUpdatePassword": forceUpdatePassword,
        "profileType": profileType,
        "aliasName": aliasName,
      };
}
