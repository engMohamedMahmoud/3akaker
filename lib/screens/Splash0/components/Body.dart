import 'dart:async';
import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:aakaker/screens/Conection/test_conection.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import 'package:aakaker/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import '../../../constants.dart';
import '../../../main.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LatLng center;
  String token;
  Position currentLocation;
  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;
  StreamSubscription iosSubscription;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  FlutterLocalNotificationsPlugin fltNotification;

  void notitficationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }





  @override
  Future<void> initState() {
    // TODO: implement initState


    super.initState();

    notitficationPermission();
    // var initialzationSettingsAndroid =
    // AndroidInitializationSettings('@mipmap/ic_launcher');
    // var iosInit = IOSInitializationSettings();
    // var initializationSettings =
    // InitializationSettings(android: initialzationSettingsAndroid,iOS: iosInit);
    //
    // flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   RemoteNotification notification = message.notification;
    //   AndroidNotification android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     flutterLocalNotificationsPlugin.show(
    //         notification.hashCode,
    //         notification.title,
    //         notification.body,
    //         NotificationDetails(
    //           android: AndroidNotificationDetails(
    //             channel.id,
    //             channel.name,
    //             channel.description,
    //             icon: android?.smallIcon,
    //           ),
    //         ));
    //   }
    // });




    FirebaseMessaging.instance.subscribeToTopic('PharmacyApp');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      print("hhhhhhhhhhhhhhhhhhhhhhhhhhh");
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,

            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                channelShowBadge: true,
                // TODO add a proper drawable resource to android, for now using
                icon: '@mipmap/ic_launcher',
                color: Colors.white,
                importance: Importance.high,

              ),
            ));
      }
    });

    // FirebaseMessaging.instance.unsubscribeFromTopic('PharmacyApp');
    getUserLocation();
    Timer(Duration(seconds: 7), () async {


      SharedPreferences prefs = await SharedPreferences.getInstance();





      if (prefs.getString('token') != null && prefs.getString('Pharmacy') != null) {

        print(prefs.getString('token'));

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder:
                    (BuildContext context) =>
                new HomeScreen()));
      } else {

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder:
                    (BuildContext context) =>
                new SplashScreen1()));
      }
    });

  }
  Future getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission != PermissionStatus.granted) {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission != PermissionStatus.granted) return;
    }
  }
  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
  getUserLocation() async {
    currentLocation = await locateUser();
    center = LatLng(currentLocation.latitude, currentLocation.longitude);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble('lat', currentLocation.latitude);
    prefs.setDouble('long', currentLocation.longitude);


  }






  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage(
        'assets/images/welcome_illustration.png'); //<- Creates an object that fetches an image.
    var image = new Image(
      image: assetsImage,
      fit: BoxFit.cover,
      height: 200,
      width: 200,
      alignment: Alignment.center,
    );
    return Scaffold(
      body:

      Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(color: Colors.white60),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // CircleAvatar(
                      //   backgroundColor: Colors.white,
                      //   radius: 50.0,
                      //   child: Icon(
                      //     Icons.shopping_cart,
                      //     color: Colors.greenAccent,
                      //     size: 50.0,
                      //   ),
                      // ),
                      Center(
                        child: image,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        AppLocalizations.of(context).translate("Phrama"),
                        style: TextStyle(
                            color: KTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text(
                      AppLocalizations.of(context).translate("Phramat"),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: KTextColor),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
