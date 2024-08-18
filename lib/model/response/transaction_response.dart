// To parse this JSON data, do
//
//     final transactionResponseModel = transactionResponseModelFromJson(jsonString);

import 'dart:convert';

TransactionResponseModel transactionResponseModelFromJson(String str) =>
    TransactionResponseModel.fromJson(json.decode(str));

String transactionResponseModelToJson(TransactionResponseModel data) =>
    json.encode(data.toJson());

class TransactionResponseModel {
  TransactionResponseModel({
    this.errorCode,
    this.respMsg,
    this.txnList,
  });

  int? errorCode;
  String? respMsg;
  List<TxnList>? txnList;

  factory TransactionResponseModel.fromJson(Map<String, dynamic> json) =>
      TransactionResponseModel(
        errorCode: json["errorCode"],
        respMsg: json["respMsg"],
        txnList: json["txnList"] != null
            ? List<TxnList>.from(
                json["txnList"].map((x) => TxnList.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "respMsg": respMsg,
        "txnList": txnList != null
            ? List<TxnList>.from(txnList!.map((x) => x.toJson()))
            : null,
      };
}

class TxnList {
  TxnList({
    this.transactionId,
    this.transactionDate,
    this.particular,
    this.txnType,
    this.currencyId,
    this.debitAmount,
    this.txnAmount,
    this.balance,
    this.openingBalance,
    this.subwalletTxn,
    this.currency,
    this.withdrawableBalance,
    this.creditAmount,
    this.gameGroup,
  });

  int? transactionId;
  DateTime? transactionDate;
  String? particular;
  String? txnType;
  int? currencyId;
  double? debitAmount;
  double? txnAmount;
  double? balance;
  double? openingBalance;
  String? subwalletTxn;
  String? currency;
  double? withdrawableBalance;
  double? creditAmount;
  String? gameGroup;

  factory TxnList.fromJson(Map<String, dynamic> json) => TxnList(
        transactionId: json["transactionId"],
        transactionDate: DateTime.parse(json["transactionDate"]),
        particular: json["particular"],
        txnType: json["txnType"],
        currencyId: json["currencyId"],
        debitAmount:
            json["debitAmount"] == null ? null : json["debitAmount"].toDouble(),
        txnAmount: json["txnAmount"].toDouble(),
        balance: json["balance"] != null ? json["balance"].toDouble() : 0.0,
        openingBalance: json["openingBalance"],
        subwalletTxn: json["subwalletTxn"],
        currency: json["currency"],
        withdrawableBalance: json["withdrawableBalance"] == null
            ? null
            : json["withdrawableBalance"].toDouble(),
        creditAmount:
            json["creditAmount"] == null ? null : json["creditAmount"],
        gameGroup: json["gameGroup"] == null ? null : json["gameGroup"],
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "transactionDate": transactionDate?.toIso8601String(),
        "particular": particular,
        "txnType": txnType,
        "currencyId": currencyId,
        "debitAmount": debitAmount,
        "txnAmount": txnAmount,
        "balance": balance,
        "openingBalance": openingBalance,
        "subwalletTxn": subwalletTxn,
        "currency": currency,
        "withdrawableBalance": withdrawableBalance,
        "creditAmount": creditAmount,
        "gameGroup": gameGroup,
      };
}
