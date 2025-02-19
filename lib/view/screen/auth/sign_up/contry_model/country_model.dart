// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

CountryModel countryModelFromJson(String str) =>
    CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  CountryModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
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
        attributes: json["attributes"] == null
            ? []
            : List<Attribute>.from(
                json["attributes"]!.map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
      };
}

class Attribute {
  String? id;
  String? countryName;
  String? countryCode;
  CountryFlag? countryFlag;

  Attribute({
    this.id,
    this.countryName,
    this.countryCode,
    this.countryFlag,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["_id"],
        countryName: json["countryName"],
        countryCode: json["countryCode"],
        countryFlag: json["countryFlag"] == null
            ? null
            : CountryFlag.fromJson(json["countryFlag"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "countryName": countryName,
        "countryCode": countryCode,
        "countryFlag": countryFlag?.toJson(),
      };
}

class CountryFlag {
  String? publicFileUrl;
  String? path;

  CountryFlag({
    this.publicFileUrl,
    this.path,
  });

  factory CountryFlag.fromJson(Map<String, dynamic> json) => CountryFlag(
        publicFileUrl: json["publicFileUrl"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "publicFileUrl": publicFileUrl,
        "path": path,
      };
}
