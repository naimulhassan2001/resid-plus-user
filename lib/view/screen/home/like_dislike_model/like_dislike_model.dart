// To parse this JSON data, do
//
//     final likeUnlikeModel = likeUnlikeModelFromJson(jsonString);

import 'dart:convert';

LikeUnlikeModel likeUnlikeModelFromJson(String str) => LikeUnlikeModel.fromJson(json.decode(str));

String likeUnlikeModelToJson(LikeUnlikeModel data) => json.encode(data.toJson());

class LikeUnlikeModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  LikeUnlikeModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory LikeUnlikeModel.fromJson(Map<String, dynamic> json) => LikeUnlikeModel(
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
  String? residenceName;
  List<Photo>? photo;
  int? capacity;
  int? beds;
  int? baths;
  String? address;
  String? city;
  String? municipality;
  String? quirtier;
  String? aboutResidence;
  int? hourlyAmount;
  int? popularity;
  int? ratings;
  int? dailyAmount;
  List<String>? amenities;
  String? ownerName;
  String? hostId;
  String? aboutOwner;
  String? status;
  String? category;
  String? country;
  bool? isDeleted;
  String? acceptanceStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  dynamic feedBack;
  bool? reUpload;
  int? likes;
  int? comments;
  int? views;

  Attributes({
    this.id,
    this.residenceName,
    this.photo,
    this.capacity,
    this.beds,
    this.baths,
    this.address,
    this.city,
    this.municipality,
    this.quirtier,
    this.aboutResidence,
    this.hourlyAmount,
    this.popularity,
    this.ratings,
    this.dailyAmount,
    this.amenities,
    this.ownerName,
    this.hostId,
    this.aboutOwner,
    this.status,
    this.category,
    this.country,
    this.isDeleted,
    this.acceptanceStatus,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.feedBack,
    this.reUpload,
    this.likes,
    this.comments,
    this.views,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    id: json["_id"],
    residenceName: json["residenceName"],
    photo: json["photo"] == null ? [] : List<Photo>.from(json["photo"]!.map((x) => Photo.fromJson(x))),
    capacity: json["capacity"],
    beds: json["beds"],
    baths: json["baths"],
    address: json["address"],
    city: json["city"],
    municipality: json["municipality"],
    quirtier: json["quirtier"],
    aboutResidence: json["aboutResidence"],
    hourlyAmount: json["hourlyAmount"],
    popularity: json["popularity"],
    ratings: json["ratings"],
    dailyAmount: json["dailyAmount"],
    amenities: json["amenities"] == null ? [] : List<String>.from(json["amenities"]!.map((x) => x)),
    ownerName: json["ownerName"],
    hostId: json["hostId"],
    aboutOwner: json["aboutOwner"],
    status: json["status"],
    category: json["category"],
    country: json["country"],
    isDeleted: json["isDeleted"],
    acceptanceStatus: json["acceptanceStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    feedBack: json["feedBack"],
    reUpload: json["reUpload"],
    likes: json["likes"],
    comments: json["comments"],
    views: json["views"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "residenceName": residenceName,
    "photo": photo == null ? [] : List<dynamic>.from(photo!.map((x) => x.toJson())),
    "capacity": capacity,
    "beds": beds,
    "baths": baths,
    "address": address,
    "city": city,
    "municipality": municipality,
    "quirtier": quirtier,
    "aboutResidence": aboutResidence,
    "hourlyAmount": hourlyAmount,
    "popularity": popularity,
    "ratings": ratings,
    "dailyAmount": dailyAmount,
    "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x)),
    "ownerName": ownerName,
    "hostId": hostId,
    "aboutOwner": aboutOwner,
    "status": status,
    "category": category,
    "country": country,
    "isDeleted": isDeleted,
    "acceptanceStatus": acceptanceStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "feedBack": feedBack,
    "reUpload": reUpload,
    "likes": likes,
    "comments": comments,
    "views": views,
  };
}

class Photo {
  String? publicFileUrl;
  String? path;

  Photo({
    this.publicFileUrl,
    this.path,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    publicFileUrl: json["publicFileUrl"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileUrl": publicFileUrl,
    "path": path,
  };
}
