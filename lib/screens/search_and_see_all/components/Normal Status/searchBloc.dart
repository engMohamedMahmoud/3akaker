import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:aakaker/screens/home/components/home_services/model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;
import '../../../../constants.dart';




class MySearchBloc {
  String type;
  final API api = API();
  int pageNumber = 0;
  double pixels = 0.0;



  ReplaySubject<List<MyProduct>> _subject = ReplaySubject();

  final ReplaySubject<ScrollNotification> _controller = ReplaySubject();

  Observable<List<MyProduct>> get stream => _subject.stream;
  Sink<ScrollNotification> get sink => _controller.sink;

  MySearchBloc(String selectedType)   {



    _subject.addStream(Observable.fromFuture(api.getmedicines(pageNumber,selectedType)));


    print("The type : ${selectedType}");

    type = selectedType;
    _controller.listen((notification) => loadPhotos(notification,type));
  }



  Future<void> loadPhotos([ScrollNotification notification,String type]) async {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent && pixels != notification.metrics.pixels) {
      pixels = notification.metrics.pixels;
      pageNumber++;

      List<MyProduct> list = await api.getmedicines(pageNumber,type);

      _subject.sink.add(list);
    }
  }



  void dispose() {
    _controller.close();
    _subject.close();
  }
}


class API {

  Future<List<MyProduct>> getmedicines(int albumId, String type) async {
    getDeliveryCost();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(("$url/products/$type/EN/$albumId"), headers: {"authorization":prefs.getString('token')});
    final response1 = await http.get(("$url/products/Cosmetic/EN/$albumId"), headers: {"authorization":prefs.getString('token')});
    List jsonData = json.decode(response.body);
    List jsonData1 = json.decode(response1.body);
    jsonData.addAll(jsonData1);

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