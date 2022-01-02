import 'package:flutter/material.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/size_config.dart';

class BodyConnection extends StatelessWidget {

  BodyConnection({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/images/empty1.png'); //<- Creates an object that fetches an image.
    var image = new Image(image: assetsImage, fit: BoxFit.cover);

    return SafeArea(
      child: SizedBox(
        width: double.infinity,

        child: Center(
          // padding:
          // EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),

          child: SingleChildScrollView(

            child: Container(
              // margin: EdgeInsets.only(top: 100),
              alignment: Alignment.center,
              child: Column(

                children: [
                  Center(child: image,),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  SizedBox(height: getProportionateScreenHeight(40)),
                  Text(
                    AppLocalizations.of(context).translate("No interNet Connection"),
                    style: TextStyle(fontWeight: FontWeight.w900,fontSize: 20, color: Colors.black26),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}

