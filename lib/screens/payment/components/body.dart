import 'dart:async';
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:aakaker/screens/cart/components/cart_view_model.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import 'package:aakaker/screens/login_success/login_success_screen.dart';
import 'package:aakaker/size_config.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  final String city;
  final String street;
  final String building;
  final String floor;
  final String flatNumber;
  final String phone;
  final double lat;
  final double long;
  final String lengthItems;
  final String totalCost;

  Body(
      {Key key,
      this.city,
      this.street,
      this.building,
      this.floor,
      this.flatNumber,
      this.phone,
      this.lat,
      this.long,
      this.lengthItems,
        this.totalCost
      })
      : super(key: key);

  @override
  _BodyState createState() =>
      _BodyState(city, street, building, floor, flatNumber, phone, lat, long,lengthItems,totalCost);
}

enum PaymentOptions { Cash, Credit }

class _BodyState extends State<Body> {
  String city;
  String street;
  String building;
  String floor;
  String flatNumber;
  String phone;
  double lat;
  double long;
  final String lengthItems;
  final String totalCost;

  _BodyState(this.city, this.street, this.building, this.floor, this.flatNumber,
      this.phone, this.lat, this.long,this.lengthItems,this.totalCost);

  PaymentOptions opton = PaymentOptions.Cash;

  int _groupValue = -1;
  PaymentOptions method = PaymentOptions.Credit;
  String imagUrl;
  String name;



