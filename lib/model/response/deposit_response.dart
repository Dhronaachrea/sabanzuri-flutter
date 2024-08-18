import 'dart:convert';

DepositResponse depositResponseFromJson(String str) =>
    DepositResponse.fromJson(json.decode(str));

String depositResponseToJson(DepositResponse data) =>
    json.encode(data.toJson());

//{
//  "txnId": "4307",
//  "netAmount": 50.0,
//  "status": "SUCCESS",
//  "txnType": "DEPOSIT",
//  "responseUrl": "MOBILE_APP",
//  "firstDeposit": false,
//  "domainName": "www.winboom.ae",
//  "userName": "97166666666",
//  "errorCode": 0,
//  "respMsg": "Deposit Request Successfully Done...",
//  "merchantTxnId": 21321 -> Long Type
//}
class DepositResponse {
  DepositResponse({
    this.txnId,
    this.netAmount,
    this.status,
    this.txnType,
    this.responseUrl,
    this.firstDeposit,
    this.domainName,
    this.userName,
    this.errorCode,
    this.errorMsg,
    this.respMsg,
    this.merchantTxnId,
    this.txnDate,
  });

  String? txnId;
  dynamic netAmount;
  String? status;
  String? txnType;
  String? responseUrl;
  bool? firstDeposit;
  String? domainName;
  String? userName;
  dynamic errorCode;
  String? errorMsg;
  String? respMsg;
  dynamic merchantTxnId;
  String? txnDate;

  factory DepositResponse.fromJson(Map<String, dynamic> json) =>
      DepositResponse(
        txnId: json["txnId"],
        netAmount: json["netAmount"],
        status: json["status"],
        txnType: json["txnType"],
        responseUrl: json["responseUrl"],
        firstDeposit: json["firstDeposit"],
        domainName: json["domainName"],
        userName: json["userName"],
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
        respMsg: json["respMsg"],
        merchantTxnId: json["merchantTxnId"],
        txnDate: json["txnDate"],
      );

  Map<String, dynamic> toJson() => {
        "txnId": txnId,
        "netAmount": netAmount,
        "status": status,
        "txnType": txnType,
        "responseUrl": responseUrl,
        "firstDeposit": firstDeposit,
        "domainName": domainName,
        "userName": userName,
        "errorCode": errorCode,
        "errorMsg": errorMsg,
        "respMsg": respMsg,
        "merchantTxnId": merchantTxnId,
        "txnDate": txnDate,
      };
}
