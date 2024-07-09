// To parse this JSON data, do
//
//     final otpModel = otpModelFromJson(jsonString);

import 'dart:convert';

EmailVerifyModel otpModelFromJson(String str) => EmailVerifyModel.fromJson(json.decode(str));

String otpModelToJson(EmailVerifyModel data) => json.encode(data.toJson());

class EmailVerifyModel {
  String? status;
  int? statusCode;
  String? message;
  Data? data;

  EmailVerifyModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory EmailVerifyModel.fromJson(Map<String, dynamic> json) => EmailVerifyModel(
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
  String? fullName;
  String? email;
  String? phoneNumber;
  String? address;
  String? dateOfBirth;
  String? password;
  Image? image;
  String? role;
  bool? emailVerified;
  String? createdAt;
  String? updatedAt;
  int? v;
  String? oneTimeCode;

  Attributes({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.address,
    this.dateOfBirth,
    this.password,
    this.image,
    this.role,
    this.emailVerified,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.oneTimeCode,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    address: json["address"],
    dateOfBirth: json["dateOfBirth"],
    password: json["password"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
    role: json["role"],
    emailVerified: json["emailVerified"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
    oneTimeCode: json["oneTimeCode"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "phoneNumber": phoneNumber,
    "address": address,
    "dateOfBirth": dateOfBirth,
    "password": password,
    "image": image?.toJson(),
    "role": role,
    "emailVerified": emailVerified,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
    "oneTimeCode": oneTimeCode,
  };
}

class Image {
  String? publicFileUrl;
  String? path;

  Image({
    this.publicFileUrl,
    this.path,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    publicFileUrl: json["publicFileUrl"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileUrl": publicFileUrl,
    "path": path,
  };
}
