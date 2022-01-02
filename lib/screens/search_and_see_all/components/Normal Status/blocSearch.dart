
import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:aakaker/screens/home/components/home_services/model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;
import 'package:aakaker/constants.dart';


class PhotoBloc {
  String type;
  final APISearch api = APISearch();
  int pageNumber = 0;
  double pixels = 0.0;



  ReplaySubject<List<MyProduct>> _subject = ReplaySubject();

  final ReplaySubject<ScrollNotification> _controller = ReplaySubject();

  Observable<List<MyProduct>> get stream => _subject.stream;
  Sink<ScrollNotification> get sink => _controller.sink;

  PhotoBloc(String selectedType) {
    _subject.addStream(Observable.fromFuture(api.searchItems(pageNumber,selectedType)));

    print("The type : ${selectedType}");

    type = selectedType;
    _controller.listen((notification) => loadPhotos(notification,type));
  }



  Future<void> loadPhotos([ScrollNotification notification,String type]) async {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent && pixels != notification.metrics.pixels) {
      pixels = notification.metrics.pixels;
      pageNumber++;

      List<MyProduct> list = await api.searchItems(pageNumber,type);
      _subject.sink.add(list);
    }
  }



  void dispose() {
    _controller.close();
    _subject.close();
  }
}


class APISearch {

  Future<List<MyProduct>> searchItems(int albumId, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(("$url/Products/Filter/$type/EN/$albumId"), headers: {"authorization":prefs.getString('token')});
    List jsonData = json.decode(response.body);
    return jsonData.map((c) => MyProduct.fromJson(c)).toList();

  }

}