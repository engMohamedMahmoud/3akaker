import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:aakaker/size_config.dart';

import 'settings_edit_profile.dart';

class Body extends StatefulWidget {
  final String phoneNumber;
  final String email;
  final String firstName;
  final String lastName;
  Body({
    Key key, this.phoneNumber, this.email, this.firstName, this.lastName
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState(phoneNumber, email, firstName, lastName);
}


class _BodyState extends State<Body>   {



  String phoneNumber;
  String email;
  String firstName;
  String lastName;
  _BodyState(this.phoneNumber, this.email, this.firstName, this.lastName);



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

                    SignUpForm(phoneNumber:  phoneNumber, email: email, firstName: firstName, lastName: lastName),
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

    return SafeArea(
      child: SizedBox(
        width: double.infinity,

        child: Padding(
          padding:
          EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(25)),

          child: SingleChildScrollView(

            child: Column(

              children: [

                SignUpForm(phoneNumber:  phoneNumber, email: email, firstName: firstName, lastName: lastName),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SizedBox(height: getProportionateScreenHeight(20)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