  String userId;
  String token;
  String _result = '---';
  bool _allow = true;



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
        userId = prefs.getString("_id");
        print("max value : ${response.body}");
      });
    } else {
      throw Exception('Unexpected error occured!');
    }
  }


  @override
  void initState() {
    setState(() {
      getDeliveryCost();
    });
    super.initState();
    // _connectivity.initialise();
    // _connectivity.myStream.listen((source) {
    //   setState(() => _source = source);
    // });
  }





  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context, listen: false);

    return OfflineBuilder(
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
        return new WillPopScope(
            onWillPop: () {
              return Future.value(false); // if true allow back else block it
            },
            child:SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(25)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.02),
                    Container(
                      child: Column(
                        children: [
                          GetBuilder<CartViewModel>(
                              init: Get.find(),
                              builder: (controller) =>

                                  deliverCost != 0?
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      border: Border.all(
                                          color: Colors.grey, width: 1.0),
                                    ),
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "$lengthItems ${AppLocalizations.of(context).translate("Items in basket")}",
                                            style: TextStyle(
                                                color: Colors.black38,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Spacer(),
                                        FlatButton(
                                            // onPressed: () => navigateToLogin(context),
                                            onPressed: () {


                                              Navigator.of(context).pushReplacement(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (BuildContext context) =>
                                                      new HomeScreen(
                                                      )));

                                            },
                                            // color: Kbg,

                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(0)),
                                            child: Column(
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                    AppLocalizations.of(context)
                                                        .translate("Total"),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black38)),
                                                Text(
                                                    " $totalCost ${AppLocalizations.of(context).translate("EGP")}",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: KTextColor)),
                                                // Spacer(),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ):
                                  Shimmer.fromColors(
                                      baseColor: Colors.black38,
                                      highlightColor: Colors.white,
                                      child: Container(
                                        height: 100,
                                        width: MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(right: 10,left: 10),

                                        child: Column(
                                          children: [

                                            Padding(padding: EdgeInsets.all(20),child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black45,
                                                    // color: Color.fromRGBO(246, 246, 248, 1.0),
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    border: Border.all(color: Colors.black45, width: 1.0),
                                                  ),
                                                ),

                                                Container(
                                                  height: 50,
                                                  width: 50,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black45,
                                                    // color: Color.fromRGBO(246, 246, 248, 1.0),
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    border: Border.all(color: Colors.black45, width: 1.0),
                                                  ),
                                                ),
                                              ],
                                            ),),
                                          ],
                                        ),

                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          // color: Color.fromRGBO(246, 246, 248, 1.0),
                                          borderRadius: BorderRadius.circular(8.0),
                                          border: Border.all(
                                              color: Colors.grey, width: 1.0),
                                        ),
                                      ))
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          deliverCost != 0?
                          Align(
                              alignment:
                                  appLanguage.appLocal.languageCode == "en"
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                              child: Text(
                                  AppLocalizations.of(context)
                                      .translate("Payment Methods"),
                                  style: TextStyle(
                                      color: KTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18))):
                          Shimmer.fromColors(
                              baseColor: Colors.black38,
                              highlightColor: Colors.white,
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(right: 10,left: 10,bottom: 30),



                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  // color: Color.fromRGBO(246, 246, 248, 1.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                ),
                              )),
                          deliverCost != 0?
                          Container(
                            alignment: Alignment.topLeft,
                            // padding: const EdgeInsets.all(18.0),
                            margin: EdgeInsets.only(top: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border:
                                  Border.all(color: Colors.grey, width: 1.0),
                            ),

                            child: Column(
                              children: <Widget>[
                                // ListTile(
                                //   title: Row(
                                //     children: <Widget>[
                                //       Text(
                                //           AppLocalizations.of(context)
                                //               .translate("Credit Card"),
                                //           style: TextStyle(color: KTextColor)),
                                //
                                //       // SizedBox(width: 8),
                                //
                                //       Spacer(),
                                //
                                //
                                //
                                //       Container(
                                //         padding: EdgeInsets.all(5),
                                //         decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(10),
                                //             border: Border.all(
                                //                 color: Colors.grey,
                                //                 width: 1.0)),
                                //         child: Image.asset(
                                //           "assets/icons/mastercard.png",
                                //           width: 20,
                                //           height: 20,
                                //         ),
                                //       )
                                //
                                //       // Spacer(),
                                //     ],
                                //   ),
                                //   leading: Radio(
                                //     value: PaymentOptions.Credit,
                                //     groupValue: opton,
                                //     onChanged: (PaymentOptions value) {
                                //       setState(() {
                                //         opton = value;
                                //         _groupValue = 0;
                                //       });
                                //     },
                                //   ),
                                // ),
                                ListTile(
                                  title: Row(
                                    children: <Widget>[
                                      Text(
                                        AppLocalizations.of(context)
                                            .translate("Cash"),
                                        style: TextStyle(color: KTextColor),
                                      ),
                                      Spacer(),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.grey,
                                                width: 1.0)),
                                        child: SvgPicture.asset(
                                          "assets/icons/cash-payment.svg",
                                          width: 20,
                                          height: 20,
                                        ),
                                      )
                                    ],
                                  ),
                                  leading: Radio(
                                    value: PaymentOptions.Cash,
                                    groupValue: opton,
                                    onChanged: (PaymentOptions value) {
                                      setState(() {
                                        opton = value;
                                        _groupValue = 0;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ):
                          Shimmer.fromColors(
                              baseColor: Colors.black38,
                              highlightColor: Colors.white,
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(right: 10,left: 10),

                                child: Column(
                                  children: [

                                    Padding(padding: EdgeInsets.all(20),child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.black45,
                                            // color: Color.fromRGBO(246, 246, 248, 1.0),
                                            borderRadius: BorderRadius.circular(8.0),
                                            border: Border.all(color: Colors.black45, width: 1.0),
                                          ),
                                        ),

                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.black45,
                                            // color: Color.fromRGBO(246, 246, 248, 1.0),
                                            borderRadius: BorderRadius.circular(8.0),
                                            border: Border.all(color: Colors.black45, width: 1.0),
                                          ),
                                        ),

                                        Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.black45,
                                            // color: Color.fromRGBO(246, 246, 248, 1.0),
                                            borderRadius: BorderRadius.circular(8.0),
                                            border: Border.all(color: Colors.black45, width: 1.0),
                                          ),
                                        ),
                                      ],
                                    ),),
                                  ],
                                ),

                                decoration: BoxDecoration(
                                  color: Colors.black12,
                                  // color: Color.fromRGBO(246, 246, 248, 1.0),
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      color: Colors.grey, width: 1.0),
                                ),
                              )),
                          SizedBox(height: getProportionateScreenHeight(60)),

                          GetBuilder<CartViewModel>(
                            init: Get.find(),
                            builder: (controller) =>

                            deliverCost != 0? ArgonButton(
                              height: 50,
                              roundLoadingShape: true,
                              width: MediaQuery.of(context).size.width * 0.9,
                              onTap:
                                  (startLoading, stopLoading, btnState) async {
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                if (btnState == ButtonState.Idle) {
                                  print("opton $opton");
                                  startLoading();
                                  if (opton == PaymentOptions.Cash) {
                                    // showAlertDialog(context);






                                    List<ReOrderApi> list = [];
                                    for (int i = 0; i < controller.cartProductModel.length; i++) {
                                      ReOrderApi customObject = ReOrderApi(
                                        id: controller.cartProductModel[i].id,
                                        price:
                                        controller.cartProductModel[i].price.round().toInt(),
                                        NameAR: controller.cartProductModel[i].titleAr,
                                        NameEN: controller.cartProductModel[i].title,
                                        Type: controller.cartProductModel[i].type,
                                        orderCount:
                                        controller.cartProductModel[i].count,
                                      );
                                      list.add(customObject);
                                    }

                                    String items = jsonEncode(list);

                                    Map address = {
                                      "City": city,
                                      "Street": street,
                                      "Building": building,
                                      "Floor": floor,
                                      "FlatNo": flatNumber,
                                      "Number": phone,
                                      "Lat": lat,
                                      "Long": long
                                    };

                                    var add = JsonEncoder().convert(address);

                                    // showAlertDialog(context);
                                    // var appLanguage = Provider.of<AppLanguage>(context);
                                    final String apiUrl = "$url/Payment/Add";

                                    // Map<String, String> headers = {
                                    //   'Content-type': 'application/json',
                                    // };








                                    final response = await http.post(apiUrl, body: {
                                      "TotalPrice":
                                      controller.totalPrice.toString(),
                                      "Shipping": "$deliverCost",
                                      "DeliveryAddress": add,
                                      "Products": items,
                                      "PaymentType": "Cash",
                                      "UserID": userId,
                                      "Pharmacy": prefs.getString('Pharmacy'),
                                      "Language": appLanguage
                                          .appLocal.languageCode
                                          .toUpperCase()
                                    },headers: {"authorization":prefs.getString('token')});

                                    print("====");
                                    print("Products: $items");
                                    print(prefs.getString('Pharmacy'));
                                    print(response.statusCode);
                                    print("=====");

                                    try {
                                      if (response.statusCode == 200) {
                                        stopLoading();
                                        int index = 0;
                                        while (index < controller.cartProductModel.length) {
                                          // controller.deleteItem(index);
                                          print("$index - ${controller.cartProductModel[index].titleAr}");
                                          controller.deleteItem(index);

                                          index++;
                                        }
                                        controller.cartProductModel.clear();
                                        controller.numberOfList = 0;

                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                new LoginSuccessScreen(
                                                )));

                                      } else {
                                        stopLoading();
                                        Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                                      }
                                    } catch (err) {
                                      stopLoading();
                                    }

                                    // try {
                                    //   if (response.statusCode == 200) {
                                    //     // for (int index = 0; index < controller.cartProductModel.length; index++){
                                    //     //   controller.deleteItem1(index);
                                    //     //   // controller.cartProductModel.clear();
                                    //     //   // controller.cartProductModel.removeAt(index);
                                    //     //   print(index);
                                    //     //
                                    //     // }
                                    //     stopLoading();
                                    //     controller.numberOfList = 0;
                                    //     int index = 0;
                                    //     while (index <
                                    //         controller.cartProductModel.length) {
                                    //       // controller.deleteItem(index);
                                    //       print(
                                    //           "$index - ${controller.cartProductModel[index].titleAr}");
                                    //       controller.deleteItem(index);
                                    //
                                    //       index++;
                                    //     }
                                    //     controller.cartProductModel.clear();
                                    //
                                    //
                                    //     Navigator.of(context).pushReplacement(
                                    //         MaterialPageRoute(
                                    //             builder:
                                    //                 (BuildContext context) =>
                                    //             new LoginSuccessScreen(
                                    //             )));
                                    //   } else {
                                    //     stopLoading();
                                    //     Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                                    //
                                    //   }
                                    // } catch (err) {
                                    //   stopLoading();
                                    // }
                                  }

                                  // if (opton == PaymentOptions.Credit) {
                                  //
                                  //   print(opton);
                                  //
                                  //   List<ReOrderApi> list = [];
                                  //   for (int i = 0;
                                  //   i < controller.cartProductModel.length;
                                  //   i++) {
                                  //     ReOrderApi customObject = ReOrderApi(
                                  //       id: controller.cartProductModel[i].id,
                                  //       price:
                                  //       controller.cartProductModel[i].price.round().toInt(),
                                  //       orderCount:
                                  //       controller.cartProductModel[i].count,
                                  //     );
                                  //     list.add(customObject);
                                  //   }
                                  //
                                  //   String items = jsonEncode(list);
                                  //
                                  //   Map address = {
                                  //     "City": city,
                                  //     "Street": street,
                                  //     "Building": building,
                                  //     "Floor": floor,
                                  //     "FlatNo": flatNumber,
                                  //     "Number": phone,
                                  //     "Lat": lat,
                                  //     "Long": long
                                  //   };
                                  //
                                  //   var add = JsonEncoder().convert(address);
                                  //
                                  //   // showAlertDialog(context);
                                  //
                                  //   final String apiUrl = "$url/Payment/Add";
                                  //
                                  //   // Map<String, String> headers = {
                                  //   //   'Content-type': 'application/json',
                                  //   // };
                                  //
                                  //
                                  //   final response =
                                  //   await http.post(apiUrl, body: {
                                  //     "TotalPrice":
                                  //     controller.totalPrice.toString(),
                                  //     "Shipping": "$deliverCost",
                                  //     "DeliveryAddress": add,
                                  //     "Products": items,
                                  //     "PaymentType": "Credit",
                                  //     "PaymentMethod": "Visa",
                                  //     "UserID": userId,
                                  //     "Language": appLanguage
                                  //         .appLocal.languageCode
                                  //         .toUpperCase()
                                  //   },headers: {"authorization":prefs.getString('token')});
                                  //
                                  //   try {
                                  //     if (response.statusCode == 200) {
                                  //       stopLoading();
                                  //       int index = 0;
                                  //       while (index < controller.cartProductModel.length) {
                                  //         // controller.deleteItem(index);
                                  //         print("$index - ${controller.cartProductModel[index].titleAr}");
                                  //         controller.deleteItem(index);
                                  //
                                  //         index++;
                                  //       }
                                  //       controller.cartProductModel.clear();
                                  //       controller.numberOfList = 0;
                                  //
                                  //       Navigator.of(context).pushReplacement(
                                  //           MaterialPageRoute(
                                  //               builder:
                                  //                   (BuildContext context) =>
                                  //               new LoginSuccessScreen(
                                  //               )));
                                  //
                                  //     } else {
                                  //       stopLoading();
                                  //       Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                                  //     }
                                  //   } catch (err) {
                                  //     stopLoading();
                                  //   }
                                  // }
                                  // else
                                  //
                                  //   if (opton == PaymentOptions.Cash) {
                                  //   // showAlertDialog(context);
                                  //
                                  //
                                  //
                                  //
                                  //
                                  //
                                  //   List<ReOrderApi> list = [];
                                  //   for (int i = 0; i < controller.cartProductModel.length; i++) {
                                  //     ReOrderApi customObject = ReOrderApi(
                                  //       id: controller.cartProductModel[i].id,
                                  //       price:
                                  //       controller.cartProductModel[i].price.round().toInt(),
                                  //       NameAR: controller.cartProductModel[i].titleAr,
                                  //       NameEN: controller.cartProductModel[i].title,
                                  //       Type: controller.cartProductModel[i].type,
                                  //       orderCount:
                                  //       controller.cartProductModel[i].count,
                                  //     );
                                  //     list.add(customObject);
                                  //   }
                                  //
                                  //   String items = jsonEncode(list);
                                  //
                                  //   Map address = {
                                  //     "City": city,
                                  //     "Street": street,
                                  //     "Building": building,
                                  //     "Floor": floor,
                                  //     "FlatNo": flatNumber,
                                  //     "Number": phone,
                                  //     "Lat": lat,
                                  //     "Long": long
                                  //   };
                                  //
                                  //   var add = JsonEncoder().convert(address);
                                  //
                                  //   // showAlertDialog(context);
                                  //   // var appLanguage = Provider.of<AppLanguage>(context);
                                  //   final String apiUrl = "$url/Payment/Add";
                                  //
                                  //   // Map<String, String> headers = {
                                  //   //   'Content-type': 'application/json',
                                  //   // };
                                  //
                                  //
                                  //
                                  //   print("Products: $items");
                                  //   print(deliverCost);
                                  //   print(add);
                                  //   print(controller.totalPrice.toString());
                                  //   print(prefs.getString('token'));
                                  //
                                  //
                                  //
                                  //
                                  //
                                  //   final response =
                                  //   await http.post(apiUrl, body: {
                                  //     "TotalPrice":
                                  //     controller.totalPrice.toString(),
                                  //     "Shipping": "$deliverCost",
                                  //     "DeliveryAddress": add,
                                  //     "Products": items,
                                  //     "PaymentType": "Cash",
                                  //     "UserID": userId,
                                  //     "Language": appLanguage
                                  //         .appLocal.languageCode
                                  //         .toUpperCase()
                                  //   },headers: {"authorization":prefs.getString('token')});
                                  //
                                  //   print("====");
                                  //   print("Products: $items");
                                  //   print("=====");
                                  //
                                  //   try {
                                  //     if (response.statusCode == 200) {
                                  //       stopLoading();
                                  //       int index = 0;
                                  //       while (index < controller.cartProductModel.length) {
                                  //         // controller.deleteItem(index);
                                  //         print("$index - ${controller.cartProductModel[index].titleAr}");
                                  //         controller.deleteItem(index);
                                  //
                                  //         index++;
                                  //       }
                                  //       controller.cartProductModel.clear();
                                  //       controller.numberOfList = 0;
                                  //
                                  //       Navigator.of(context).pushReplacement(
                                  //           MaterialPageRoute(
                                  //               builder:
                                  //                   (BuildContext context) =>
                                  //               new LoginSuccessScreen(
                                  //               )));
                                  //
                                  //     } else {
                                  //       stopLoading();
                                  //       Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                                  //     }
                                  //   } catch (err) {
                                  //     stopLoading();
                                  //   }
                                  //
                                  //   // try {
                                  //   //   if (response.statusCode == 200) {
                                  //   //     // for (int index = 0; index < controller.cartProductModel.length; index++){
                                  //   //     //   controller.deleteItem1(index);
                                  //   //     //   // controller.cartProductModel.clear();
                                  //   //     //   // controller.cartProductModel.removeAt(index);
                                  //   //     //   print(index);
                                  //   //     //
                                  //   //     // }
                                  //   //     stopLoading();
                                  //   //     controller.numberOfList = 0;
                                  //   //     int index = 0;
                                  //   //     while (index <
                                  //   //         controller.cartProductModel.length) {
                                  //   //       // controller.deleteItem(index);
                                  //   //       print(
                                  //   //           "$index - ${controller.cartProductModel[index].titleAr}");
                                  //   //       controller.deleteItem(index);
                                  //   //
                                  //   //       index++;
                                  //   //     }
                                  //   //     controller.cartProductModel.clear();
                                  //   //
                                  //   //
                                  //   //     Navigator.of(context).pushReplacement(
                                  //   //         MaterialPageRoute(
                                  //   //             builder:
                                  //   //                 (BuildContext context) =>
                                  //   //             new LoginSuccessScreen(
                                  //   //             )));
                                  //   //   } else {
                                  //   //     stopLoading();
                                  //   //     Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                                  //   //
                                  //   //   }
                                  //   // } catch (err) {
                                  //   //   stopLoading();
                                  //   // }
                                  // }

                                }


                              },
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("Pay Now"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              loader: Container(
                                padding: EdgeInsets.all(10),
                                child: SpinKitRotatingCircle(
                                  color: Colors.white,
                                  // size: loaderWidth ,
                                ),
                              ),
                              borderRadius: 5.0,
                              color: kPrimaryColor,
                            ):Shimmer.fromColors(
                                baseColor: Colors.black38,
                                highlightColor: Colors.white,
                                child: Container(
                                  height: 80,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(right: 10,left: 10),



                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    // color: Color.fromRGBO(246, 246, 248, 1.0),
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(
                                        color: Colors.grey, width: 1.0),
                                  ),
                                )),


                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    SizedBox(height: getProportionateScreenHeight(20)),
                  ],
                ),
              ),
            ),
          ),
        ));
      },
    );
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(
      value: value,
      onChanged: onChanged,
      title: Text(title,
          style: TextStyle(color: KTextColor, fontWeight: FontWeight.w900)),
      groupValue: _groupValue,
    );
  }
}

