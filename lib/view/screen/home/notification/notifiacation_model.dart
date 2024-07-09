// To parse this JSON data, do
//
//     final EventModel = notificationModelFromJson(jsonString);

import 'dart:convert';

EventModel notificationModelFromJson(String str) => EventModel.fromJson(json.decode(str));

String notificationModelToJson(EventModel data) => json.encode(data.toJson());

class EventModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  EventModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) => EventModel(
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
  String? title;
  Image? image;

  Attribute({
    this.id,
    this.title,
    this.image,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
    id: json["_id"],
    title: json["title"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "title": title,
    "image": image?.toJson(),
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
