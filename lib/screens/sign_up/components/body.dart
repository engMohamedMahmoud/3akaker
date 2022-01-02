import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/size_config.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'sign_up_form.dart';

class Body extends StatefulWidget {
  final String phoneNumber;
  Body({
    Key key, this.phoneNumber
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState(phoneNumber);
}


class _BodyState extends State<Body>   {





  String phoneNumber;
  _BodyState(this.phoneNumber);

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
              padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),

              child: SingleChildScrollView(

                child: Column(

                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    SignUpForm(phoneNumber: phoneNumber),
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
