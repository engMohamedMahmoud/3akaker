import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:aakaker/screens/profile/components/body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'Body.dart';

class NamesScreen extends StatelessWidget {
  static String routeName = "/names";
  final String name;
  final String imageUrl;

  const NamesScreen({Key key, this.name, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return OfflineBuilder(
      connectivityBuilder: (
        BuildContext context,
        ConnectivityResult connectivity,
        Widget child,
      ) {
        if (connectivity == ConnectivityResult.none) {
          return BodyConnection();
        } else {
          return child;
        }
      },
      builder: (BuildContext context) {
        var appLanguage = Provider.of<AppLanguage>(context, listen: false);
        var assetsImage = new AssetImage(
            'assets/images/welcome_illustration.png'); //<- Creates an object that fetches an image.
        var image = new Image(image: assetsImage, fit: BoxFit.cover);
        return WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              // appBar: AppBar(
              //   title: Text(""),
              //   backgroundColor: Kbg,
              // ),
              body:

              SingleChildScrollView(
                child: Column(children: [
                  SizedBox(height: 60),


                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      // onTap: () => onProfileClick(context), // choose image on click of profile
                      child: Container(
                        margin: EdgeInsets.only(left: 20, right: 20),

                        child:
                        (imageUrl == null)? const ProfileUserDetailsWidget(): ClipRRect(
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.circular(50),
                          // ),
                          borderRadius: BorderRadius.circular(50),
                          child: Image.network(
                            imageUrl,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent
                            loadingProgress) {
                              if (loadingProgress == null)
                                return child;
                              return Container(
                                padding: EdgeInsets.all(10.0),
                                // decoration: new BoxDecoration(shape: BoxShape.circle,),

                                height: 100,
                                width: 100,
                                alignment:appLanguage.appLocal.languageCode == 'en'? Alignment.topLeft: Alignment.topRight,
                                child: CircularProgressIndicator(
                                  value: loadingProgress
                                      .expectedTotalBytes !=
                                      null
                                      ? loadingProgress
                                      .cumulativeBytesLoaded /
                                      loadingProgress
                                          .expectedTotalBytes
                                      : null,
                                ),
                              );
                            },
                          ),
                        ),
                      ),



                    ),
                  ),


                  SizedBox(height: 5),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        (name != "")? "$name" : "${AppLocalizations.of(context).translate("Hello Dear User")}",textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      )
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 20, right: 20,top: 20),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate("Select your pharmacy:"),
                      softWrap: true,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: KTextColor),
                    ),
                  ),

                  PharmaciesList(),
                  SizedBox(
                    height: 30,
                  ),
                ]),
              ),


              // backgroundColor: Kbg,
              backgroundColor: Colors.white,
            ));
      },
    );
  }
}
