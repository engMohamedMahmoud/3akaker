import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../size_config.dart';
import 'body.dart';
import '../../profile/profile_screen.dart';


class RestUserPasswordScreen extends StatelessWidget {
  static String routeName = "/user_rest_password";
  final String phoneNumber;
  const RestUserPasswordScreen({Key key,this.phoneNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return
      WillPopScope(
        onWillPop: () => Future.value(false),
    child:
      Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder:
                      (BuildContext context) =>
                  new ProfileScreen())),
        ),
        centerTitle: true,
        title: Text(""),
        backgroundColor: Kbg,
      ),
      body: Body(phoneNumber:phoneNumber),
      backgroundColor: Kbg,
    ));
  }
}
