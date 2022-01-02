import 'package:flutter/material.dart';

import 'components/body.dart';

class LoginSuccessScreen extends StatelessWidget {
  static String routeName = "/login_success";
  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () => Future.value(false),
    child:
      Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text(""),
      ),
      body: Body(),
    ));
  }
}
