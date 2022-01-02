import 'dart:ui' as ui;

import 'package:aakaker/screens/otp/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/Phone_Account/phone_account_screen.dart';
import 'package:aakaker/screens/sign_in/sign_in_screen.dart';
import 'package:aakaker/size_config.dart';

// This is the best practice
import '../../../components/default_button.dart';


class Body extends StatefulWidget {

  Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body>   {



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage(
        'assets/images/welcome_illustration.png'); //<- Creates an object that fetches an image.
    var image = new Image(image: assetsImage, fit: BoxFit.cover);

    return

      WillPopScope(
        onWillPop: () async => false,
    child:
      SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: image,
                  height: 200,
                  margin: EdgeInsets.only(top: 45),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.01),
                SizedBox(height: getProportionateScreenHeight(40)),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    AppLocalizations.of(context).translate("helloPhrama"),
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        color: Color.fromRGBO(29, 35, 96, 1.0)),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    AppLocalizations.of(context).translate("searchforMedicne"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.03),
                DefaultButton(
                  text: AppLocalizations.of(context).translate("Login"),
                  press: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder:
                                (BuildContext context) =>
                            new SignInScreen()));
                  },
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                SecondButton(
                  text: AppLocalizations.of(context).translate("Register"),
                  press: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder:
                                (BuildContext context) =>
                            new PhoneACCountScreen()));


                  },
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
