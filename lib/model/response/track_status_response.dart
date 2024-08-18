// To parse this JSON data, do
//
//     final trackStatusResponseModel = trackStatusResponseModelFromJson(jsonString);

import 'dart:convert';

TrackStatusResponseModel trackStatusResponseModelFromJson(String str) =>
    TrackStatusResponseModel.fromJson(json.decode(str));

String trackStatusResponseModelToJson(TrackStatusResponseModel data) =>
    json.encode(data.toJson());

class TrackStatusResponseModel {
  TrackStatusResponseModel({
    this.errorCode,
    this.plrTrackBonusList,
  });

  int? errorCode;
  List<PlrTrackBonusList>? plrTrackBonusList;

  factory TrackStatusResponseModel.fromJson(Map<String, dynamic> json) =>
      TrackStatusResponseModel(
        errorCode: json["errorCode"] == null ? null : json["errorCode"],
        plrTrackBonusList: json["plrTrackBonusList"] == null
            ? null
            : List<PlrTrackBonusList>.from(json["plrTrackBonusList"]
                .map((x) => PlrTrackBonusList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode == null ? null : errorCode,
        "plrTrackBonusList": plrTrackBonusList == null
            ? null
            : List<dynamic>.from(plrTrackBonusList!.map((x) => x.toJson())),
      };
}

class PlrTrackBonusList {
  PlrTrackBonusList({
    this.userName,
    this.emailId,
    this.referralDate,
    this.mobileNum,
    this.register,
    this.depositor,
  });

  String? userName;
  String? emailId;
  String? referralDate;
  String? mobileNum;
  bool? register;
  bool? depositor;

  factory PlrTrackBonusList.fromJson(Map<String, dynamic> json) =>
      PlrTrackBonusList(
        userName: json["userName"] == null ? null : json["userName"],
        emailId: json["emailId"] == null ? null : json["emailId"],
        referralDate:
            json["referralDate"] == null ? null : json["referralDate"],
        mobileNum: json["mobileNum"],
        register: json["register"] == null ? null : json["register"],
        depositor: json["depositor"] == null ? null : json["depositor"],
      );

  Map<String, dynamic> toJson() => {
        "userName": userName == null ? null : userName,
        "emailId": emailId == null ? null : emailId,
        "referralDate": referralDate == null ? null : referralDate,
        "mobileNum": mobileNum,
        "register": register == null ? null : register,
        "depositor": depositor == null ? null : depositor,
      };
}
