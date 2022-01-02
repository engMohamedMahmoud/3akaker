import 'package:flutter/material.dart';
import 'package:aakaker/size_config.dart';

import '../../../constants.dart';
import '../forgot_password_screen.dart';
import 'body_otp.dart';

class OtpForgetPasswordScreen extends StatelessWidget {
  static String routeName = "/otpForgetPassword";
  final String otp;
  final String phoneNumber;
  const OtpForgetPasswordScreen({Key key, this.otp,this.phoneNumber}) : super(key: key);
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
          onPressed: (){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder:
                        (BuildContext context) =>
                    new ForgotPasswordScreen()));
          },
        ),
        centerTitle: true,
        title: Text(""),
        backgroundColor: Kbg,
      ),
      body: Body(otp: otp,phoneNumber:phoneNumber),
      backgroundColor: Kbg,
    ));
  }
}