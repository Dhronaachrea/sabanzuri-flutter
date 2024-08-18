import 'dart:convert';

TicketResponse ticketResponseFromJson(String str) =>
    TicketResponse.fromJson(json.decode(str));

String ticketResponseToJson(TicketResponse data) => json.encode(data.toJson());

class TicketResponse {
  TicketResponse({
    this.errorCode,
    this.ticketList,
  });

  int? errorCode;
  List<TicketList>? ticketList;

  factory TicketResponse.fromJson(Map<String, dynamic> json) => TicketResponse(
        errorCode: json["errorCode"],
        ticketList: List<TicketList>.from(
            json["ticketList"].map((x) => TicketList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "ticketList": ticketList != null
            ? List<TicketList>.from(ticketList!.map((x) => x.toJson()))
            : null,
      };
}

class TicketList {
  TicketList({
    this.transactionDate,
    this.transactionId,
    this.refTxnNo,
    this.amount,
    this.gameId,
    this.gameType,
    this.gameName,
    this.status,
    this.serviceCode,
    this.walletProvider,
  });

  DateTime? transactionDate;
  String? transactionId;
  String? refTxnNo;
  String? amount;
  String? gameId;
  String? gameType;
  String? gameName;
  String? status;
  String? serviceCode;
  String? walletProvider;

  factory TicketList.fromJson(Map<String, dynamic> json) => TicketList(
        transactionDate: DateTime.parse(json["transactionDate"]),
        transactionId: json["transactionId"],
        refTxnNo: json["refTxnNo"],
        amount: json["amount"],
        gameId: json["gameId"],
        gameType: json["gameType"],
        gameName: json["gameName"],
        status: json["status"],
        serviceCode: json["serviceCode"],
        walletProvider: json["walletProvider"],
      );

  Map<String, dynamic> toJson() => {
        "transactionDate": transactionDate?.toIso8601String(),
        "transactionId": transactionId,
        "refTxnNo": refTxnNo,
        "amount": amount,
        "gameId": gameId,
        "gameType": gameType,
        "gameName": gameName,
        "status": status,
        "serviceCode": serviceCode,
        "walletProvider": walletProvider,
      };
}
