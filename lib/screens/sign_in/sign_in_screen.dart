import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../../constants.dart';
import '../../size_config.dart';
import 'components/body.dart';

class SignInScreen extends StatelessWidget {
  static String routeName = "/sign_in";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return




    OfflineBuilder(
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
        return WillPopScope(
            onWillPop: () async => false,
            child:
            Scaffold(
              // appBar: AppBar(
              //   title: Text(""),
              //   backgroundColor: Kbg,
              // ),
              body: Body(),
              backgroundColor: Kbg,
            ));;
      },
    );

  }
}
