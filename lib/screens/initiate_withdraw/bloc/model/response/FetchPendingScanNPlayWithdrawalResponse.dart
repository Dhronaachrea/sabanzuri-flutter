class FetchPendingScanNPlayWithdrawalResponse {
  int? errorCode;
  String? errorMsg;
  List<Data>? data;

  FetchPendingScanNPlayWithdrawalResponse(
      {this.errorCode, this.errorMsg, this.data});

  FetchPendingScanNPlayWithdrawalResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? createdAt;
  String? amount;
  String? requestId;
  String? userTxnId;
  String? otp;
  String? playerId;
  bool? isOtpVisible = false;

  Data({this.createdAt, this.amount, this.requestId, this.userTxnId, this.otp, this.playerId, this.isOtpVisible = false});

  Data.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    amount = json['amount'];
    requestId = json['requestId'];
    userTxnId = json['userTxnId'];
    otp = json['otp'];
    playerId = json['playerId'];
    isOtpVisible = json['isOtpVisible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['amount'] = this.amount;
    data['requestId'] = this.requestId;
    data['userTxnId'] = this.userTxnId;
    data['otp'] = this.otp;
    data['playerId'] = this.playerId;
    data['isOtpVisible'] = this.isOtpVisible;
    return data;
  }
}
