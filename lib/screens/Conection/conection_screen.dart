import 'package:flutter/material.dart';
import 'package:aakaker/size_config.dart';
import '../../constants.dart';

class ConectionScreen extends StatelessWidget {


  static String routeName = "/connection";
  @override
  Widget build(BuildContext context) {
    // You have to call it on your starting screen
    SizeConfig().init(context);
    return Scaffold(
      // body: BodyConnection(),
      backgroundColor: Kbg,
    );
  }
}