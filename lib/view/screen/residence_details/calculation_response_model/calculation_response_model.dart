import 'dart:convert';

class CalculationResponseModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  CalculationResponseModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory CalculationResponseModel.fromRawJson(String str) => CalculationResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CalculationResponseModel.fromJson(Map<String, dynamic> json) => CalculationResponseModel(
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
  DateTime? checkInTime;
  DateTime? checkOutTime;
  double? totalHours;
  int? totalDays;
  int? residenceCharge;
  int? serviceCharge;
  int? totalAmount;

  Attributes({
    this.checkInTime,
    this.checkOutTime,
    this.totalHours,
    this.totalDays,
    this.residenceCharge,
    this.serviceCharge,
    this.totalAmount,
  });

  factory Attributes.fromRawJson(String str) => Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    checkInTime: json["checkInTime"] == null ? null : DateTime.parse(json["checkInTime"]),
    checkOutTime: json["checkOutTime"] == null ? null : DateTime.parse(json["checkOutTime"]),
    totalHours: json["totalHours"].runtimeType==int?json["totalHours"].toDouble():json["totalHours"],
    totalDays: json["totalDays"],
    residenceCharge: json["residenceCharge"],
    serviceCharge: json["serviceCharge"],
    totalAmount: json["totalAmount"],
  );

  Map<String, dynamic> toJson() => {
    "checkInTime": checkInTime?.toIso8601String(),
    "checkOutTime": checkOutTime?.toIso8601String(),
    "totalHours": totalHours,
    "totalDays": totalDays,
    "residenceCharge": residenceCharge,
    "serviceCharge": serviceCharge,
    "totalAmount": totalAmount,
  };
}
