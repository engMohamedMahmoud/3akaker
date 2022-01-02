

class CartProductModel {


  String id, image, title, titleAr,type;
  num price;
  int count;


  CartProductModel({this.id, this.image, this.title, this.count, this.price, this.titleAr,this.type});



  CartProductModel.fromJson(Map<dynamic , dynamic> map){
    if (map == null){
      return;
    }
    id = map['id'];
    image = map['image'];
    title = map['title'];
    price = map['price'];
    count = map['count'];
    titleAr = map["titleAr"];
    type = map["type"];
  }

  toJson(){
    return {
      'id' : id,
      'image': image,
      'title': title,
      'price': price,
      'count': count,
      'titleAr': titleAr,
      'type':type

    };
  }

}




class Item {

  String id, image, title, titleAr;
  int price, count;



  Item({this.id, this.image, this.title, this.titleAr, this.price, this.count});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();

    m['id'] = id;
    m['image'] = image;

    m['title'] = title;
    m['titleAr'] = titleAr;

    m['price'] = price;
    m['count'] = count;

    return m;
  }
}

class TodoList {
  List<Item> items;

  TodoList() {
    items = new List();
  }

  toJSONEncodable() {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }
}