import 'package:aakaker/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";

  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {

    return
      WillPopScope(
        onWillPop: () async => false,
    child:
      Scaffold(
        key: globalScaffoldKey,
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black,
          onPressed:()=> Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder:
                      (BuildContext context) =>
                  new SignInScreen())),
        ),
        centerTitle: true,
        title: Text(""),
        backgroundColor: Kbg,
      ),
      body: Body(),
      backgroundColor: Kbg,
    ));
  }
}
