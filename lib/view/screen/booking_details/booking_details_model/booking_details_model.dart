import 'dart:convert';

AddPaymentBooking addPaymentBookingFromJson(String str) => AddPaymentBooking.fromJson(json.decode(str));

String addPaymentBookingToJson(AddPaymentBooking data) => json.encode(data.toJson());

class AddPaymentBooking {
  String? status;
  String? statusCode;
  String? message;
  Data? data;

  AddPaymentBooking({
    this.status,
    this.statusCode,
    this.message,
    this.data,
  });

  factory AddPaymentBooking.fromJson(Map<String, dynamic> json) => AddPaymentBooking(
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
  PaymentData? paymentData;
  String? bookingId;
  String? userId;
  String? hostId;
  String? id;
  String? createdAt;
  String? updatedAt;
  int? v;

  Attributes({
    this.paymentData,
    this.bookingId,
    this.userId,
    this.hostId,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    paymentData: json["paymentData"] == null ? null : PaymentData.fromJson(json["paymentData"]),
    bookingId: json["bookingId"],
    userId: json["userId"],
    hostId: json["hostId"],
    id: json["_id"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "paymentData": paymentData?.toJson(),
    "bookingId": bookingId,
    "userId": userId,
    "hostId": hostId,
    "_id": id,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
  };
}

class PaymentData {
  int? amount;
  String? email;

  PaymentData({
    this.amount,
    this.email,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) => PaymentData(
    amount: json["amount"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "email": email,
  };
}
