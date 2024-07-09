// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  HomeModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
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
  List<Residence>? residences;
  Pagination? pagination;

  Attributes({
    this.residences,
    this.pagination,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    residences: json["residences"] == null ? [] : List<Residence>.from(json["residences"]!.map((x) => Residence.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "residences": residences == null ? [] : List<dynamic>.from(residences!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Pagination {
  int? totalDocuments;
  int? totalPage;
  int? currentPage;
  dynamic previousPage;
  dynamic nextPage;

  Pagination({
    this.totalDocuments,
    this.totalPage,
    this.currentPage,
    this.previousPage,
    this.nextPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    totalDocuments: json["totalDocuments"],
    totalPage: json["totalPage"],
    currentPage: json["currentPage"],
    previousPage: json["previousPage"],
    nextPage: json["nextPage"],
  );

  Map<String, dynamic> toJson() => {
    "totalDocuments": totalDocuments,
    "totalPage": totalPage,
    "currentPage": currentPage,
    "previousPage": previousPage,
    "nextPage": nextPage,
  };
}

class Residence {
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
  String? ownerName;
  String? hostId;
  String? aboutOwner;
  String? status;
  bool? isDeleted;
  String? acceptanceStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic feedBack;
  bool? reUpload;
  int? comments;
  int? likes;
  int? views;
  bool? isLiked;
  List<Category>? amenities;
  Category? category;
  Country? country;

  Residence({
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
    this.ownerName,
    this.hostId,
    this.aboutOwner,
    this.status,
    this.isDeleted,
    this.acceptanceStatus,
    this.createdAt,
    this.updatedAt,
    this.feedBack,
    this.reUpload,
    this.comments,
    this.likes,
    this.views,
    this.isLiked,
    this.amenities,
    this.category,
    this.country,
  });

  factory Residence.fromJson(Map<String, dynamic> json) => Residence(
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
    ownerName: json["ownerName"],
    hostId: json["hostId"],
    aboutOwner: json["aboutOwner"],
    status: json["status"],
    isDeleted: json["isDeleted"],
    acceptanceStatus: json["acceptanceStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    feedBack: json["feedBack"],
    reUpload: json["reUpload"],
    comments: json["comments"],
    likes: json["likes"],
    views: json["views"],
    isLiked: json["isLiked"],
    amenities: json["amenities"] == null ? [] : List<Category>.from(json["amenities"]!.map((x) => Category.fromJson(x))),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    country: json["country"] == null ? null : Country.fromJson(json["country"]),
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
    "ownerName": ownerName,
    "hostId": hostId,
    "aboutOwner": aboutOwner,
    "status": status,
    "isDeleted": isDeleted,
    "acceptanceStatus": acceptanceStatus,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "feedBack": feedBack,
    "reUpload": reUpload,
    "comments": comments,
    "likes": likes,
    "views": views,
    "isLiked": isLiked,
    "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x.toJson())),
    "category": category?.toJson(),
    "country": country?.toJson(),
  };
}

class Category {
  String? id;
  Translation? translation;

  Category({
    this.id,
    this.translation,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    translation: json["translation"] == null ? null : Translation.fromJson(json["translation"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "translation": translation?.toJson(),
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
