// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  CommentModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
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
  List<Comment>? comments;
  Pagination? pagination;

  Attributes({
    this.comments,
    this.pagination,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    comments: json["comments"] == null ? [] : List<Comment>.from(json["comments"]!.map((x) => Comment.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "comments": comments == null ? [] : List<dynamic>.from(comments!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Comment {
  String? id;
  String? residenceId;
  String? comment;
  UserId? userId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Comment({
    this.id,
    this.residenceId,
    this.comment,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    id: json["_id"],
    residenceId: json["residenceId"],
    comment: json["comment"],
    userId: json["userId"] == null ? null : UserId.fromJson(json["userId"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "residenceId": residenceId,
    "comment": comment,
    "userId": userId?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class UserId {
  String? id;
  String? fullName;
  Image? image;

  UserId({
    this.id,
    this.fullName,
    this.image,
  });

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    fullName: json["fullName"],
    image: json["image"] == null ? null : Image.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
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

class Pagination {
  int? totalDocuments;
  int? totalPages;
  int? currentPage;
  dynamic previousPage;
  dynamic nextPage;
  int? limit;

  Pagination({
    this.totalDocuments,
    this.totalPages,
    this.currentPage,
    this.previousPage,
    this.nextPage,
    this.limit,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalDocuments: json["totalDocuments"],
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    previousPage: json["previousPage"],
    nextPage: json["nextPage"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "totalDocuments": totalDocuments,
    "totalPages": totalPages,
    "currentPage": currentPage,
    "previousPage": previousPage,
    "nextPage": nextPage,
    "limit": limit,
  };
}
