// To parse this JSON data, do
//
//     final changePasswordResponseModel = changePasswordResponseModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordResponseModel changePasswordResponseModelFromJson(String str) =>
    ChangePasswordResponseModel.fromJson(json.decode(str));

String changePasswordResponseModelToJson(ChangePasswordResponseModel data) =>
    json.encode(data.toJson());

class ChangePasswordResponseModel {
  ChangePasswordResponseModel({
    this.errorCode,
    this.respMsg,
    this.errorMessage,
    this.verificationCode,
  });

  int? errorCode;
  String? respMsg;
  String? errorMessage;
  String? verificationCode;

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ChangePasswordResponseModel(
        errorCode: json["errorCode"],
        respMsg: json["respMsg"],
        errorMessage: json["errorMessage"],
        verificationCode: json["verificationCode"],
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "respMsg": respMsg,
        "errorMessage": errorMessage,
        "verificationCode": verificationCode,
      };
}
