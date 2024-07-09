class SearchModel {
  SearchModel({
      String? status, 
      String? statusCode, 
      String? message, 
      Data? data,}){
    _status = status;
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  SearchModel.fromJson(dynamic json) {
    _status = json['status'];
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  String? _status;
  String? _statusCode;
  String? _message;
  Data? _data;

  String? get status => _status;
  String? get statusCode => _statusCode;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      String? type, 
      Attributes? attributes,}){
    _type = type;
    _attributes = attributes;
}

  Data.fromJson(dynamic json) {
    _type = json['type'];
    _attributes = json['attributes'] != null ? Attributes.fromJson(json['attributes']) : null;
  }
  String? _type;
  Attributes? _attributes;

  String? get type => _type;
  Attributes? get attributes => _attributes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    if (_attributes != null) {
      map['attributes'] = _attributes?.toJson();
    }
    return map;
  }

}

class Attributes {
  Attributes({
      List<Residences>? residences, 
      Pagination? pagination,}){
    _residences = residences;
    _pagination = pagination;
}

  Attributes.fromJson(dynamic json) {
    if (json['residences'] != null) {
      _residences = [];
      json['residences'].forEach((v) {
        _residences?.add(Residences.fromJson(v));
      });
    }
    _pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<Residences>? _residences;
  Pagination? _pagination;

  List<Residences>? get residences => _residences;
  Pagination? get pagination => _pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_residences != null) {
      map['residences'] = _residences?.map((v) => v.toJson()).toList();
    }
    if (_pagination != null) {
      map['pagination'] = _pagination?.toJson();
    }
    return map;
  }

}

class Pagination {
  Pagination({
      int? totalDocuments, 
      int? totalPage, 
      int? currentPage, 
      dynamic previousPage, 
      dynamic nextPage,}){
    _totalDocuments = totalDocuments;
    _totalPage = totalPage;
    _currentPage = currentPage;
    _previousPage = previousPage;
    _nextPage = nextPage;
}

  Pagination.fromJson(dynamic json) {
    _totalDocuments = json['totalDocuments'];
    _totalPage = json['totalPage'];
    _currentPage = json['currentPage'];
    _previousPage = json['previousPage'];
    _nextPage = json['nextPage'];
  }
  int? _totalDocuments;
  int? _totalPage;
  int? _currentPage;
  dynamic _previousPage;
  dynamic _nextPage;

  int? get totalDocuments => _totalDocuments;
  int? get totalPage => _totalPage;
  int? get currentPage => _currentPage;
  dynamic get previousPage => _previousPage;
  dynamic get nextPage => _nextPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalDocuments'] = _totalDocuments;
    map['totalPage'] = _totalPage;
    map['currentPage'] = _currentPage;
    map['previousPage'] = _previousPage;
    map['nextPage'] = _nextPage;
    return map;
  }

}

class Residences {
  Residences({
      String? id, 
      String? residenceName, 
      List<Photo>? photo, 
      int? capacity, 
      int? beds, 
      int? baths, 
      String? address, 
      String? city, 
      String? municipality, 
      String? quirtier, 
      String? aboutResidence, 
      int? hourlyAmount, 
      int? popularity, 
      int? ratings, 
      int? dailyAmount, 
      List<Amenities>? amenities, 
      String? ownerName, 
      String? hostId, 
      String? aboutOwner, 
      String? status, 
      Category? category, 
      bool? isDeleted, 
      String? createdAt, 
      String? updatedAt, 
      int? v,}){
    _id = id;
    _residenceName = residenceName;
    _photo = photo;
    _capacity = capacity;
    _beds = beds;
    _baths = baths;
    _address = address;
    _city = city;
    _municipality = municipality;
    _quirtier = quirtier;
    _aboutResidence = aboutResidence;
    _hourlyAmount = hourlyAmount;
    _popularity = popularity;
    _ratings = ratings;
    _dailyAmount = dailyAmount;
    _amenities = amenities;
    _ownerName = ownerName;
    _hostId = hostId;
    _aboutOwner = aboutOwner;
    _status = status;
    _category = category;
    _isDeleted = isDeleted;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _v = v;
}

