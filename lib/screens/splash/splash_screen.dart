import 'package:flutter/material.dart';
import 'package:aakaker/screens/splash/components/body.dart';
import 'package:aakaker/size_config.dart';
import '../../constants.dart';


class SplashScreen1 extends StatelessWidget {




  static String routeName = "/splash";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: Body(),
      backgroundColor: Kbg,
    );
  }
}
