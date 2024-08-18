// To parse this JSON data, do
//
//     final postLoginPlayerProfile = postLoginPlayerProfileFromJson(jsonString);

import 'dart:convert';

PostLoginPlayerProfile postLoginPlayerProfileFromJson(String str) =>
    PostLoginPlayerProfile.fromJson(json.decode(str));

String postLoginPlayerProfileToJson(PostLoginPlayerProfile data) =>
    json.encode(data.toJson());

class PostLoginPlayerProfile {
  PostLoginPlayerProfile({
    this.mapping,
    this.playerInfoBean,
    this.profileStatus,
    this.errorCode,
    this.ramPlayerInfo,
    required this.latestDocuments,
    this.profileUpdate,
    this.ramPlayerData,
    this.domainName,
    this.basicPlayerInfo,
    this.docUploadStatus,
    this.fistDeposited,
    this.ramAddressInfo,
  });

  Mapping? mapping;
  PlayerInfoBean? playerInfoBean;
  String? profileStatus;
  int? errorCode;
  RamPlayerInfo? ramPlayerInfo;
  List<LatestDocument?> latestDocuments;
  bool? profileUpdate;
  RamPlayerData? ramPlayerData;
  String? domainName;
  BasicPlayerInfo? basicPlayerInfo;
  String? docUploadStatus;
  bool? fistDeposited;
  RamAddressInfo? ramAddressInfo;