  Residences.fromJson(dynamic json) {
    _id = json['_id'];
    _residenceName = json['residenceName'];
    if (json['photo'] != null) {
      _photo = [];
      json['photo'].forEach((v) {
        _photo?.add(Photo.fromJson(v));
      });
    }
    _capacity = json['capacity'];
    _beds = json['beds'];
    _baths = json['baths'];
    _address = json['address'];
    _city = json['city'];
    _municipality = json['municipality'];
    _quirtier = json['quirtier'];
    _aboutResidence = json['aboutResidence'];
    _hourlyAmount = json['hourlyAmount'];
    _popularity = json['popularity'];
    _ratings = json['ratings'];
    _dailyAmount = json['dailyAmount'];
    if (json['amenities'] != null) {
      _amenities = [];
      json['amenities'].forEach((v) {
        _amenities?.add(Amenities.fromJson(v));
      });
    }
    _ownerName = json['ownerName'];
    _hostId = json['hostId'];
    _aboutOwner = json['aboutOwner'];
    _status = json['status'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    _isDeleted = json['isDeleted'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
    _v = json['__v'];
  }
  String? _id;
  String? _residenceName;
  List<Photo>? _photo;
  int? _capacity;
  int? _beds;
  int? _baths;
  String? _address;
  String? _city;
  String? _municipality;
  String? _quirtier;
  String? _aboutResidence;
  int? _hourlyAmount;
  int? _popularity;
  int? _ratings;
  int? _dailyAmount;
  List<Amenities>? _amenities;
  String? _ownerName;
  String? _hostId;
  String? _aboutOwner;
  String? _status;
  Category? _category;
  bool? _isDeleted;
  String? _createdAt;
  String? _updatedAt;
  int? _v;

  String? get id => _id;
  String? get residenceName => _residenceName;
  List<Photo>? get photo => _photo;
  int? get capacity => _capacity;
  int? get beds => _beds;
  int? get baths => _baths;
  String? get address => _address;
  String? get city => _city;
  String? get municipality => _municipality;
  String? get quirtier => _quirtier;
  String? get aboutResidence => _aboutResidence;
  int? get hourlyAmount => _hourlyAmount;
  int? get popularity => _popularity;
  int? get ratings => _ratings;
  int? get dailyAmount => _dailyAmount;
  List<Amenities>? get amenities => _amenities;
  String? get ownerName => _ownerName;
  String? get hostId => _hostId;
  String? get aboutOwner => _aboutOwner;
  String? get status => _status;
  Category? get category => _category;
  bool? get isDeleted => _isDeleted;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['residenceName'] = _residenceName;
    if (_photo != null) {
      map['photo'] = _photo?.map((v) => v.toJson()).toList();
    }
    map['capacity'] = _capacity;
    map['beds'] = _beds;
    map['baths'] = _baths;
    map['address'] = _address;
    map['city'] = _city;
    map['municipality'] = _municipality;
    map['quirtier'] = _quirtier;
    map['aboutResidence'] = _aboutResidence;
    map['hourlyAmount'] = _hourlyAmount;
    map['popularity'] = _popularity;
    map['ratings'] = _ratings;
    map['dailyAmount'] = _dailyAmount;
    if (_amenities != null) {
      map['amenities'] = _amenities?.map((v) => v.toJson()).toList();
    }
    map['ownerName'] = _ownerName;
    map['hostId'] = _hostId;
    map['aboutOwner'] = _aboutOwner;
    map['status'] = _status;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    map['isDeleted'] = _isDeleted;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    map['__v'] = _v;
    return map;
  }

}

class Category {
  Category({
      Translation? translation, 
      String? id,}){
    _translation = translation;
    _id = id;
}

  Category.fromJson(dynamic json) {
    _translation = json['translation'] != null ? Translation.fromJson(json['translation']) : null;
    _id = json['_id'];
  }
  Translation? _translation;
  String? _id;

  Translation? get translation => _translation;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    map['_id'] = _id;
    return map;
  }

}

class Translation {
  Translation({
      String? en, 
      String? fr,}){
    _en = en;
    _fr = fr;
}

  Translation.fromJson(dynamic json) {
    _en = json['en'];
    _fr = json['fr'];
  }
  String? _en;
  String? _fr;

  String? get en => _en;
  String? get fr => _fr;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['en'] = _en;
    map['fr'] = _fr;
    return map;
  }

}

class Amenities {
  Amenities({
      Translation? translation, 
      String? id,}){
    _translation = translation;
    _id = id;
}

  Amenities.fromJson(dynamic json) {
    _translation = json['translation'] != null ? Translation.fromJson(json['translation']) : null;
    _id = json['_id'];
  }
  Translation? _translation;
  String? _id;

  Translation? get translation => _translation;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    map['_id'] = _id;
    return map;
  }

}

class Photo {
  Photo({
      String? publicFileUrl, 
      String? path,}){
    _publicFileUrl = publicFileUrl;
    _path = path;
}

  Photo.fromJson(dynamic json) {
    _publicFileUrl = json['publicFileUrl'];
    _path = json['path'];
  }
  String? _publicFileUrl;
  String? _path;

  String? get publicFileUrl => _publicFileUrl;
  String? get path => _path;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['publicFileUrl'] = _publicFileUrl;
    map['path'] = _path;
    return map;
  }

}