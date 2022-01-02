import 'package:aakaker/localization/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aakaker/screens/cart/cart_screen.dart';
import 'package:aakaker/screens/cart/components/cart_view_model.dart';
import 'package:aakaker/screens/home/components/home_services/model.dart';
import 'package:aakaker/screens/home/components/icon_btn_with_counter.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import '../../constants.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = "/details";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message){
    try {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(

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
    final ProductDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    return
      WillPopScope(
        onWillPop: () => Future.value(false),
    child:
      Scaffold(
      key: _scaffoldKey,
      backgroundColor: KbackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pushNamed(context, HomeScreen.routeName),
        ),
        centerTitle: true,
        title: Text(
          "",
          style: TextStyle(color: kPrimaryColor),
        ),
        backgroundColor: KbackgroundColor,
        actions: <Widget>[
          // Padding(padding: EdgeInsets.only(top: 20),child: GetBuilder<CartViewModel>(init: Get.find(),builder: (controller) =>
          //     Container(
          //       padding: EdgeInsets.only(left: 10, right: 10),
          //       child: IconBtnWithCounter1(
          //         svgSrc: "assets/icons/white cart icon.svg",
          //         numOfitem: controller.numberOfList,
          //         press: () {
          //           if(controller.numberOfList > 0){
          //             Navigator.of(context).pushReplacement(
          //                 MaterialPageRoute(
          //                     builder:
          //                         (BuildContext context) =>
          //                     new CartScreen()));
          //           }else
          //           {
          //
          //             _showMessageInScaffold(AppLocalizations.of(context).translate("Cart is still empty"));
          //
          //           }
          //         },
          //
          //       ),),
          // ),),
          GetBuilder<CartViewModel>(
            init: Get.find(),
            builder: (controller) => Container(
              padding:
              EdgeInsets.only(left: 10, right: 10),
              child: IconBtnWithCounter0(
                  svgSrc:
                  "assets/icons/white cart icon.svg",
                  numOfitem: controller.numberOfList,
                  press: () {
                    print("controller.numberOfList ${controller.numberOfList}");


                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder:
                                (BuildContext context) =>
                            new CartScreen()));





                  }),
            ),
          ),
        ],
      ),
      body: Body(product: agrs.product),
    ));
  }
}

class ProductDetailsArguments {
  final MyProduct product;
  ProductDetailsArguments({@required this.product});
}
