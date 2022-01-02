import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:aakaker/components/coustom_bottom_nav_bar.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/cart/cart_screen.dart';
import 'package:aakaker/screens/cart/components/cart_view_model.dart';
import 'package:aakaker/screens/home/components/icon_btn_with_counter.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import '../../enums.dart';
import '../../size_config.dart';
import 'components/body.dart';

class SeeAllSearchScreen extends StatelessWidget {
  static String routeName = "/search";


  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message){
    try {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            // behavior: SnackBarBehavior.floating,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(15),
            // ),
            backgroundColor: myColor,
            content: Text(message,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
            duration: Duration(seconds: 2, milliseconds: 500),
          )
      );
    } on Exception catch (e, s) {
      print(s);
    }
  }


  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        onWillPop: () => Future.value(false),
    child:
      Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(


        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/bg1.jpg"),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              )),
          padding:
          EdgeInsets.only(top: getProportionateScreenWidth(30)),

        ),

        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder:
                      (BuildContext context) =>
                  new HomeScreen())),
        ),
        title: Text(AppLocalizations.of(context).translate("Search"), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        centerTitle: true,
        actions: <Widget>[
          Padding(padding: EdgeInsets.only(top: 10),child: GetBuilder<CartViewModel>(init: Get.find(),builder: (controller) =>
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconBtnWithCounter(
                  svgSrc: "assets/icons/white cart icon.svg",
                  numOfitem: controller.numberOfList,
                  press: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder:
                                (BuildContext context) =>
                            new CartScreen()));
                  },
                ),),
          ),)
        ],
        backgroundColor: Kbg,
      ),

      body: SearchBody(),
      // floatingActionButton: new FloatingActionButton(
      //   heroTag: "test",
      //   onPressed: (){Navigator.pushNamed(context, PrescriptionScreen.routeName);},
      //   child: SvgPicture.asset("assets/icons/Camera Icon.svg",color: Colors.white,),
      //   elevation: 4.0,
      // ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Kbg,
    ));
  }
}