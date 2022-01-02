import 'package:flutter/material.dart';
import '../../../size_config.dart';
import 'change_user_password.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:flutter_offline/flutter_offline.dart';

class Body extends StatefulWidget {
  final String phoneNumber;
  Body({
    Key key,  this.phoneNumber
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState(phoneNumber);
}

class _BodyState extends State<Body>  {

  String userOtp;
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
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),

              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ChangeUserPasswordForm(phoneNumber: phoneNumber),
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