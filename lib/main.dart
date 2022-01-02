import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/instance_manager.dart';
import 'package:aakaker/routes.dart';
import 'package:aakaker/screens/Splash0/components/Body.dart';
import 'package:aakaker/screens/cart/components/cart_view_model.dart';
import 'package:aakaker/theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'localization/AppLanguage.dart';
import 'localization/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
  showBadge: true,
  playSound: true,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.data}');
  print(message.data);
  if(message.data.length != 0){
    flutterLocalNotificationsPlugin.show(
        message.data.hashCode,
        message.data['title'],
        message.data['body'],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channel.description,
          ),
        ));
  }

  // RemoteNotification notification = message.notification;
  // AndroidNotification android = message.notification?.android;
  // if (notification.body.length != 0 && android != null) {
  //   print("sdsds");
  //   flutterLocalNotificationsPlugin.show(
  //       notification.hashCode,
  //       notification.title,
  //       notification.body,
  //       NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           channel.id,
  //           channel.name,
  //           channel.description,
  //           icon: android?.smallIcon,
  //         ),
  //       ));
  // }

}



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );


  FirebaseMessaging.onBackgroundMessage(onBackgroundMessageHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);



  AppLanguage appLanguage = AppLanguage();
  Get.put(CartViewModel());
  await appLanguage.fetchLocale();
  runApp(MyApp(
    appLanguage: appLanguage,
  ));

}



Future<void> onBackgroundMessageHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  await FirebaseMessaging.instance.subscribeToTopic('PharmacyApp');



  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification?.android;
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

              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              channelShowBadge: true,
              // TODO add a proper drawable resource to android, for now using
              icon: '@mipmap/ic_launcher',
              importance: Importance.high,
            ),
          ));



    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('onMessageOpenedApp : $message');
  });




}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  final AppLanguage appLanguage;

  MyApp({this.appLanguage});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,

      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
          // theme: ThemeData(fontFamily: 'Tajawal'),
          locale: model.appLocal,
          supportedLocales: [
            Locale('ar', ''),
            Locale('en', 'US'),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],

          debugShowCheckedModeBanner: false,
          title: appLanguage.appLocal.languageCode == "en"? '3akaker': 'عقاقير',
          theme: theme(),
          home: SplashScreen(),


          // We use routeName so that we dont need to remember the name
          // initialRoute: SplashScreen0.routeName,
          routes: routes,
        );
      }),


    );

    //   Listener(
    //     onPointerDown: (_) {
    //   FocusScopeNode currentFocus = FocusScope.of(context);
    //   if (!currentFocus.hasPrimaryFocus) {
    //     currentFocus.focusedChild?.unfocus();
    //   }
    // },
    // child:
    //   ChangeNotifierProvider<AppLanguage>(
    //   create: (_) => appLanguage,
    //
    //   child: Consumer<AppLanguage>(builder: (context, model, child) {
    //     return MaterialApp(
    //       // theme: ThemeData(fontFamily: 'Tajawal'),
    //       locale: model.appLocal,
    //       supportedLocales: [
    //         Locale('en', 'US'),
    //         Locale('ar', ''),
    //       ],
    //       localizationsDelegates: [
    //         AppLocalizations.delegate,
    //         GlobalMaterialLocalizations.delegate,
    //         GlobalWidgetsLocalizations.delegate,
    //
    //       ],
    //
    //       debugShowCheckedModeBanner: false,
    //       title: 'Flutter Demo',
    //       theme: theme(),
    //       home: SplashScreen(),
    //
    //
    //       // We use routeName so that we dont need to remember the name
    //       // initialRoute: SplashScreen0.routeName,
    //       routes: routes,
    //     );
    //   }),
    //
    //
    // ));

  }



}






