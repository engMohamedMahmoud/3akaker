import 'package:aakaker/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/profile/profile_screen.dart';

import 'components/body.dart';

class MySettingsScreen extends StatelessWidget {
  static String routeName = "/settings";

  final String phoneNumber;
  final String email;
  final String firstName;
  final String lastName;
  const MySettingsScreen({Key key,this.phoneNumber, this.email, this.firstName, this.lastName}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return

      WillPopScope(
        onWillPop: () => Future.value(false),
    child:
      Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil<dynamic>(
              context,
              MaterialPageRoute<dynamic>(
                builder: (BuildContext context) =>HomeScreen(),
              ),
                  (route) => false,//if you want to disable back feature set to false
            );
          },
        ),
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("Settings"), style: TextStyle(color: Colors.indigo),),
        backgroundColor: KbackgroundColor,
      ),
      body: Body(phoneNumber:  phoneNumber, email: email, firstName: firstName, lastName: lastName),
      backgroundColor: KbackgroundColor,
    ));
  }
}
