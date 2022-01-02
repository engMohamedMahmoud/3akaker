import 'dart:io';

import 'package:flutter/material.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/send_prescision_image/Roshata_Map/Details/roshataDetailsMap1.dart';



class MapDetailsRoshataScreen extends StatelessWidget {
  static String routeName = "/map_detailsRoshata";
  @override
  final  List<String> addreessDetails;
  final File image;
  final double lat;
  final double long;
  const MapDetailsRoshataScreen({Key key, this.addreessDetails, this.image, this.lat, this.long}) : super(key: key);

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("Address Details")),
        backgroundColor: KbackgroundColor,
      ),
      body: MyHomePage(details: addreessDetails, image: image, lat : lat,long:long),
      backgroundColor: KbackgroundColor,
    );
  }
}
