// To parse this JSON data, do
//
//     final mobileSignInResponse = mobileSignInResponseFromJson(jsonString);

import 'dart:convert';

MobileSignInResponse mobileSignInResponseFromJson(String str) => MobileSignInResponse.fromJson(json.decode(str));

String mobileSignInResponseToJson(MobileSignInResponse data) => json.encode(data.toJson());

class MobileSignInResponse {
  bool? success;
  String? message;
  Data? data;

  MobileSignInResponse({
    this.success,
    this.message,
    this.data,
  });

  factory MobileSignInResponse.fromJson(Map<String, dynamic> json) => MobileSignInResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? accessToken;
  String? refreshToken;

  Data({
    this.accessToken,
    this.refreshToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
