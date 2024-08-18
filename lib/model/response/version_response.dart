import 'dart:convert';

VersionResponse versionResponseFromJson(String str) =>
    VersionResponse.fromJson(json.decode(str));

String versionResponseToJson(VersionResponse data) =>
    json.encode(data.toJson());

class VersionResponse {
  VersionResponse({
    this.errorCode,
    this.respMsg,
    this.appDetails,
    this.gameEngineInfo,
    this.isplayerLogin,
    this.staticLogoDisplay,
  });

  int? errorCode;
  String? respMsg;
  AppDetails? appDetails;
  GameEngineInfo? gameEngineInfo;
  bool? isplayerLogin;
  bool? staticLogoDisplay;

  factory VersionResponse.fromJson(Map<String, dynamic> json) =>
      VersionResponse(
        errorCode: json["errorCode"],
        respMsg: json["respMsg"],
        appDetails: json["appDetails"] != null
            ? AppDetails.fromJson(json["appDetails"])
            : null,
        gameEngineInfo: json["gameEngineInfo"] != null
            ? GameEngineInfo.fromJson(json["gameEngineInfo"])
            : null,
        isplayerLogin: json["isplayerLogin"],
        staticLogoDisplay: json["staticLogoDisplay"],
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "respMsg": respMsg,
        "appDetails": appDetails?.toJson(),
        "gameEngineInfo": gameEngineInfo?.toJson(),
        "isplayerLogin": isplayerLogin,
        "staticLogoDisplay": staticLogoDisplay,
      };
}

class AppDetails {
  AppDetails({
    this.os,
    this.appType,
    this.version,
    this.versionCode,
    this.versionDate,
    this.url,
    this.mandatory,
    this.message,
    this.versionType,
    this.isUpdateAvailable,
  });

  String? os;
  String? appType;
  String? version;
  String? versionCode;
  DateTime? versionDate;
  String? url;
  bool? mandatory;
  String? message;
  String? versionType;
  bool? isUpdateAvailable;

  factory AppDetails.fromJson(Map<String, dynamic> json) => AppDetails(
        os: json["os"],
        appType: json["appType"],
        version: json["version"],
        versionCode: json["versionCode"],
        versionDate: DateTime.parse(
            json["versionDate"] ?? DateTime.now().toIso8601String()),
        url: json["url"],
        mandatory: json["mandatory"],
        message: json["message"],
        versionType: json["version_type"],
        isUpdateAvailable: json["isUpdateAvailable"],
      );

  Map<String, dynamic> toJson() => {
        "os": os,
        "appType": appType,
        "version": version,
        "versionCode": versionCode,
        "versionDate": versionDate?.toIso8601String(),
        "url": url,
        "mandatory": mandatory,
        "message": message,
        "version_type": versionType,
        "isUpdateAvailable": isUpdateAvailable,
      };
}

class GameEngineInfo {
  GameEngineInfo({
    this.dge,
    this.ige,
  });

  Dge? dge;
  Dge? ige;

  factory GameEngineInfo.fromJson(Map<String, dynamic> json) => GameEngineInfo(
        dge: Dge.fromJson(json["DGE"]),
        ige: Dge.fromJson(json["IGE"]),
      );

  Map<String, dynamic> toJson() => {
        "DGE": dge?.toJson(),
        "IGE": ige?.toJson(),
      };
}

class Dge {
  Dge({
    this.serverUrl,
  });

  String? serverUrl;

  factory Dge.fromJson(Map<String, dynamic> json) => Dge(
        serverUrl: json["serverUrl"],
      );

  Map<String, dynamic> toJson() => {
        "serverUrl": serverUrl,
      };
}
