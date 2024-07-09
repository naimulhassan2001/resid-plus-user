// To parse this JSON data, do
//
//     final signUpModel = signUpModelFromJson(jsonString);

import 'dart:convert';

SignUpErrorModel signUpModelFromJson(String str) => SignUpErrorModel.fromJson(json.decode(str));

String signUpModelToJson(SignUpErrorModel data) => json.encode(data.toJson());

class SignUpErrorModel {
  String? status;
  String? statusCode;
  List<Message>? message;
  Data? data;

  SignUpErrorModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory SignUpErrorModel.fromJson(Map<String, dynamic> json) => SignUpErrorModel(
    status: json["status"],
    statusCode: json["statusCode"],
    message: json["message"] == null ? [] : List<Message>.from(json["message"]!.map((x) => Message.fromJson(x))),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "statusCode": statusCode,
    "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x.toJson())),
    "data": data?.toJson(),
  };
}

class Data {
  String? type;

  Data({
    this.type,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
  };
}

class Message {
  String? field;
  String? error;

  Message({
    this.field,
    this.error,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    field: json["field"],
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "field": field,
    "error": error,
  };
}
