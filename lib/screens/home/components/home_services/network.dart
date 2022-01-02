import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'model.dart';
import 'package:aakaker/constants.dart';





class API {

  Future<List<MyProduct>> getmedicines(int albumId, String type) async {
    getDeliveryCost();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(("$url/products/$type/EN/$albumId"), headers: {"authorization":prefs.getString('token')});
    List jsonData = json.decode(response.body);

    print("=================");

    print("$url/products/$type/EN/$albumId");
    print(response.body);
    print("=================");

    return jsonData.map((c) => MyProduct.fromJson(c)).toList();

  }


  Future getDeliveryCost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse("https://alsaydaly.herokuapp.com/User/Shipping"),headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${prefs.getString("token")}"
    });


    if (response.statusCode == 200) {


        var data = json.decode(response.body);
        double jsonResponse = double.parse(data);
        prefs.setDouble("shippingCost", jsonResponse);


        print("max value : ${response.body}");



    } else {
      throw Exception('Unexpected error occured!');
    }
  }


}
class APISearch {

  Future<List<Product>> getSearch(int albumId,String textSearch) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse("$url/Products/Filter/$textSearch/EN/$albumId"));
    List jsonData = json.decode(response.body);

    return jsonData.map((c) => Product.fromJson(c)).toList();
  }

}





