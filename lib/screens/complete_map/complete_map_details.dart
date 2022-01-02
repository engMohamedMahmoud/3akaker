import 'package:flutter/material.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'components/body.dart';


class MapDetailsScreen extends StatelessWidget {
  static String routeName = "/map_details";
  @override
  final  List<String> addreessDetails;
  final double lat;
  final double long;
  final String street;
  final String city;
  const MapDetailsScreen({Key key, this.addreessDetails, this.lat, this.long, this.street, this.city}) : super(key: key);

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black
        ),
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("Address Details")),
        backgroundColor: KbackgroundColor,
      ),
      body: MyHomePage(details: addreessDetails, lat: lat, long: long, street: street, city: city ),
      backgroundColor: KbackgroundColor,
    );
  }
}
