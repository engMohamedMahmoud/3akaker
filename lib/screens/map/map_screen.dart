import 'package:flutter/material.dart';
import '../../size_config.dart';
import 'components/body.dart';

class MaptScreen extends StatelessWidget {


  static String routeName = "/map";
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return MyHomePage();

  }
}




