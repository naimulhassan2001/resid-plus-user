// To parse this JSON data, do
//
//     final reviewModel = reviewModelFromJson(jsonString);

import 'dart:convert';

ReviewModel reviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  ReviewModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  String? type;
  List<Attribute>? attributes;

  Data({
    this.type,
    this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    attributes: json["attributes"] == null ? [] : List<Attribute>.from(json["attributes"]!.map((x) => Attribute.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x.toJson())),
  };
}

class Attribute {
  String? id;
  UserId? userId;
  String? residenceId;
  int? rating;
  String? createdAt;
  String? updatedAt;
  int? v;

  Attribute({
    this.id,
    this.userId,
    this.residenceId,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["_id"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    residenceId: json["residenceId"],
    rating: json["rating"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId?.toJson(),
    "residenceId": residenceId,
    "rating": rating,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}

class UserId {
  String? id;
  String? fullName;

  UserId({
    this.id,
    this.fullName,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    fullName: json["fullName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
  };
}
