import 'dart:convert';

class SearchFilterModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  SearchFilterModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory SearchFilterModel.fromRawJson(String str) => SearchFilterModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SearchFilterModel.fromJson(Map<String, dynamic> json) => SearchFilterModel(
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
  List<int>? noOfUniqueBeds;
  List<PriceArray>? priceArray;
  List<Country>? countries;
  List<Category>? categories;

  Attributes({
    this.noOfUniqueBeds,
    this.priceArray,
    this.countries,
    this.categories,
  });

  factory Attributes.fromRawJson(String str) => Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    noOfUniqueBeds: json["noOfUniqueBeds"] == null ? [] : List<int>.from(json["noOfUniqueBeds"]!.map((x) => x)),
    priceArray: json["priceArray"] == null ? [] : List<PriceArray>.from(json["priceArray"]!.map((x) => PriceArray.fromJson(x))),
    countries: json["countries"] == null ? [] : List<Country>.from(json["countries"]!.map((x) => Country.fromJson(x))),
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "noOfUniqueBeds": noOfUniqueBeds == null ? [] : List<dynamic>.from(noOfUniqueBeds!.map((x) => x)),
    "priceArray": priceArray == null ? [] : List<dynamic>.from(priceArray!.map((x) => x.toJson())),
    "countries": countries == null ? [] : List<dynamic>.from(countries!.map((x) => x.toJson())),
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class Category {
  Translation? translation;
  String? id;

  Category({
    this.translation,
    this.id,
  });

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  factory Translation.fromRawJson(String str) => Translation.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

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

  factory Country.fromRawJson(String str) => Country.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["_id"],
    countryName: json["countryName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "countryName": countryName,
  };
}

class PriceArray {
  int? min;
  int? max;

  PriceArray({
    this.min,
    this.max,
  });

  factory PriceArray.fromRawJson(String str) => PriceArray.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PriceArray.fromJson(Map<String, dynamic> json) => PriceArray(
    min: json["min"],
    max: json["max"],
  );

  Map<String, dynamic> toJson() => {
    "min": min,
    "max": max,
  };
}
