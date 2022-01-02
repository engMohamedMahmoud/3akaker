import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../size_config.dart';
import 'body.dart';


class MapMainRoshataScreen extends StatelessWidget {


  static String routeName = "/mapMainRoahata";

  final File image;
  MapMainRoshataScreen({Key key, @required this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    return MyHomePage(image: image);

  }
}




