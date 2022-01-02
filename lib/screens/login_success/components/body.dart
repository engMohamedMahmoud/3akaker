import 'package:flutter/material.dart';
import 'package:aakaker/components/default_button.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import 'package:aakaker/size_config.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:aakaker/screens/Conection/components/body.dart';

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
    // _connectivity.initialise();
    // _connectivity.myStream.listen((source) {
    //   setState(() => _source = source);
    // });
  }
  @override
  Widget build(BuildContext context) {
    var assetsImage = new AssetImage('assets/images/success.png'); //<- Creates an object that fetches an image.
    var image = new Image(image: assetsImage, fit: BoxFit.cover);

    return OfflineBuilder(
      connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
          ) {
        if (connectivity == ConnectivityResult.none) {
          return BodyConnection();
        }
        else {
          return child;
        }
      },
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            width: double.infinity,

            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),

              child: SingleChildScrollView(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(child: image,height: 300, margin: EdgeInsets.only(top: 10),),
                    SizedBox(height: SizeConfig.screenHeight * 0.02),



                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(AppLocalizations.of(context).translate("The purchase was completed successfully")
                        , textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w900, color: Color.fromRGBO(29, 35, 96, 1.0),  ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(AppLocalizations.of(context).translate("Your order will be delivered to the address")
                        , textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold,backgroundColor: Colors.white, ),
                      ),
                    ),

                    SizedBox(height: getProportionateScreenHeight(20)),
                    DefaultButton(

                      text: AppLocalizations.of(context).translate("Go back to Medicines List"),
                      press: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder:
                                    (BuildContext context) =>
                                new HomeScreen(
                                )));
                      },
                    ),

                    SizedBox(height: SizeConfig.screenHeight * 0.15),


                  ],
                ),
              ),
            ),
          ),
        );
      },
    );


  }


}