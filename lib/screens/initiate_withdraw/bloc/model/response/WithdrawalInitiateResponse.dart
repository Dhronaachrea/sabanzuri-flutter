class WithdrawalInitiateResponse {
  int? errorCode;
  String? respMsg;
  String? txnId;
  String? txnDate;
  String? regTxnNo;
  int? userTxnId;
  String? verificationCode;
  String? isOtpEnabled;

  WithdrawalInitiateResponse(
      {this.errorCode,
        this.respMsg,
        this.txnId,
        this.txnDate,
        this.regTxnNo,
        this.userTxnId,
        this.verificationCode,
        this.isOtpEnabled});

  WithdrawalInitiateResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    respMsg = json['respMsg'];
    txnId = json['txnId'];
    txnDate = json['txnDate'];
    regTxnNo = json['regTxnNo'];
    userTxnId = json['userTxnId'];
    verificationCode = json['verificationCode'];
    isOtpEnabled = json['isOtpEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['respMsg'] = this.respMsg;
    data['txnId'] = this.txnId;
    data['txnDate'] = this.txnDate;
    data['regTxnNo'] = this.regTxnNo;
    data['userTxnId'] = this.userTxnId;
    data['verificationCode'] = this.verificationCode;
    data['isOtpEnabled'] = this.isOtpEnabled;
    return data;
  }
}
