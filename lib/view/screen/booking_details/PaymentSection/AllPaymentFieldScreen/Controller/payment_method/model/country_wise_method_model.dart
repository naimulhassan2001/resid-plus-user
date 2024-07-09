// To parse this JSON data, do
//
//     final countryWiseMethodModel = countryWiseMethodModelFromJson(jsonString);

import 'dart:convert';

CountryWiseMethodModel countryWiseMethodModelFromJson(String str) => CountryWiseMethodModel.fromJson(json.decode(str));

String countryWiseMethodModelToJson(CountryWiseMethodModel data) => json.encode(data.toJson());

class CountryWiseMethodModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  CountryWiseMethodModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory CountryWiseMethodModel.fromJson(Map<String, dynamic> json) => CountryWiseMethodModel(
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
  Attributes? attributes;

  Data({
    this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes?.toJson(),
  };
}

class Attributes {
  String? id;
  Country? country;
  List<PaymentGateway>? paymentGateways;
  int? v;
  DateTime? createdAt;
  DateTime? updatedAt;

  Attributes({
    this.id,
    this.country,
    this.paymentGateways,
    this.v,
    this.createdAt,
    this.updatedAt,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    id: json["_id"],
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
    paymentGateways: json["paymentGateways"] == null ? [] : List<PaymentGateway>.from(json["paymentGateways"]!.map((x) => PaymentGateway.fromJson(x))),
    v: json["__v"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "country": country?.toJson(),
    "paymentGateways": paymentGateways == null ? [] : List<dynamic>.from(paymentGateways!.map((x) => x.toJson())),
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class Country {
  String? id;
  String? countryName;

  Country({
    this.id,
    this.countryName,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["_id"],
    countryName: json["countryName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "countryName": countryName,
  };
}

class PaymentGateway {
  String? method;
  String? paymentTypes;
  String? publicFileUrl;
  String? id;

  PaymentGateway({
    this.method,
    this.paymentTypes,
    this.publicFileUrl,
    this.id,
  });

  factory PaymentGateway.fromJson(Map<String, dynamic> json) => PaymentGateway(
    method: json["method"],
    paymentTypes: json["paymentTypes"],
    publicFileUrl: json["publicFileUrl"],
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "method": method,
    "paymentTypes": paymentTypes,
    "publicFileUrl": publicFileUrl,
    "_id": id,
  };
}
