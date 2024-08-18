class ResendWithdrawalOtpResponse {
  int? errorCode;
  String? respMsg;
  Data? data;

  ResendWithdrawalOtpResponse({this.errorCode, this.respMsg, this.data});

  ResendWithdrawalOtpResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['errorCode'];
    respMsg = json['respMsg'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorCode'] = this.errorCode;
    data['respMsg'] = this.respMsg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? status;

  Data({this.status});

  Data.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}
