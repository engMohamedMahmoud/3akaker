// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromMap(jsonString);

import 'dart:convert';

OrdersModel ordersModelFromMap(String str) => OrdersModel.fromMap(json.decode(str));

String ordersModelToMap(OrdersModel data) => json.encode(data.toMap());

class OrdersModel {
  OrdersModel({
    this.deliveryAddress,
    this.status,
    this.rate,
    this.roshetaPicture,
    this.type,
    this.id,
    this.totalPrice,
    this.shipping,
    this.products,
    this.paymentType,
    this.userId,
    this.orderId,
    this.creationDate,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.pharmacy,
  });

  DeliveryAddress deliveryAddress;
  String status;
  int rate;
  String roshetaPicture;
  String type;
  String id;
  int totalPrice;
  int shipping;
  List<Product> products;
  String paymentType;
  UserId userId;
  String orderId;
  int creationDate;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  String pharmacy;

  factory OrdersModel.fromMap(Map<String, dynamic> json) => OrdersModel(
    deliveryAddress: DeliveryAddress.fromMap(json["DeliveryAddress"]),
    status: json["Status"],
    rate: json["Rate"],
    roshetaPicture: json["RoshetaPicture"],
    type: json["Type"],
    id: json["_id"],
    totalPrice: json["TotalPrice"],
    shipping: json["Shipping"],
    products: List<Product>.from(json["Products"].map((x) => Product.fromMap(x))),
    paymentType: json["PaymentType"],
    userId: UserId.fromMap(json["UserID"]),
    orderId: json["OrderID"],
    creationDate: json["CreationDate"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    pharmacy: json["Pharmacy"],
  );

  Map<String, dynamic> toMap() => {
    "DeliveryAddress": deliveryAddress.toMap(),
    "Status": status,
    "Rate": rate,
    "RoshetaPicture": roshetaPicture,
    "Type": type,
    "_id": id,
    "TotalPrice": totalPrice,
    "Shipping": shipping,
    "Products": List<dynamic>.from(products.map((x) => x.toMap())),
    "PaymentType": paymentType,
    "UserID": userId.toMap(),
    "OrderID": orderId,
    "CreationDate": creationDate,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
    "Pharmacy":pharmacy
  };
}

class DeliveryAddress {
  DeliveryAddress({
    this.city,
    this.street,
    this.building,
    this.floor,
    this.flatNo,
    this.number,
    this.lat,
    this.long,
  });

  String city;
  String street;
  String building;
  String floor;
  String flatNo;
  String number;
  double lat;
  double long;

  factory DeliveryAddress.fromMap(Map<String, dynamic> json) => DeliveryAddress(
    city: json["City"],
    street: json["Street"],
    building: json["Building"],
    floor: json["Floor"],
    flatNo: json["FlatNo"],
    number: json["Number"],
    lat: json["Lat"].toDouble(),
    long: json["Long"].toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "City": city,
    "Street": street,
    "Building": building,
    "Floor": floor,
    "FlatNo": flatNo,
    "Number": number,
    "Lat": lat,
    "Long": long,
  };
}

class Product {
  Product({
    this.id,
    this.price,
    this.nameEn,
    this.nameAr,
    this.orderCount,
    this.type,
  });

  dynamic id;
  int price;
  String nameEn;
  String nameAr;
  int orderCount;
  String type;

  factory Product.fromMap(Map<String, dynamic> json) => Product(
    id: json["_id"],
    price: json["Price"],
    nameEn: json["NameEN"],
    nameAr: json["NameAR"],
    orderCount: json["OrderCount"],
    type: json["Type"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "Price": price,
    "NameEN": nameEn,
    "NameAR": nameAr,
    "OrderCount": orderCount,
    "Type": type,
  };
}

class UserId {
  UserId({
    this.id,
    this.firstName,
    this.lastName,
  });

  String id;
  String firstName;
  String lastName;

  factory UserId.fromMap(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    firstName: json["FirstName"],
    lastName: json["LastName"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "FirstName": firstName,
    "LastName": lastName,
  };
}
