class WithdrawalInitiatePaymentOptionData {
  int? paymentTypeId;
  int? subTypeId;
  int? providerId;
  String? displayName;
  double? minValue;
  double? maxValue;

  WithdrawalInitiatePaymentOptionData(
      {this.paymentTypeId, this.subTypeId, this.providerId, this.displayName, this.minValue, this.maxValue});

  WithdrawalInitiatePaymentOptionData.fromJson(Map<String, dynamic> json) {
    paymentTypeId = json['paymentTypeId'];
    subTypeId = json['subTypeId'];
    providerId = json['providerId'];
    displayName = json['displayName'];
    minValue = json['minValue'];
    maxValue = json['maxValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paymentTypeId'] = this.paymentTypeId;
    data['subTypeId'] = this.subTypeId;
    data['providerId'] = this.providerId;
    data['displayName'] = this.displayName;
    data['minValue'] = this.minValue;
    data['maxValue'] = this.maxValue;
    return data;
  }
}
