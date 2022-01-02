import 'package:flutter/material.dart';
import 'package:aakaker/size_config.dart';

import '../../constants.dart';
import 'components/body.dart';

class OtpScreen extends StatelessWidget {
  static String routeName = "/otp";
  final String otp;
  final String phoneNumber;
  const OtpScreen({Key key, this.otp,this.phoneNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Kbg,
      ),
      body: Body(otp: otp,phoneNumber:phoneNumber),
      backgroundColor: Kbg,
    );
  }
}
