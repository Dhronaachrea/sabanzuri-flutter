// To parse this JSON data, do
//
//     final otpResponse = otpResponseFromJson(jsonString);

import 'dart:convert';

OtpResponse otpResponseFromJson(String str) =>
    OtpResponse.fromJson(json.decode(str));

String otpResponseToJson(OtpResponse data) => json.encode(data.toJson());

class OtpResponse {
  OtpResponse({
    this.errorMessage,
    this.errorCode,
    this.data,
  });

  String? errorMessage;
  int? errorCode;
  Data? data;

  factory OtpResponse.fromJson(Map<String, dynamic> json) => OtpResponse(
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
    this.mobVerificationExpiry,
    this.mobVerificationCode,
    this.emailId,
    this.emailVerificationExpiry,
    this.id,
    this.mobileNo,
    this.otpActionType,
    this.domainId,
    this.emailVerificationCode,
  });

  int? mobVerificationExpiry;
  String? mobVerificationCode;
  dynamic emailId;
  dynamic emailVerificationExpiry;
  int? id;
  String? mobileNo;
  String? otpActionType;
  int? domainId;
  dynamic emailVerificationCode;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        mobVerificationExpiry: json["mobVerificationExpiry"],
        mobVerificationCode: json["mobVerificationCode"],
        emailId: json["emailId"],
        emailVerificationExpiry: json["emailVerificationExpiry"],
        id: json["id"],
        mobileNo: json["mobileNo"],
        otpActionType: json["otpActionType"],
        domainId: json["domainId"],
        emailVerificationCode: json["emailVerificationCode"],
      );

  Map<String, dynamic> toJson() => {
        "mobVerificationExpiry": mobVerificationExpiry,
        "mobVerificationCode": mobVerificationCode,
        "emailId": emailId,
        "emailVerificationExpiry": emailVerificationExpiry,
        "id": id,
        "mobileNo": mobileNo,
        "otpActionType": otpActionType,
        "domainId": domainId,
        "emailVerificationCode": emailVerificationCode,
      };
}
