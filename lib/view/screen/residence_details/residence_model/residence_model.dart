// To parse this JSON data, do
//
//     final residenceModel = residenceModelFromJson(jsonString);

import 'dart:convert';

ResidenceModel residenceModelFromJson(String str) => ResidenceModel.fromJson(json.decode(str));

String residenceModelToJson(ResidenceModel data) => json.encode(data.toJson());

class ResidenceModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  ResidenceModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory ResidenceModel.fromJson(Map<String, dynamic> json) => ResidenceModel(
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
  Residences? residences;

  Attributes({
    this.residences,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    residences: json["residences"] == null ? null : Residences.fromJson(json["residences"]),
  );

  Map<String, dynamic> toJson() => {
    "residences": residences?.toJson(),
  };
}

class Residences {
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
  int? views;
  int? likes;
  int? comments;
  int? ratings;
  int? dailyAmount;
  List<Category>? amenities;
  String? ownerName;
  HostId? hostId;
  String? aboutOwner;
  String? status;
  Category? category;
  String? country;
  bool? isDeleted;
  String? acceptanceStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  dynamic feedBack;
  bool? reUpload;

  Residences({
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
    this.views,
    this.likes,
    this.comments,
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
  });

  factory Residences.fromJson(Map<String, dynamic> json) => Residences(
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
    views: json["views"],
    likes: json["likes"],
    comments: json["comments"],
    ratings: json["ratings"],
    dailyAmount: json["dailyAmount"],
    amenities: json["amenities"] == null ? [] : List<Category>.from(json["amenities"]!.map((x) => Category.fromJson(x))),
    ownerName: json["ownerName"],
    hostId: json["hostId"] == null ? null : HostId.fromJson(json["hostId"]),
    aboutOwner: json["aboutOwner"],
    status: json["status"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    country: json["country"],
    isDeleted: json["isDeleted"],
    acceptanceStatus: json["acceptanceStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    feedBack: json["feedBack"],
    reUpload: json["reUpload"],
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
    "views": views,
    "likes": likes,
    "comments": comments,
    "ratings": ratings,
    "dailyAmount": dailyAmount,
    "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
    "ownerName": ownerName,
    "hostId": hostId?.toJson(),
    "aboutOwner": aboutOwner,
    "status": status,
    "category": category?.toJson(),
    "country": country,
    "isDeleted": isDeleted,
    "acceptanceStatus": acceptanceStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "feedBack": feedBack,
    "reUpload": reUpload,
  };
}

class Category {
  Translation? translation;
  String? id;

  Category({
    this.translation,
    this.id,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    translation: json["translation"] == null ? null : Translation.fromJson(json["translation"]),
    id: json["_id"],
  );

  Map<String, dynamic> toJson() => {
    "translation": translation?.toJson(),
    "_id": id,
  };
}

class Translation {
  String? en;
  String? fr;

  Translation({
    this.en,
    this.fr,
  });

  factory Translation.fromJson(Map<String, dynamic> json) => Translation(
    en: json["en"],
    fr: json["fr"],
  );

  Map<String, dynamic> toJson() => {
    "en": en,
    "fr": fr,
  };
}

class HostId {
  String? id;
  String? fullName;
  String? email;
  String? phoneNumber;
  String? address;
  Photo? image;

  HostId({
    this.id,
    this.fullName,
    this.email,
    this.phoneNumber,
    this.address,
    this.image,
  });

  factory HostId.fromJson(Map<String, dynamic> json) => HostId(
    id: json["_id"],
    fullName: json["fullName"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    address: json["address"],
    image: json["image"] == null ? null : Photo.fromJson(json["image"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "email": email,
    "phoneNumber": phoneNumber,
    "address": address,
    "image": image?.toJson(),
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
