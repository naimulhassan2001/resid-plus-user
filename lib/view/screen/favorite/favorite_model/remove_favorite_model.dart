import 'dart:convert';

class FavoriteRemoveModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  FavoriteRemoveModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory FavoriteRemoveModel.fromRawJson(String str) => FavoriteRemoveModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FavoriteRemoveModel.fromJson(Map<String, dynamic> json) => FavoriteRemoveModel(
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
  Attributes? attributes;

  Data({
    this.type,
    this.attributes,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "attributes": attributes?.toJson(),
  };
}

class Attributes {
  String? id;
  String? userId;
  String? residenceId;
  int? v;

  Attributes({
    this.id,
    this.userId,
    this.residenceId,
    this.v,
  });

  factory Attributes.fromRawJson(String str) => Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    id: json["_id"],
    userId: json["userId"],
    residenceId: json["residenceId"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "residenceId": residenceId,
    "__v": v,
  };
}
