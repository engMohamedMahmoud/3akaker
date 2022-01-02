import 'package:flutter/material.dart';

import '../../constants.dart';
import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  final String phoneNumber;
  const SignUpScreen({Key key,this.phoneNumber}) : super(key: key);

  static String routeName = "/sign_up";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black
        ),
        centerTitle: true,
        title: Text("",),
        backgroundColor: Kbg,
      ),
      body: Body(phoneNumber:phoneNumber),
      backgroundColor: Kbg,
    );
  }
}
