import 'package:flutter/material.dart';
import 'package:aakaker/screens/Splash0/components/Body.dart';
import 'package:aakaker/size_config.dart';

import '../../constants.dart';

class SplashScreen0 extends StatelessWidget {


  static String routeName = "/splash0";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      body: SplashScreen(),
      backgroundColor: Kbg,
    );
  }
}