// class ReOrderApi {
//
//   final String id;
//   final int OrderCount;
//   final int Price;
//
//   ReOrderApi({this.id, this.Price, this.OrderCount,});
//
//   ReOrderApi.fromJson(Map<dynamic, dynamic> json)
//       : this.id = json["_id"],
//         this.OrderCount = json["OrderCount"],
//         this.Price = json["Price"];
//
//
// }

class ReOrderApi {
  final String id;
  final int price;
  final int orderCount;
  final String NameEN;
  final String NameAR;
  final String Type;


  ReOrderApi({
    this.id,
    this.price,
    this.orderCount,
    this.NameEN,
    this.NameAR,
    this.Type
  });

  ReOrderApi.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        price = json['Price'],
        NameEN = json['NameEN'],
        NameAR = json['NameAR'],
        orderCount = json['OrderCount'],
        Type = json['Type'];

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "Price": price,
      "NameEN":NameEN,
      "NameAR":NameAR,
      "OrderCount": orderCount,
      "Type":Type
    };
  }
}

// To parse this JSON data, do
//
//     final address = addressFromMap(jsonString);

Address addressFromMap(String str) => Address.fromMap(json.decode(str));

String addressToMap(Address data) => json.encode(data.toMap());

class Address {
  Address({
    this.city,
    this.street,
    this.building,
    this.floor,
    this.flatNo,
    this.number,
    this.lat,
    this.long,
  });

  String city;
  String street;
  String building;
  String floor;
  String flatNo;
  String number;
  double lat;
  double long;

  factory Address.fromMap(Map<String, dynamic> json) => Address(
        city: json["City"],
        street: json["Street"],
        building: json["Building"],
        floor: json["Floor"],
        flatNo: json["FlatNo"],
        number: json["Number"],
        lat: json["Lat"].toDouble(),
        long: json["Long"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "City": city,
        "Street": street,
        "Building": building,
        "Floor": floor,
        "FlatNo": flatNo,
        "Number": number,
        "Lat": lat,
        "Long": long,
      };
}
