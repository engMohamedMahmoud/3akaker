import 'package:flutter/material.dart';
import 'package:aakaker/components/no_account_text.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/forgot_password/components/forget_password.dart';
import 'package:aakaker/size_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import '../../../constants.dart';


class Body extends StatefulWidget {

  Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body>   {

  // Map _source = {ConnectivityResult.none: false};
  // MyConnectivity _connectivity = MyConnectivity.instance;

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
    var appLanguage = Provider.of<AppLanguage>(context);

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
              padding: EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Align(
                        alignment: appLanguage.appLocal.languageCode == 'en' ? Alignment.topLeft : Alignment.topRight,
                        child: Text(AppLocalizations.of(context).translate("Forgot Password"),style: headingStyle)
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    ForgetPasswordFormStep1(),
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    NoAccountText(),
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