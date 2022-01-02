import 'package:aakaker/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import '../../../constants.dart';
import 'Components/body.dart';

class OrdersScreen extends StatelessWidget {
  static String routeName = "/ordersList";

  final String id;
  const OrdersScreen({Key key,this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return
      WillPopScope(
        onWillPop: () => Future.value(false),
    child:
      Scaffold(
      backgroundColor: KbackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: (){
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) =>HomeScreen(),
              ),
                  (route) => false,//if you want to disable back feature set to false
            );
          }
          // onPressed: () => Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(
          //         builder:
          //             (BuildContext context) =>
          //         new HomeScreen())),
        ),
        title: Text(
          AppLocalizations.of(context).translate("Orders List"),
          style: TextStyle(color: kPrimaryColor),
        ),
        centerTitle: true,
        backgroundColor: KbackgroundColor,


      ),
      body: MyAppOrdersList(id),

    ));
  }
}

