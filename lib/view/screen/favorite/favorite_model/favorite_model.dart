import 'dart:convert';

class FavoriteModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  FavoriteModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory FavoriteModel.fromRawJson(String str) => FavoriteModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FavoriteModel.fromJson(Map<String, dynamic> json) => FavoriteModel(
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
  List<Favourite>? favourites;
  Pagination? pagination;

  Attributes({
    this.favourites,
    this.pagination,
  });

  factory Attributes.fromRawJson(String str) => Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    favourites: json["favourites"] == null ? [] : List<Favourite>.from(json["favourites"]!.map((x) => Favourite.fromJson(x))),
    pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
  );

  Map<String, dynamic> toJson() => {
    "favourites": favourites == null ? [] : List<dynamic>.from(favourites!.map((x) => x.toJson())),
    "pagination": pagination?.toJson(),
  };
}

class Favourite {
  String? id;
  String? userId;
  ResidenceId? residenceId;
  int? v;

  Favourite({
    this.id,
    this.userId,
    this.residenceId,
    this.v,
  });

  factory Favourite.fromRawJson(String str) => Favourite.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
    id: json["_id"],
    userId: json["userId"],
    residenceId: json["residenceId"] == null ? null : ResidenceId.fromJson(json["residenceId"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "residenceId": residenceId?.toJson(),
    "__v": v,
  };
}

class ResidenceId {
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
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? isDeleted;

  ResidenceId({
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
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isDeleted,
  });

  factory ResidenceId.fromRawJson(String str) => ResidenceId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResidenceId.fromJson(Map<String, dynamic> json) => ResidenceId(
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
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    isDeleted: json["isDeleted"],
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
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "isDeleted": isDeleted,
  };
}

class Photo {
  String? publicFileUrl;
  String? path;

  Photo({
    this.publicFileUrl,
    this.path,
  });

  factory Photo.fromRawJson(String str) => Photo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
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

  factory Pagination.fromRawJson(String str) => Pagination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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
