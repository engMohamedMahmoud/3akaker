import 'package:flutter/material.dart';
import 'package:aakaker/size_config.dart';

import '../../constants.dart';
import 'components/body.dart';

class PhoneACCountScreen extends StatelessWidget {
  static String routeName = "/phoneAccount";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return

      WillPopScope(
        onWillPop: () async => false,
    child:

      Scaffold(
      appBar: AppBar(
        title: Text(""),
        backgroundColor: Kbg,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.transparent),
          // onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Body(),
      backgroundColor: Kbg,
    ));
  }
}


// if (userOtp == code){
//
// final navigator = Navigator.of(context);
// await navigator.push(
// MaterialPageRoute(
// builder: (context) =>
// SignUpScreen(phoneNumber: phoneNumber,),
// ),
// );
//
// }else{
// stopLoading();
// }