import 'dart:io';

import 'package:aakaker/screens/Prescription/prescription.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/localization/app_localizations.dart';

import 'components/body.dart';

class SendPrescriptionImageScreen extends StatelessWidget {

  final File image;
  SendPrescriptionImageScreen({Key key, @required this.image}) : super(key: key);

  static String routeName = "/send_prescription";
  @override
  Widget build(BuildContext context) {
    return

      WillPopScope(
        onWillPop: () => Future.value(false),
    child:
      Scaffold(
      appBar: AppBar(
        leading: BackButton(
            color: Colors.black,
          onPressed: (){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder:
                        (BuildContext context) =>
                    new PrescriptionScreen()));
          },
        ),
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("Send Prescription Image")),
        backgroundColor: KbackgroundColor,
      ),
      body: Body(image: image),
       // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.camera),
      backgroundColor: KbackgroundColor,
    ));
  }
}

