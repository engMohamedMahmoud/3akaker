import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/components/default_button.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/send_prescision_image/Roshata_Map/Main/mainScreenHome.dart';
import 'package:aakaker/size_config.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:aakaker/screens/Conection/components/body.dart';

class Body extends StatefulWidget {
  final File image;
  Body({
    Key key, this.image

  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState(image);
}

class _BodyState extends State<Body>   {
  File image;

  _BodyState(this.image);


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
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Image.file(
                        image,
                        // width: 100,
                        height: SizeConfig.screenHeight * 0.7,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.05),
                    DefaultButton(
                      text: AppLocalizations.of(context)
                          .translate("Send Prescription Image"),
                      press: () async {
                        if (image != null) {
                          final navigator = Navigator.of(context);
                          await navigator.push(
                            MaterialPageRoute(
                              builder: (context) => MapMainRoshataScreen(
                                image: image,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    SizedBox(height: getProportionateScreenHeight(20)),
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
