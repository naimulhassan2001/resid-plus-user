class NotificationResponseModel {
  NotificationResponseModel({
      String? status, 
      String? statusCode, 
      String? message, 
      Data? data,}){
    _status = status;
    _statusCode = statusCode;
    _message = message;
    _data = data;
}

  NotificationResponseModel.fromJson(dynamic json) {
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
      List<AllNotification>? allNotification, 
      int? notViewed, 
      Pagination? pagination,}){
    _allNotification = allNotification;
    _notViewed = notViewed;
    _pagination = pagination;
}

  Attributes.fromJson(dynamic json) {
    if (json['allNotification'] != null) {
      _allNotification = [];
      json['allNotification'].forEach((v) {
        _allNotification?.add(AllNotification.fromJson(v));
      });
    }
    _notViewed = json['notViewed'];
    _pagination = json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null;
  }
  List<AllNotification>? _allNotification;
  int? _notViewed;
  Pagination? _pagination;

  List<AllNotification>? get allNotification => _allNotification;
  int? get notViewed => _notViewed;
  Pagination? get pagination => _pagination;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_allNotification != null) {
      map['allNotification'] = _allNotification?.map((v) => v.toJson()).toList();
    }
    map['notViewed'] = _notViewed;
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
      int? nextPage,}){
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
  int? _nextPage;

  int? get totalDocuments => _totalDocuments;
  int? get totalPage => _totalPage;
  int? get currentPage => _currentPage;
  dynamic get previousPage => _previousPage;
  int? get nextPage => _nextPage;

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

class AllNotification {
  AllNotification({
      String? id, 
      String? receiverId, 
      String? message, 
      Image? image, 
      String? linkId, 
      String? role, 
      String? type, 
      bool? viewStatus, 
      int? v, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _receiverId = receiverId;
    _message = message;
    _image = image;
    _linkId = linkId;
    _role = role;
    _type = type;
    _viewStatus = viewStatus;
    _v = v;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  AllNotification.fromJson(dynamic json) {
    _id = json['_id'];
    _receiverId = json['receiverId'];
    _message = json['message'];
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
    _linkId = json['linkId'];
    _role = json['role'];
    _type = json['type'];
    _viewStatus = json['viewStatus'];
    _v = json['__v'];
    _createdAt = json['createdAt'];
    _updatedAt = json['updatedAt'];
  }
  String? _id;
  String? _receiverId;
  String? _message;
  Image? _image;
  String? _linkId;
  String? _role;
  String? _type;
  bool? _viewStatus;
  int? _v;
  String? _createdAt;
  String? _updatedAt;

  String? get id => _id;
  String? get receiverId => _receiverId;
  String? get message => _message;
  Image? get image => _image;
  String? get linkId => _linkId;
  String? get role => _role;
  String? get type => _type;
  bool? get viewStatus => _viewStatus;
  int? get v => _v;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['receiverId'] = _receiverId;
    map['message'] = _message;
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['linkId'] = _linkId;
    map['role'] = _role;
    map['type'] = _type;
    map['viewStatus'] = _viewStatus;
    map['__v'] = _v;
    map['createdAt'] = _createdAt;
    map['updatedAt'] = _updatedAt;
    return map;
  }

}

class Image {
  Image({
      String? publicFileUrl, 
      String? path,}){
    _publicFileUrl = publicFileUrl;
    _path = path;
}

  Image.fromJson(dynamic json) {
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