  factory PostLoginPlayerProfile.fromJson(Map<String, dynamic> json) =>
      PostLoginPlayerProfile(
        mapping: Mapping.fromJson(json["mapping"]),
        playerInfoBean: PlayerInfoBean.fromJson(json["playerInfoBean"]),
        profileStatus: json["profileStatus"],
        errorCode: json["errorCode"],
        ramPlayerInfo: RamPlayerInfo.fromJson(json["ramPlayerInfo"]),
        latestDocuments: List<LatestDocument>.from(
            json["latestDocuments"].map((x) => LatestDocument.fromJson(x))),
        profileUpdate: json["profileUpdate"],
        ramPlayerData: RamPlayerData.fromJson(json["ramPlayerData"]),
        domainName: json["domainName"],
        basicPlayerInfo: BasicPlayerInfo.fromJson(json["basicPlayerInfo"]),
        docUploadStatus: json["docUploadStatus"],
        fistDeposited: json["fistDeposited"],
        ramAddressInfo: RamAddressInfo.fromJson(json["ramAddressInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "mapping": mapping?.toJson(),
        "playerInfoBean": playerInfoBean?.toJson(),
        "profileStatus": profileStatus,
        "errorCode": errorCode,
        "ramPlayerInfo": ramPlayerInfo?.toJson(),
        "latestDocuments": latestDocuments.isNotEmpty
            ? List<LatestDocument>.from(latestDocuments.map((x) => x?.toJson()))
            : null,
        "profileUpdate": profileUpdate,
        "ramPlayerData": ramPlayerData?.toJson(),
        "domainName": domainName,
        "basicPlayerInfo": basicPlayerInfo?.toJson(),
        "docUploadStatus": docUploadStatus,
        "fistDeposited": fistDeposited,
        "ramAddressInfo": ramAddressInfo?.toJson(),
      };
}

class BasicPlayerInfo {
  BasicPlayerInfo({
    this.id,
    this.playerId,
    this.domainId,
    this.aliasId,
    this.gender,
    this.dateOfBirth,
    this.firstName,
    this.middleName,
    this.lastName,
    this.addressOne,
    this.addressTwo,
    this.city,
    this.town,
    this.state,
    this.country,
    this.zip,
    this.currencyCode,
    this.regCity,
    this.regCountryCode,
    this.regIp,
    this.reason,
    this.invalidChangepwdTry,
    this.invalidChangepwdDate,
    this.playerAge,
    this.smsOpted,
    this.emailOpted,
    this.fcmIdAndroid,
    this.fcmIdIos,
    this.currAppVer,
    this.primaryIdValue,
    this.isPep,
    this.nationality,
  });

  int? id;
  int? playerId;
  int? domainId;
  int? aliasId;
  String? gender;
  String? dateOfBirth;
  String? firstName;
  String? middleName;
  String? lastName;
  String? addressOne;
  String? addressTwo;
  String? city;
  String? town;
  String? state;
  String? country;
  String? zip;
  String? currencyCode;
  String? regCity;
  String? regCountryCode;
  String? regIp;
  String? reason;
  int? invalidChangepwdTry;
  String? invalidChangepwdDate;
  int? playerAge;
  String? smsOpted;
  String? emailOpted;
  String? fcmIdAndroid;
  String? fcmIdIos;
  String? currAppVer;
  String? primaryIdValue;
  String? isPep;
  String? nationality;

  factory BasicPlayerInfo.fromJson(Map<String, dynamic> json) =>
      BasicPlayerInfo(
        id: json["id"],
        playerId: json["playerId"],
        domainId: json["domainId"],
        aliasId: json["aliasId"],
        gender: json["gender"],
        dateOfBirth: json["dateOfBirth"],
        firstName: json["firstName"],
        middleName: json["middleName"],
        lastName: json["lastName"],
        addressOne: json["addressOne"],
        addressTwo: json["addressTwo"],
        city: json["city"],
        town: json["town"],
        state: json["state"],
        country: json["country"],
        zip: json["zip"],
        currencyCode: json["currencyCode"],
        regCity: json["regCity"],
        regCountryCode: json["regCountryCode"],
        regIp: json["regIp"],
        reason: json["reason"],
        invalidChangepwdTry: json["invalidChangepwdTry"],
        invalidChangepwdDate: json["invalidChangepwdDate"],
        playerAge: json["playerAge"],
        smsOpted: json["smsOpted"],
        emailOpted: json["emailOpted"],
        fcmIdAndroid: json["fcmIdAndroid"],
        fcmIdIos: json["fcmIdIos"],
        currAppVer: json["currAppVer"],
        primaryIdValue: json["primaryIdValue"],
        isPep: json["isPep"],
        nationality: json["nationality"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "playerId": playerId,
        "domainId": domainId,
        "aliasId": aliasId,
        "gender": gender,
        "dateOfBirth": dateOfBirth,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "addressOne": addressOne,
        "addressTwo": addressTwo,
        "city": city,
        "town": town,
        "state": state,
        "country": country,
        "zip": zip,
        "currencyCode": currencyCode,
        "regCity": regCity,
        "regCountryCode": regCountryCode,
        "regIp": regIp,
        "reason": reason,
        "invalidChangepwdTry": invalidChangepwdTry,
        "invalidChangepwdDate": invalidChangepwdDate,
        "playerAge": playerAge,
        "smsOpted": smsOpted,
        "emailOpted": emailOpted,
        "fcmIdAndroid": fcmIdAndroid,
        "fcmIdIos": fcmIdIos,
        "currAppVer": currAppVer,
        "primaryIdValue": primaryIdValue,
        "isPep": isPep,
        "nationality": nationality,
      };
}

class Mapping {
  Mapping();

  factory Mapping.fromJson(Map<String, dynamic> json) => Mapping();

  Map<String, dynamic> toJson() => {};
}

class PlayerInfoBean {
  PlayerInfoBean({
    this.playerId,
    this.firstName,
    this.lastName,
    this.userName,
    this.gender,
    this.dob,
    this.mobileNo,
    this.country,
    this.countryCode,
    this.emailVerified,
    this.phoneVerified,
    this.playerStatus,
    this.avatarPath,
    this.commonContentPath,
    this.currencyId,
    this.ussd,
    this.isOtpVerified,
    this.otpVerified,
    this.mobileNumber,
    this.walletBean,
    this.sms,
  });

  int? playerId;
  String? firstName;
  String? lastName;
  String? userName;
  String? gender;
  String? dob;
  int? mobileNo;
  String? country;
  String? countryCode;
  String? emailVerified;
  String? phoneVerified;
  String? playerStatus;
  String? avatarPath;
  String? commonContentPath;
  int? currencyId;
  bool? ussd;
  bool? isOtpVerified;
  bool? otpVerified;
  String? mobileNumber;
  WalletBean? walletBean;
  bool? sms;

  factory PlayerInfoBean.fromJson(Map<String, dynamic> json) => PlayerInfoBean(
        playerId: json["playerId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        userName: json["userName"],
        gender: json["gender"],
        dob: json["dob"],
        mobileNo: json["mobileNo"],
        country: json["country"],
        countryCode: json["countryCode"],
        emailVerified: json["emailVerified"],
        phoneVerified: json["phoneVerified"],
        playerStatus: json["playerStatus"],
        avatarPath: json["avatarPath"],
        commonContentPath: json["commonContentPath"],
        currencyId: json["currencyId"],
        ussd: json["ussd"],
        isOtpVerified: json["isOtpVerified"],
        otpVerified: json["otpVerified"],
        mobileNumber: json["mobileNumber"],
        walletBean: WalletBean.fromJson(json["walletBean"]),
        sms: json["sms"],
      );

  Map<String, dynamic> toJson() => {
        "playerId": playerId,
        "firstName": firstName,
        "lastName": lastName,
        "userName": userName,
        "gender": gender,
        "dob": dob,
        "mobileNo": mobileNo,
        "country": country,
        "countryCode": countryCode,
        "emailVerified": emailVerified,
        "phoneVerified": phoneVerified,
        "playerStatus": playerStatus,
        "avatarPath": avatarPath,
        "commonContentPath": commonContentPath,
        "currencyId": currencyId,
        "ussd": ussd,
        "isOtpVerified": isOtpVerified,
        "otpVerified": otpVerified,
        "mobileNumber": mobileNumber,
        "walletBean": walletBean?.toJson(),
        "sms": sms,
      };
}

class WalletBean {
  WalletBean({
    this.totalBalance,
    this.cashBalance,
    this.depositBalance,
    this.winningBalance,
    this.bonusBalance,
    this.withdrawableBal,
    this.practiceBalance,
    this.totalDepositBalance,
    this.totalWithdrawableBalance,
    this.totalWinningBalance,
  });

  int? totalBalance;
  int? cashBalance;
  int? depositBalance;
  int? winningBalance;
  int? bonusBalance;
  int? withdrawableBal;
  int? practiceBalance;
  int? totalDepositBalance;
  int? totalWithdrawableBalance;
  int? totalWinningBalance;

  factory WalletBean.fromJson(Map<String, dynamic> json) => WalletBean(
        totalBalance: json["totalBalance"],
        cashBalance: json["cashBalance"],
        depositBalance: json["depositBalance"],
        winningBalance: json["winningBalance"],
        bonusBalance: json["bonusBalance"],
        withdrawableBal: json["withdrawableBal"],
        practiceBalance: json["practiceBalance"],
        totalDepositBalance: json["totalDepositBalance"],
        totalWithdrawableBalance: json["totalWithdrawableBalance"],
        totalWinningBalance: json["totalWinningBalance"],
      );

  Map<String, dynamic> toJson() => {
        "totalBalance": totalBalance,
        "cashBalance": cashBalance,
        "depositBalance": depositBalance,
        "winningBalance": winningBalance,
        "bonusBalance": bonusBalance,
        "withdrawableBal": withdrawableBal,
        "practiceBalance": practiceBalance,
        "totalDepositBalance": totalDepositBalance,
        "totalWithdrawableBalance": totalWithdrawableBalance,
        "totalWinningBalance": totalWinningBalance,
      };
}

class RamAddressInfo {
  RamAddressInfo({
    this.zip,
    this.country,
    this.town,
    this.city,
    this.addressTwo,
    this.countryCode,
    this.stateCode,
    this.state,
    this.addressOne,
  });

  String? zip;
  String? country;
  String? town;
  String? city;
  String? addressTwo;
  String? countryCode;
  String? stateCode;
  String? state;
  String? addressOne;

  factory RamAddressInfo.fromJson(Map<String, dynamic> json) => RamAddressInfo(
        zip: json["zip"],
        country: json["country"],
        town: json["town"],
        city: json["city"],
        addressTwo: json["addressTwo"],
        countryCode: json["countryCode"],
        stateCode: json["stateCode"],
        state: json["state"],
        addressOne: json["addressOne"],
      );

  Map<String, dynamic> toJson() => {
        "zip": zip,
        "country": country,
        "town": town,
        "city": city,
        "addressTwo": addressTwo,
        "countryCode": countryCode,
        "stateCode": stateCode,
        "state": state,
        "addressOne": addressOne,
      };
}

class LatestDocument {
  LatestDocument({
    required this.docType,
    required this.validUpTo,
    required this.verifiedAt,
    required this.remark,
    required this.verifiedByUser,
    required this.uploadAt,
    required this.documentValue,
    required this.documentPath,
    required this.createdAt,
    required this.docName,
    required this.verificationMode,
    required this.id,
    required this.updatedAt,
    required this.status,
  });

  String? docType;
  String? validUpTo;
  dynamic verifiedAt;
  dynamic remark;
  dynamic verifiedByUser;
  String? uploadAt;
  String? documentValue;
  String? documentPath;
  String? createdAt;
  String? docName;
  String? verificationMode;
  dynamic id;
  String? updatedAt;
  String? status;

  factory LatestDocument.fromJson(Map<String, dynamic> json) => LatestDocument(
        docType: json["docType"],
        validUpTo: json["validUpTo"],
        verifiedAt: json["verifiedAt"],
        remark: json["remark"],
        verifiedByUser: json["verifiedByUser"],
        uploadAt: json["uploadAt"],
        documentValue: json["documentValue"],
        documentPath: json["documentPath"],
        createdAt: json["createdAt"],
        docName: json["docName"],
        verificationMode: json["verificationMode"],
        id: json["id"],
        updatedAt: json["updatedAt"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "docType": docType,
        "validUpTo": validUpTo,
        "verifiedAt": verifiedAt,
        "remark": remark,
        "verifiedByUser": verifiedByUser,
        "uploadAt": uploadAt,
        "documentValue": documentValue,
        "documentPath": documentPath,
        "createdAt": createdAt,
        "docName": docName,
        "verificationMode": verificationMode,
        "id": id,
        "updatedAt": updatedAt,
        "status": status,
      };
}

class RamPlayerData {
  RamPlayerData({
    this.playerId,
    this.merchantId,
    this.domainId,
    this.aliasId,
    this.merchantPlayerId,
    this.autoPassword,
    this.mobileNo,
    this.username,
    this.password,
    this.emailId,
    this.userImagePath,
    this.vipLevelId,
    this.registrationDate,
    this.lastLoginCity,
    this.lastLoginCountryCode,
    this.lastLoginIp,
    this.lastLoginThrough,
    this.profileStatus,
    this.plrStatus,
    this.profileExpiredAt,
    this.affiliateBind,
    this.affiliateId,
    this.affiliateReference,
    this.referFriendCode,
    this.regDevice,
    this.profileType,
    this.userAgent,
    this.invalidLoginTry,
    this.lastLoginDate,
    this.uploadPendingDate,
    this.createdAt,
    this.updatedAt,
    this.securityQuestionCount,
    this.inactiveDate,
    this.accountStatus,
    this.failedLoginBlockDate,
  });

  int? playerId;
  int? merchantId;
  int? domainId;
  int? aliasId;
  String? merchantPlayerId;
  String? autoPassword;
  String? mobileNo;
  String? username;
  String? password;
  String? emailId;
  String? userImagePath;
  int? vipLevelId;
  String? registrationDate;
  String? lastLoginCity;
  String? lastLoginCountryCode;
  String? lastLoginIp;
  String? lastLoginThrough;
  String? profileStatus;
  String? plrStatus;
  dynamic profileExpiredAt;
  String? affiliateBind;
  dynamic affiliateId;
  dynamic affiliateReference;
  String? referFriendCode;
  String? regDevice;
  String? profileType;
  String? userAgent;
  int? invalidLoginTry;
  String? lastLoginDate;
  dynamic uploadPendingDate;
  String? createdAt;
  String? updatedAt;
  int? securityQuestionCount;
  dynamic inactiveDate;
  String? accountStatus;
  dynamic failedLoginBlockDate;

  factory RamPlayerData.fromJson(Map<String, dynamic> json) => RamPlayerData(
        playerId: json["playerId"],
        merchantId: json["merchantId"],
        domainId: json["domainId"],
        aliasId: json["aliasId"],
        merchantPlayerId: json["merchantPlayerId"],
        autoPassword: json["autoPassword"],
        mobileNo: json["mobileNo"],
        username: json["username"],
        password: json["password"],
        emailId: json["emailId"],
        userImagePath: json["userImagePath"],
        vipLevelId: json["vipLevelId"],
        registrationDate: json["registrationDate"],
        lastLoginCity: json["lastLoginCity"],
        lastLoginCountryCode: json["lastLoginCountryCode"],
        lastLoginIp: json["lastLoginIp"],
        lastLoginThrough: json["lastLoginThrough"],
        profileStatus: json["profileStatus"],
        plrStatus: json["plrStatus"],
        profileExpiredAt: json["profileExpiredAt"],
        affiliateBind: json["affiliateBind"],
        affiliateId: json["affiliateId"],
        affiliateReference: json["affiliateReference"],
        referFriendCode: json["referFriendCode"],
        regDevice: json["regDevice"],
        profileType: json["profileType"],
        userAgent: json["userAgent"],
        invalidLoginTry: json["invalidLoginTry"],
        lastLoginDate: json["lastLoginDate"],
        uploadPendingDate: json["uploadPendingDate"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        securityQuestionCount: json["securityQuestionCount"],
        inactiveDate: json["inactiveDate"],
        accountStatus: json["accountStatus"],
        failedLoginBlockDate: json["failedLoginBlockDate"],
      );

  Map<String, dynamic> toJson() => {
        "playerId": playerId,
        "merchantId": merchantId,
        "domainId": domainId,
        "aliasId": aliasId,
        "merchantPlayerId": merchantPlayerId,
        "autoPassword": autoPassword,
        "mobileNo": mobileNo,
        "username": username,
        "password": password,
        "emailId": emailId,
        "userImagePath": userImagePath,
        "vipLevelId": vipLevelId,
        "registrationDate": registrationDate,
        "lastLoginCity": lastLoginCity,
        "lastLoginCountryCode": lastLoginCountryCode,
        "lastLoginIp": lastLoginIp,
        "lastLoginThrough": lastLoginThrough,
        "profileStatus": profileStatus,
        "plrStatus": plrStatus,
        "profileExpiredAt": profileExpiredAt,
        "affiliateBind": affiliateBind,
        "affiliateId": affiliateId,
        "affiliateReference": affiliateReference,
        "referFriendCode": referFriendCode,
        "regDevice": regDevice,
        "profileType": profileType,
        "userAgent": userAgent,
        "invalidLoginTry": invalidLoginTry,
        "lastLoginDate": lastLoginDate,
        "uploadPendingDate": uploadPendingDate,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "securityQuestionCount": securityQuestionCount,
        "inactiveDate": inactiveDate,
        "accountStatus": accountStatus,
        "failedLoginBlockDate": failedLoginBlockDate,
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
  String? profileExpiredAt;
  String? docUploaded;
  String? uploadPendingDate;
  String? verifiedBy;
  String? verificationAssignAt;
  String? verificationModeAt;
  String? addressVerifiedBy;
  String? idVerifiedBy;
  String? bankVerifiedBy;

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
      };
}
