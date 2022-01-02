import 'package:flutter/material.dart';
import 'package:aakaker/components/coustom_bottom_nav_bar.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/enums.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aakaker/screens/Prescription/prescription.dart';
import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "/profile";
  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () => Future.value(false),
      child: Scaffold(
        body: Body(),
        floatingActionButton: new FloatingActionButton(
          onPressed: (){Navigator.pushNamed(context, PrescriptionScreen.routeName);},
          child: SvgPicture.asset("assets/icons/Camera Icon.svg",color: Colors.white,),
          elevation: 4.0,
        ),
        backgroundColor: KbackgroundColor,
        bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.profile),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),);
  }
}
