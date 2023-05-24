// To parse this JSON data, do
//
//     final searchConnectResponse = searchConnectResponseFromJson(jsonString);

import 'dart:convert';

SearchConnectResponse searchConnectResponseFromJson(String str) => SearchConnectResponse.fromJson(json.decode(str));

class SearchConnectResponse {
  bool? success;
  String? message;
  List<Datum>? data;

  SearchConnectResponse({
    this.success,
    this.message,
    this.data,
  });

  factory SearchConnectResponse.fromJson(Map<String, dynamic> json) => SearchConnectResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );
}

class Datum {
  String? id;
  String? userId;
  String? description;
  List<double>? pickup;
  List<double>? drop;
  String? status;
  int? riderCount;
  List<dynamic>? coRiders;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  double? distance;

  Datum({
    this.id,
    this.userId,
    this.description,
    this.pickup,
    this.drop,
    this.status,
    this.riderCount,
    this.coRiders,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.distance,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    userId: json["userId"],
    description: json["description"],
    pickup: json["pickup"] == null ? [] : List<double>.from(json["pickup"]!.map((x) => x?.toDouble())),
    drop: json["drop"] == null ? [] : List<double>.from(json["drop"]!.map((x) => x?.toDouble())),
    status: json["status"],
    riderCount: json["riderCount"],
    coRiders: json["coRiders"] == null ? [] : List<dynamic>.from(json["coRiders"]!.map((x) => x)),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    distance: json["distance"]?.toDouble(),
  );
}
