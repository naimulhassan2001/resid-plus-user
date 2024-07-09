import 'dart:convert';

class DeleteAccountModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  DeleteAccountModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory DeleteAccountModel.fromRawJson(String str) => DeleteAccountModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) => DeleteAccountModel(
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
  Data();

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
  );

  Map<String, dynamic> toJson() => {
  };
}
