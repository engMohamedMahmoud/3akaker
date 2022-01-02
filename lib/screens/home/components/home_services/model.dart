class Product {
  final String id;
  final String NameAR, NameEN, Picture, Type;
  final double Price;

  Product(
      {this.id, this.NameAR, this.NameEN, this.Price, this.Picture, this.Type});

  Product.fromJson(Map json)
      : this.id = json["_id"],
        this.NameAR = json["NameAR"],
        this.NameEN = json["NameEN"],
        this.Price = json["Price"],
        this.Type = json["Type"],
        this.Picture = json["Picture"];
}


class LocationDetails{

   final double lat, long;
   final String state, country, city, street, flatNumber, phone, userName, buildingNo;

  LocationDetails(this.lat, this.long, this.state, this.country, this.city, this.street, this.flatNumber, this.phone, this.userName, this.buildingNo);

}


class MyProduct {
  final String id;
  final String NameAR, NameEN, Type;
  final num Price;

  MyProduct(
      {this.id, this.NameAR, this.NameEN, this.Price, this.Type});

  MyProduct.fromJson(Map json)
      : this.id = json["_id"],
        this.NameAR = json["NameAR"],
        this.NameEN = json["NameEN"],
        this.Price = json["Price"],
        this.Type = json["Type"];
        // this.Picture = json["Picture"];


}