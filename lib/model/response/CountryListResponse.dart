class CountryListResponse {
  String? errorMessage;
  int? errorCode;
  List<Data>? data;

  CountryListResponse({errorMessage, errorCode, data});

  CountryListResponse.fromJson(Map<String, dynamic> json) {
    errorMessage = json['errorMessage'];
    errorCode = json['errorCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['errorMessage'] = errorMessage;
    data['errorCode'] = errorCode;
    if (data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  bool? isDefault;
  Null? flag;
  String? countryCode;
  String? countryName;
  String? isdCode;

  Data(
      {isDefault,
        flag,
        countryCode,
        countryName,
        isdCode});

  Data.fromJson(Map<String, dynamic> json) {
    isDefault = json['isDefault'];
    flag = json['flag'];
    countryCode = json['countryCode'];
    countryName = json['countryName'];
    isdCode = json['isdCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    data['isDefault'] = isDefault;
    data['flag'] = flag;
    data['countryCode'] = countryCode;
    data['countryName'] = countryName;
    data['isdCode'] = isdCode;
    return data;
  }
}