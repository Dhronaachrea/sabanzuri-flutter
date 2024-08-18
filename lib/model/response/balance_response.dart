// To parse this JSON data, do
//
//     final balanceResponse = balanceResponseFromJson(jsonString);

import 'dart:convert';

BalanceResponse balanceResponseFromJson(String str) =>
    BalanceResponse.fromJson(json.decode(str));

String balanceResponseToJson(BalanceResponse data) =>
    json.encode(data.toJson());

class BalanceResponse {
  BalanceResponse({
    this.errorCode,
    this.wallet,
  });

  int? errorCode;
  Wallet? wallet;

  factory BalanceResponse.fromJson(Map<String, dynamic> json) =>
      BalanceResponse(
        errorCode: json["errorCode"],
        wallet: Wallet.fromJson(json["wallet"]),
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "wallet": wallet?.toJson(),
      };
}

class Wallet {
  Wallet({
    this.totalBalance,
    this.cashBalance,
    this.depositBalance,
    this.winningBalance,
    this.bonusBalance,
    this.withdrawableBal,
    this.practiceBalance,
    this.currency,
    this.currencyDisplayCode,
    this.totalDepositBalance,
    this.totalWithdrawableBalance,
    this.totalWinningBalance,
  });

  double? totalBalance;
  double? cashBalance;
  double? depositBalance;
  double? winningBalance;
  double? bonusBalance;
  double? withdrawableBal;
  double? practiceBalance;
  String? currency;
  String? currencyDisplayCode;
  double? totalDepositBalance;
  double? totalWithdrawableBalance;
  double? totalWinningBalance;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        totalBalance: json["totalBalance"],
        cashBalance: json["cashBalance"],
        depositBalance: json["depositBalance"],
        winningBalance: json["winningBalance"],
        bonusBalance: json["bonusBalance"],
        withdrawableBal: json["withdrawableBal"],
        practiceBalance: json["practiceBalance"],
        currency: json["currency"],
        currencyDisplayCode: json["currencyDisplayCode"],
        totalDepositBalance: json["totalDepositBalance"],
        totalWithdrawableBalance: json["totalWithdrawableBalance"].toDouble(),
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
        "currency": currency,
        "currencyDisplayCode": currencyDisplayCode,
        "totalDepositBalance": totalDepositBalance,
        "totalWithdrawableBalance": totalWithdrawableBalance,
        "totalWinningBalance": totalWinningBalance,
      };
}
