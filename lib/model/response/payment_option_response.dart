// To parse this JSON data, do
//
//     final paymentOptionResponse = paymentOptionResponseFromJson(jsonString);

import 'dart:convert';

PaymentOptionResponse paymentOptionResponseFromJson(String str) =>
    PaymentOptionResponse.fromJson(json.decode(str));

String paymentOptionResponseToJson(PaymentOptionResponse data) =>
    json.encode(data.toJson());

class PaymentOptionResponse {
  PaymentOptionResponse({
    this.errorCode,
    this.errorMsg,
    this.payTypeMap,
    this.paymentAccounts,
  });

  int? errorCode;
  String? errorMsg;
  PayTypeMap? payTypeMap;
  PaymentAccounts? paymentAccounts;

  factory PaymentOptionResponse.fromJson(Map<String, dynamic> json) =>
      PaymentOptionResponse(
        errorCode: json["errorCode"],
        errorMsg: json["errorMsg"],
        payTypeMap: json["payTypeMap"] != null
            ? PayTypeMap.fromJson(json["payTypeMap"])
            : null,
        paymentAccounts: json["paymentAccounts"] != null
            ? PaymentAccounts.fromJson(json["paymentAccounts"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "errorMsg": errorMsg,
        "payTypeMap": payTypeMap?.toJson(),
        "paymentAccounts": paymentAccounts?.toJson(),
      };
}

class PayTypeMap {
  PayTypeMap({
    this.the14,
  });

  The14? the14;

  factory PayTypeMap.fromJson(Map<String, dynamic> json) => PayTypeMap(
        the14: The14.fromJson(json["14"]),
      );

  Map<String, dynamic> toJson() => {
        "14": the14?.toJson(),
      };
}

class The14 {
  The14({
    this.payTypeId,
    this.payTypeCode,
    this.payTypeDispCode,
    this.subTypeMap,
    this.payAccReqMap,
    this.payAccKycType,
    this.subTypeMapPortal,
    this.providerMap,
    this.currencyMap,
    this.uiOrder,
    this.minValue,
    this.maxValue,
  });

  int? payTypeId;
  String? payTypeCode;
  String? payTypeDispCode;
  PayAccKycType? subTypeMap;
  PayAccKycType? payAccReqMap;
  PayAccKycType? payAccKycType;
  SubTypeMapPortal? subTypeMapPortal;
  ProviderMap? providerMap;
  CurrencyMap? currencyMap;
  int? uiOrder;
  double? minValue;
  double? maxValue;

  factory The14.fromJson(Map<String, dynamic> json) => The14(
        payTypeId: json["payTypeId"],
        payTypeCode: json["payTypeCode"],
        payTypeDispCode: json["payTypeDispCode"],
        subTypeMap: PayAccKycType.fromJson(json["subTypeMap"]),
        payAccReqMap: PayAccKycType.fromJson(json["payAccReqMap"]),
        payAccKycType: PayAccKycType.fromJson(json["payAccKycType"]),
        subTypeMapPortal: SubTypeMapPortal.fromJson(json["subTypeMapPortal"]),
        providerMap: ProviderMap.fromJson(json["providerMap"]),
        currencyMap: CurrencyMap.fromJson(json["currencyMap"]),
        uiOrder: json["uiOrder"],
        minValue: json["minValue"],
        maxValue: json["maxValue"],
      );

  Map<String, dynamic> toJson() => {
        "payTypeId": payTypeId,
        "payTypeCode": payTypeCode,
        "payTypeDispCode": payTypeDispCode,
        "subTypeMap": subTypeMap?.toJson(),
        "payAccReqMap": payAccReqMap?.toJson(),
        "payAccKycType": payAccKycType?.toJson(),
        "subTypeMapPortal": subTypeMapPortal?.toJson(),
        "providerMap": providerMap?.toJson(),
        "currencyMap": currencyMap?.toJson(),
        "uiOrder": uiOrder,
        "minValue": minValue,
        "maxValue": maxValue,
      };
}

class CurrencyMap {
  CurrencyMap({
    this.the15,
  });

  String? the15;

  factory CurrencyMap.fromJson(Map<String, dynamic> json) => CurrencyMap(
        the15: json["15"],
      );

  Map<String, dynamic> toJson() => {
        "15": the15,
      };
}

class PayAccKycType {
  PayAccKycType({
    this.the88,
  });

  String? the88;

  factory PayAccKycType.fromJson(Map<String, dynamic> json) => PayAccKycType(
        the88: json["88"],
      );

  Map<String, dynamic> toJson() => {
        "88": the88,
      };
}

class ProviderMap {
  ProviderMap({
    this.the16,
  });

  String? the16;

  factory ProviderMap.fromJson(Map<String, dynamic> json) => ProviderMap(
        the16: json["16"],
      );

  Map<String, dynamic> toJson() => {
        "16": the16,
      };
}

class SubTypeMapPortal {
  SubTypeMapPortal();

  factory SubTypeMapPortal.fromJson(Map<String, dynamic> json) =>
      SubTypeMapPortal();

  Map<String, dynamic> toJson() => {};
}

class PaymentAccounts {
  PaymentAccounts({
    this.the2756,
  });

  The2756? the2756;

  factory PaymentAccounts.fromJson(Map<String, dynamic> json) =>
      PaymentAccounts(
        the2756: json["2756"] != null ? The2756.fromJson(json["2756"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "2756": the2756?.toJson(),
      };
}

class The2756 {
  The2756({
    this.paymentAccId,
    this.paymentTypeId,
    this.paymentType,
    this.merchantId,
    this.domainId,
    this.subTypeId,
    this.userId,
    this.accHolderName,
    this.accNum,
    this.accType,
    this.status,
    this.verifiedByUser,
    this.verificationStatus,
    this.currencyId,
    this.createdAt,
    this.updatedAt,
  });

  int? paymentAccId;
  int? paymentTypeId;
  String? paymentType;
  int? merchantId;
  int? domainId;
  int? subTypeId;
  int? userId;
  String? accHolderName;
  String? accNum;
  String? accType;
  String? status;
  int? verifiedByUser;
  String? verificationStatus;
  int? currencyId;
  int? createdAt;
  int? updatedAt;

  factory The2756.fromJson(Map<String, dynamic> json) => The2756(
        paymentAccId: json["paymentAccId"],
        paymentTypeId: json["paymentTypeId"],
        paymentType: json["paymentType"],
        merchantId: json["merchantId"],
        domainId: json["domainId"],
        subTypeId: json["subTypeId"],
        userId: json["userId"],
        accHolderName: json["accHolderName"],
        accNum: json["accNum"],
        accType: json["accType"],
        status: json["status"],
        verifiedByUser: json["verifiedByUser"],
        verificationStatus: json["verificationStatus"],
        currencyId: json["currencyId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "paymentAccId": paymentAccId,
        "paymentTypeId": paymentTypeId,
        "paymentType": paymentType,
        "merchantId": merchantId,
        "domainId": domainId,
        "subTypeId": subTypeId,
        "userId": userId,
        "accHolderName": accHolderName,
        "accNum": accNum,
        "accType": accType,
        "status": status,
        "verifiedByUser": verifiedByUser,
        "verificationStatus": verificationStatus,
        "currencyId": currencyId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
