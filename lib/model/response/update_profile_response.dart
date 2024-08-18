// To parse this JSON data, do
//
//     final updateProfileResponse = updateProfileResponseFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponse updateProfileResponseFromJson(String str) =>
    UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileResponseToJson(UpdateProfileResponse data) =>
    json.encode(data.toJson());

class UpdateProfileResponse {
  UpdateProfileResponse({
    this.errorMessage,
    this.errorCode,
    this.data,
  });

  String? errorMessage;
  int? errorCode;
  Data? data;

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponse(
        errorMessage: json["errorMessage"],
        errorCode: json["errorCode"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "errorMessage": errorMessage,
        "errorCode": errorCode,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.latestDocuments,
    this.playerVerificationStatus,
    this.playerInfo,
    this.playerMaster,
  });

  List<LatestDocument?> latestDocuments;
  PlayerVerificationStatus? playerVerificationStatus;
  PlayerInfo? playerInfo;
  PlayerMaster? playerMaster;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        latestDocuments: List<LatestDocument>.from(
            json["latestDocuments"].map((x) => LatestDocument.fromJson(x))),
        playerVerificationStatus:
            PlayerVerificationStatus.fromJson(json["playerVerificationStatus"]),
        playerInfo: PlayerInfo.fromJson(json["playerInfo"]),
        playerMaster: PlayerMaster.fromJson(json["playerMaster"]),
      );

  Map<String, dynamic> toJson() => {
        "latestDocuments": latestDocuments.isNotEmpty
            ? List<LatestDocument>.from(latestDocuments.map((x) => x?.toJson()))
            : null,
        "playerVerificationStatus": playerVerificationStatus?.toJson(),
        "playerInfo": playerInfo?.toJson(),
        "playerMaster": playerMaster?.toJson(),
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

class PlayerInfo {
  PlayerInfo({
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
    this.playerType,
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
  String? playerType;
  int? invalidChangepwdTry;
  dynamic invalidChangepwdDate;
  int? playerAge;
  dynamic smsOpted;
  dynamic emailOpted;
  dynamic fcmIdAndroid;
  dynamic fcmIdIos;
  dynamic currAppVer;
  dynamic primaryIdValue;
  dynamic isPep;
  dynamic nationality;

  factory PlayerInfo.fromJson(Map<String, dynamic> json) => PlayerInfo(
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
        playerType: json["playerType"],
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
        "playerType": playerType,
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

class PlayerMaster {
  PlayerMaster({
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

  factory PlayerMaster.fromJson(Map<String, dynamic> json) => PlayerMaster(
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

class PlayerVerificationStatus {
  PlayerVerificationStatus({
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
  dynamic profileExpiredAt;
  String? docUploaded;
  dynamic uploadPendingDate;
  dynamic verifiedBy;
  dynamic verificationAssignAt;
  dynamic verificationModeAt;
  dynamic addressVerifiedBy;
  dynamic idVerifiedBy;
  dynamic bankVerifiedBy;

  factory PlayerVerificationStatus.fromJson(Map<String, dynamic> json) =>
      PlayerVerificationStatus(
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
