import 'dart:convert';

ResidenceReservationModel residenceReservationModelFromJson(String str) => ResidenceReservationModel.fromJson(json.decode(str));

String residenceReservationModelToJson(ResidenceReservationModel data) => json.encode(data.toJson());

class ResidenceReservationModel {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  ResidenceReservationModel({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory ResidenceReservationModel.fromRawJson(String str) => ResidenceReservationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResidenceReservationModel.fromJson(Map<String, dynamic> json) => ResidenceReservationModel(
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
  String? bookingId;
  String? userId;
  HostId? hostId;
  String? residenceId;
  int? numberOfGuests;
  String? userContactNumber;
  TotalTime? totalTime;
  int? totalAmount;
  DateTime? checkInTime;
  DateTime? checkOutTime;
  String? status;
  String? guestTypes;
  String? paymentTypes;
  bool? isDeleted;
  bool? isUserHistoryDeleted;
  bool? isHostHistoryDeleted;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Attributes({
    this.bookingId,
    this.userId,
    this.hostId,
    this.residenceId,
    this.numberOfGuests,
    this.userContactNumber,
    this.totalTime,
    this.totalAmount,
    this.checkInTime,
    this.checkOutTime,
    this.status,
    this.guestTypes,
    this.paymentTypes,
    this.isDeleted,
    this.isUserHistoryDeleted,
    this.isHostHistoryDeleted,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Attributes.fromRawJson(String str) => Attributes.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    bookingId: json["bookingId"],
    userId: json["userId"],
    hostId: json["hostId"] == null ? null : HostId.fromJson(json["hostId"]),
    residenceId: json["residenceId"],
    numberOfGuests: json["numberOfGuests"],
    userContactNumber: json["userContactNumber"],
    totalTime: json["totalTime"] == null ? null : TotalTime.fromJson(json["totalTime"]),
    totalAmount: json["totalAmount"],
    checkInTime: json["checkInTime"] == null ? null : DateTime.parse(json["checkInTime"]),
    checkOutTime: json["checkOutTime"] == null ? null : DateTime.parse(json["checkOutTime"]),
    status: json["status"],
    guestTypes: json["guestTypes"],
    paymentTypes: json["paymentTypes"],
    isDeleted: json["isDeleted"],
    isUserHistoryDeleted: json["isUserHistoryDeleted"],
    isHostHistoryDeleted: json["isHostHistoryDeleted"],
    id: json["_id"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "bookingId": bookingId,
    "userId": userId,
    "hostId": hostId?.toJson(),
    "residenceId": residenceId,
    "numberOfGuests": numberOfGuests,
    "userContactNumber": userContactNumber,
    "totalTime": totalTime?.toJson(),
    "totalAmount": totalAmount,
    "checkInTime": checkInTime?.toIso8601String(),
    "checkOutTime": checkOutTime?.toIso8601String(),
    "status": status,
    "guestTypes": guestTypes,
    "paymentTypes": paymentTypes,
    "isDeleted": isDeleted,
    "isUserHistoryDeleted": isUserHistoryDeleted,
    "isHostHistoryDeleted": isHostHistoryDeleted,
    "_id": id,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

class HostId {
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
  dynamic oneTimeCode;
  bool? isDeleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  String? status;

  HostId({
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
    this.oneTimeCode,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.status,
  });

  factory HostId.fromRawJson(String str) => HostId.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HostId.fromJson(Map<String, dynamic> json) => HostId(
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
    oneTimeCode: json["oneTimeCode"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    status: json["status"],
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
    "oneTimeCode": oneTimeCode,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "status": status,
  };
}

class Image {
  String? publicFileUrl;
  String? path;

  Image({
    this.publicFileUrl,
    this.path,
  });

  factory Image.fromRawJson(String str) => Image.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    publicFileUrl: json["publicFileUrl"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "publicFileUrl": publicFileUrl,
    "path": path,
  };
}

class TotalTime {
  int? days;
  double? hours;

  TotalTime({
    this.days,
    this.hours,
  });

  factory TotalTime.fromRawJson(String str) => TotalTime.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TotalTime.fromJson(Map<String, dynamic> json) => TotalTime(
    days: json["days"],
    hours: json["hours"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "days": days,
    "hours": hours,
  };
}

