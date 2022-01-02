// To parse this JSON data, do
//
//     final bannarModel = bannarModelFromMap(jsonString);

import 'dart:convert';

BannarModel bannarModelFromMap(String str) => BannarModel.fromMap(json.decode(str));

String bannarModelToMap(BannarModel data) => json.encode(data.toMap());

class BannarModel {
  BannarModel({
    this.id,
    this.header,
    this.description,
    this.price,
    this.expiryDate,
    this.picture,
    this.creationDate,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String header;
  String description;
  int price;
  int expiryDate;
  String picture;
  int creationDate;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory BannarModel.fromMap(Map<String, dynamic> json) => BannarModel(
    id: json["_id"],
    header: json["Header"],
    description: json["Description"],
    price: json["Price"],
    expiryDate: json["ExpiryDate"],
    picture: json["Picture"],
    creationDate: json["CreationDate"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "Header": header,
    "Description": description,
    "Price": price,
    "ExpiryDate": expiryDate,
    "Picture": picture,
    "CreationDate": creationDate,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "__v": v,
  };
}
