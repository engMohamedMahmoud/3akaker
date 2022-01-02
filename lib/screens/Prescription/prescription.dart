import 'package:flutter/material.dart';
import 'package:aakaker/components/coustom_bottom_nav_bar.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/enums.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'components/body.dart';

class PrescriptionScreen extends StatelessWidget {
  static String routeName = "/camera";
  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () => Future.value(false),
    child:
      Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.transparent
        ),
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("Prescription")),
        backgroundColor: KbackgroundColor,
      ),
      floatingActionButton: new FloatingActionButton(
        heroTag: "any",
        onPressed: (){},
        tooltip: 'Increment',
        child: SvgPicture.asset("assets/icons/Camera Icon.svg",color: Colors.white,),
        elevation: 4.0,
      ),
      body: UploadImagePrescsionPage(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.camera,isActiveButton: true,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: KbackgroundColor,
    ));
  }
}