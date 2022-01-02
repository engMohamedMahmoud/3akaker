import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:aakaker/constants.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'PharmaciesModel.dart';

class OrdersBloc {
  String id;
  final APIOrders api = APIOrders();
  int pageNumber = 0;
  double pixels = 0.0;



  ReplaySubject<List<PharmaciesModel>> _subject = ReplaySubject();

  final ReplaySubject<ScrollNotification> _controller = ReplaySubject();

  Observable<List<PharmaciesModel>> get stream => _subject.stream;
  Sink<ScrollNotification> get sink => _controller.sink;

  OrdersBloc() {
    _subject.addStream(Observable.fromFuture(api.getUserOrders(pageNumber,id)));


    id = id;
    _controller.listen((notification) => loadPhotos(notification,id));
  }



  Future<void> loadPhotos([ScrollNotification notification,String id]) async {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent && pixels != notification.metrics.pixels) {
      pixels = notification.metrics.pixels;
      pageNumber++;

      List<PharmaciesModel> list = await api.getUserOrders(pageNumber,id);
      _subject.sink.add(list);
    }
  }



  void dispose() {
    _controller.close();
    _subject.close();
  }
}


class APIOrders {

  Future<List<PharmaciesModel>> getUserOrders(int albumId,String id,) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print("$url/User/Orders/$id/EN/$albumId");
    print(prefs.getString('token'));

    final response = await http.get(Uri.parse("$url/Pharmacies/EN/$albumId"),headers: {"authorization":prefs.getString('token')});
    print("$url/User/Orders/$id/EN/$albumId");
    List jsonData = json.decode(response.body);
    print("status code my orders :${response.statusCode}");
    print(response.body);
    return jsonData.map((c) => PharmaciesModel.fromMap(c)).toList();
  }

}
