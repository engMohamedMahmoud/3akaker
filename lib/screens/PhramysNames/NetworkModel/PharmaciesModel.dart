// To parse this JSON data, do
//
//     final pharmaciesModel = pharmaciesModelFromMap(jsonString);

import 'dart:convert';

PharmaciesModel pharmaciesModelFromMap(String str) => PharmaciesModel.fromMap(json.decode(str));

String pharmaciesModelToMap(PharmaciesModel data) => json.encode(data.toMap());

class PharmaciesModel {
  PharmaciesModel({
    this.id,
    this.nameAr,
    this.nameEn,
    this.picture,
    this.createdAt,
    this.updatedAt,
    this.description,
    this.v,
  });

  String id;
  String nameAr;
  String nameEn;
  String picture;
  DateTime createdAt;
  DateTime updatedAt;
  String description;
  int v;

  factory PharmaciesModel.fromMap(Map<String, dynamic> json) => PharmaciesModel(
    id: json["_id"],
    nameAr: json["NameAR"],
    nameEn: json["NameEN"],
    picture: json["Picture"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    description: json["Description"],
    v: json["__v"],
  );

  Map<String, dynamic> toMap() => {
    "_id": id,
    "NameAR": nameAr,
    "NameEN": nameEn,
    "Picture": picture,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "Description": description,
    "__v": v,
  };
}
