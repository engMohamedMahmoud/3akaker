import 'package:flutter/material.dart';
import 'package:aakaker/constants.dart';
import '../../size_config.dart';
import 'components/body.dart';
import 'package:aakaker/localization/app_localizations.dart';


class PaymentScreen extends StatelessWidget {
  static String routeName = "/payment";


  final String city;
  final String street;
  final String building;
  final String floor;
  final String flatNumber;
  final String phone;
  final double lat;
  final double long;
  final double shippingCost;
  final String lengthItems;
  final String totalCost;
  const PaymentScreen({Key key, this.city,this.street, this.building,this.floor,this.flatNumber,this.phone, this.lat, this.long, this.shippingCost,this.lengthItems,this.totalCost}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: myColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text( AppLocalizations.of(context)
            .translate("Complete Purchase") ),
        centerTitle: true,
        backgroundColor: KbackgroundColor,
      ),
      body: Body(city: city,street: street, building: building,floor: floor,flatNumber: flatNumber,phone: phone, lat: lat, long: long,lengthItems: lengthItems,totalCost: totalCost,),
      backgroundColor: KbackgroundColor,
    );
  }
}
