import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aakaker/components/default_button.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/cart/components/cart_view_model.dart';
import 'package:aakaker/screens/map/map_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../../../constants.dart';
import '../../../size_config.dart';

class CheckoutCard extends StatefulWidget {
  CheckoutCard({
    Key key,
  }) : super(key: key);

  @override
  _CheckoutCardState createState() => _CheckoutCardState();
}

class _CheckoutCardState extends State<CheckoutCard> {





  double deliverCost = 0.0;
  double discountCost = 0.00;
  Future getDeliveryCost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse("https://alsaydaly.herokuapp.com/User/Shipping"),headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${prefs.getString("token")}"
    });


    if (response.statusCode == 200) {
      setState(() {

        var data = json.decode(response.body);
        double jsonResponse = double.parse(data);
        deliverCost = jsonResponse.toDouble();
        prefs.setDouble("shippingCost", deliverCost);


        print("max value : ${response.body}");

      });

    } else {
      throw Exception('Unexpected error occured!');
    }
  }




  @override
  void initState() {
    // getUserLocation();
    setState(() {
      getDeliveryCost();
    });
    // TODO: implement initState
    super.initState();




  }


  @override
  Widget build(BuildContext context) {
    return

      (deliverCost != 0)?

      Container(child: GetBuilder<CartViewModel>(
      init: Get.find(),
      builder: (controller) => Container(
          padding: EdgeInsets.symmetric(
            vertical: getProportionateScreenWidth(1),
            horizontal: getProportionateScreenWidth(20),
          ),
          height: 290,
          decoration: BoxDecoration(
            color: Kbg,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            // boxShadow: [
            //   BoxShadow(
            //     offset: Offset(0, -15),
            //     blurRadius: 20,
            //     color: Colors.white,
            //   )
            // ],
          ),
          child: Column(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)
                            .translate("Payment process summary"),
                        style: TextStyle(
                            color: KTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Spacer(),
                      Text("")
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context).translate("Totaled"),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      Spacer(),
                      GetBuilder<CartViewModel>(
                        init: Get.find(),
                        builder: (controller) => Text(
                          "${controller.totalPrice.toStringAsFixed(2)} ${AppLocalizations.of(context).translate("EGP")}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ),
                      Text("")
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)
                            .translate("Discontent"),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      Spacer(),
                      Text(
                        "${discountCost.toStringAsFixed(2)} ${AppLocalizations.of(context).translate("EGP")}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      Text("")
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)
                            .translate("deliveryOrder"),
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                      Spacer(),

                      GetBuilder<CartViewModel>(
                        init:Get.find(),
                        builder: (controller) => Text(
                          "${controller.shippingCost.toStringAsFixed(2)} ${AppLocalizations.of(context).translate("EGP")}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ),
                      // Text(
                      //   "${controller.shippingCost.toStringAsFixed(2)} ${AppLocalizations.of(context).translate("EGP")}",
                      //   style: TextStyle(
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.normal,
                      //       fontSize: 14),
                      // ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  Container(
                    // height: 70.0,
                      decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 0.5),
                          ))),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  Row(
                    children: [
                      Text(
                        // AppLocalizations.of(context).translate("Total"),
                        AppLocalizations.of(context)
                            .translate("TotalOrder"),
                        style: TextStyle(
                            color: KTextColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Spacer(),
                      Text(
                        "${controller.orderCost.toStringAsFixed(2)} ${AppLocalizations.of(context).translate("EGP")}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  DefaultButton(
                    text: AppLocalizations.of(context)
                        .translate("Pay to complete purchase"),
                    press: ()  async {

                      final navigator = Navigator.of(context);

                      await navigator.push(
                        MaterialPageRoute(
                          builder: (context) =>
                              MaptScreen(


                              ),
                        ),
                      );

                      // Navigator.of(context).pushReplacement(
                      //     MaterialPageRoute(
                      //         builder:
                      //             (BuildContext context) =>
                      //         new MaptScreen(
                      //         )));

                    },
                  ),



                ],
              ),
            ],
          )
      ),
    ),):
      Shimmer.fromColors(
          baseColor: Colors.black38,
          highlightColor: Colors.white,
          child: Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(right: 10,left: 10),
            child: Column(
              children: [

                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    // color: Color.fromRGBO(246, 246, 248, 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black45, width: 1.0),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    // color: Color.fromRGBO(246, 246, 248, 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black45, width: 1.0),
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    // color: Color.fromRGBO(246, 246, 248, 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black45, width: 1.0),
                  ),
                ),
                SizedBox(height: 10,),


              ],
            ),

            decoration: BoxDecoration(
              color: Colors.black12,
              // color: Color.fromRGBO(246, 246, 248, 1.0),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.black12, width: 1.0),
            ),
          ));
  }

  showAlertDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 5, right: 5),child:Text(AppLocalizations.of(context).translate("Wait....") )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

}
