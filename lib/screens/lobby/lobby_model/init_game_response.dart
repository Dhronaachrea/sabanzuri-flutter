// To parse this JSON data, do
//
//     final initGameResponse = initGameResponseFromJson(jsonString);

import 'dart:convert';

InitGameResponse initGameResponseFromJson(String str) => InitGameResponse.fromJson(json.decode(str));

String initGameResponseToJson(InitGameResponse data) => json.encode(data.toJson());

class InitGameResponse {
  InitGameResponse({
    this.success,
    this.data,
  });

  bool? success;
  Data? data;

  factory InitGameResponse.fromJson(Map<String, dynamic> json) => InitGameResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.userData,
  });

  bool? userData;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userData: json["userData"],
  );

  Map<String, dynamic> toJson() => {
    "userData": userData,
  };
}
