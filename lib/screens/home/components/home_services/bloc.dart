import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:aakaker/screens/home/components/home_services/model.dart';
import 'package:rxdart/rxdart.dart';

import 'network.dart';




class PhotoBloc {
  String type;
  final API api = API();
  int pageNumber = 0;
  double pixels = 0.0;



  ReplaySubject<List<MyProduct>> _subject = ReplaySubject();

  final ReplaySubject<ScrollNotification> _controller = ReplaySubject();

  Observable<List<MyProduct>> get stream => _subject.stream;
  Sink<ScrollNotification> get sink => _controller.sink;

  PhotoBloc(String selectedType) {
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




class SearchResultBloc with ChangeNotifier {
  String textSearch;
  final APISearch api = APISearch();
  int pageNumber = 0;
  double pixels = 0.0;



  ReplaySubject<List<Product>> _subject = ReplaySubject();

  final ReplaySubject<ScrollNotification> _controller = ReplaySubject();

  Observable<List<Product>> get stream => _subject.stream;
  Sink<ScrollNotification> get sink => _controller.sink;

  SearchResultBloc(String word) {
    print(" a   : $word");
    _subject.addStream(Observable.fromFuture(api.getSearch(pageNumber,word)));
    _controller.listen((notification) => loadProducts(notification,word));
  }



  Future<void> loadProducts([ScrollNotification notification,String textSearch]) async {
    if (notification.metrics.pixels == notification.metrics.maxScrollExtent && pixels != notification.metrics.pixels) {
      pixels = notification.metrics.pixels;
      pageNumber++;

      List<Product> list = await api.getSearch(pageNumber,textSearch);
      _subject.sink.add(list);
    }
  }



  void dispose() {
    _controller.close();
    _subject.close();
  }
}





