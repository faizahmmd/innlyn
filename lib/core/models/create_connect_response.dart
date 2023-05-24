// To parse this JSON data, do
//
//     final createConnectResponse = createConnectResponseFromJson(jsonString);

import 'dart:convert';

CreateConnectResponse createConnectResponseFromJson(String str) => CreateConnectResponse.fromJson(json.decode(str));

String createConnectResponseToJson(CreateConnectResponse data) => json.encode(data.toJson());

class CreateConnectResponse {
  bool? success;
  String? message;
  Data? data;

  CreateConnectResponse({
    this.success,
    this.message,
    this.data,
  });

  factory CreateConnectResponse.fromJson(Map<String, dynamic> json) => CreateConnectResponse(
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
  String? userId;
  String? description;
  List<double>? pickup;
  List<double>? drop;
  String? status;
  int? riderCount;
  List<dynamic>? coRiders;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Data({
    this.userId,
    this.description,
    this.pickup,
    this.drop,
    this.status,
    this.riderCount,
    this.coRiders,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["userId"],
    description: json["description"],
    pickup: json["pickup"] == null ? [] : List<double>.from(json["pickup"]!.map((x) => x?.toDouble())),
    drop: json["drop"] == null ? [] : List<double>.from(json["drop"]!.map((x) => x?.toDouble())),
    status: json["status"],
    riderCount: json["riderCount"],
    coRiders: json["coRiders"] == null ? [] : List<dynamic>.from(json["coRiders"]!.map((x) => x)),
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "description": description,
    "pickup": pickup == null ? [] : List<dynamic>.from(pickup!.map((x) => x)),
    "drop": drop == null ? [] : List<dynamic>.from(drop!.map((x) => x)),
    "status": status,
    "riderCount": riderCount,
    "coRiders": coRiders == null ? [] : List<dynamic>.from(coRiders!.map((x) => x)),
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}
