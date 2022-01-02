import 'package:flutter/material.dart';
import 'package:aakaker/components/default_button.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import 'package:aakaker/size_config.dart';

class Body extends StatelessWidget {

  Body({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: SizedBox(
        width: double.infinity,

        child: Center(

          child: SingleChildScrollView(

            child: Container(
              // margin: EdgeInsets.only(top: 100),
              alignment: Alignment.center,
              child: Column(

                children: [
                  Center(child: Image.asset("assets/icons/empty2.png",height: 200, width: 200,),),
                  Text(
                    AppLocalizations.of(context).translate("Basket Empty"),
                    style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20, color: Colors.black26),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Text(
                    AppLocalizations.of(context).translate("No Elements in basket"),
                    style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20, color: Colors.black26),
                  ),
                  SizedBox(height: getProportionateScreenHeight(15)),
                  Padding(
                    padding: EdgeInsets.only(left: 50, right: 50),
                    child: SecondButton(
                      text:  AppLocalizations.of(context).translate("Browse Medicines"),

                      press: () {
                        Navigator.pushNamed(context, HomeScreen.routeName);
                      },
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}

