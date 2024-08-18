class DepositModel {
  String amount;
  String currencyCode;
  String paymentAccId;
  String paymentTypeCode;
  String paymentTypeId;

  String subTypeId;

  DepositModel({
    required this.amount,
    required this.currencyCode,
    required this.paymentAccId,
    required this.paymentTypeCode,
    required this.paymentTypeId,
    required this.subTypeId,
  });
}
