import 'package:flutter/material.dart';
import 'package:aakaker/screens/Empty_cart/body.dart';
import 'package:aakaker/size_config.dart';
import '../../constants.dart';

class EmptyCartScreen extends StatelessWidget {


  static String routeName = "/emptyCart";
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