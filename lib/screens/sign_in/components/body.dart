import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/components/no_account_text.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../../size_config.dart';
import 'sign_form.dart';

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
                    SizedBox(height: SizeConfig.screenHeight * 0.04),
                    SignForm(),
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
