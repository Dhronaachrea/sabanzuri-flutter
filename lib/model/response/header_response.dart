import 'dart:convert';

HeaderResponse headerResponseFromJson(String str) =>
    HeaderResponse.fromJson(json.decode(str));

String headerResponseToJson(HeaderResponse data) => json.encode(data.toJson());

class HeaderResponse {
  HeaderResponse({
    this.errorCode,
    this.unreadMsgCount,
    this.cashbal,
    this.practiceBal,
    this.withdrawableBal,
    this.data,
    this.totalWinning,
    this.totalWithdrawal,
    this.totalDeposit,
    this.currencyDisplayCode,
    this.profileStatus,
    this.totalBonus,
    this.totalWgr,
  });

  int? errorCode;
  int? unreadMsgCount;
  double? cashbal;
  double? practiceBal;
  double? withdrawableBal;
  Data? data;
  double? totalWinning;
  double? totalWithdrawal;
  double? totalDeposit;
  String? currencyDisplayCode;
  String? profileStatus;
  double? totalBonus;
  double? totalWgr;

  factory HeaderResponse.fromJson(Map<String, dynamic> json) => HeaderResponse(
        errorCode: json["errorCode"],
        unreadMsgCount: json["unreadMsgCount"],
        cashbal: json["cashbal"],
        practiceBal: json["practiceBal"],
        withdrawableBal: json["withdrawableBal"],
        data: Data.fromJson(json["data"]),
        totalWinning: json["totalWinning"],
        totalWithdrawal: json["totalWithdrawal"],
        totalDeposit: json["totalDeposit"],
        currencyDisplayCode: json["currencyDisplayCode"],
        profileStatus: json["profileStatus"],
        totalBonus: json["totalBonus"],
        totalWgr: json["totalWgr"],
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "unreadMsgCount": unreadMsgCount,
        "cashbal": cashbal,
        "practiceBal": practiceBal,
        "withdrawableBal": withdrawableBal,
        "data": data?.toJson(),
        "totalWinning": totalWinning,
        "totalWithdrawal": totalWithdrawal,
        "totalDeposit": totalDeposit,
        "currencyDisplayCode": currencyDisplayCode,
        "profileStatus": profileStatus,
        "totalBonus": totalBonus,
        "totalWgr": totalWgr,
      };
}

class Data {
  Data({
    this.bonusBarInfo,
  });

  String? bonusBarInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bonusBarInfo: json["bonusBarInfo"],
      );

  Map<String, dynamic> toJson() => {
        "bonusBarInfo": bonusBarInfo,
      };
}
