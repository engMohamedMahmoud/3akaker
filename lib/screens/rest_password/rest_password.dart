import 'package:aakaker/screens/sign_in/sign_in_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class RestPasswordScreen extends StatelessWidget {
  static String routeName = "/rest_password";
  final String phoneNumber;
  const RestPasswordScreen({Key key,this.phoneNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return
      WillPopScope(
        onWillPop: () async => false,
    child:
      Scaffold(
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
      body: Body(phoneNumber:phoneNumber),
      backgroundColor: Kbg,
    ));
  }
}
