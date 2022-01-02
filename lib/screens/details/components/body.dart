import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:aakaker/screens/cart/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/helper/database_heloper/cart_model_product.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/cart/components/cart_view_model.dart';
import 'package:aakaker/screens/home/components/home_services/model.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import 'package:aakaker/size_config.dart';
import 'package:provider/provider.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'product_images.dart';
import 'top_rounded_container.dart';

class Body extends StatefulWidget {
  final MyProduct product;

  const Body({Key key, @required this.product}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(product);
}

class _BodyState extends State<Body> {

  MyProduct product;
  bool isHome = false;
  bool isCart = true;

  _BodyState(this.product);

  double priceCount = 0.0;
  // var dbHelper = CartDataBaseHelper.db;

  int _count = 1;
  List<CartProductModel> _cartProductModel = [];

  List<CartProductModel> get cartProductModel => _cartProductModel;

  bool _canShowButton = true;

  void hideWidget() {
    setState(() {
      _canShowButton = !_canShowButton;
    });
  }

  double deliverCost = 0.00;
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
    // TODO: implement initState
    setState(() {
      getDeliveryCost();
    });
    super.initState();

    // _connectivity.initialise();
    // _connectivity.myStream.listen((source) {
    //   setState(() => _source = source);
    // });
    // getAllProduct();
  }

  // _addItem(Product product) {
  //   setState(() {
  //     final item = new Item(id: product.id, title: product.NameEN, titleAr: product.NameAR, price: product.Price, image: product.Picture, count: _count);
  //     list.items.add(item);
  //     storage.setItem('key', list.toJSONEncodable());
  //   });
  // }

  // get all data from local storage list
  // getAllProduct() async {
  //   _cartProductModel = await dbHelper.getAllProduct();
  //
  // }

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context,listen: false);

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
        return Column(
          children: [
            ProductImages(product: product),
            Spacer(),
            TopRoundedContainer(
              color: Colors.white,
              child: Column(
                children: [
                  TopRoundedContainer(
                    child: Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenWidth(20)),
                              child: Column(
                                children: [
                                  Align(
                                    alignment:
                                    (appLanguage.appLocal.languageCode ==
                                        "en")
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    child: Text(
                                      appLanguage.appLocal.languageCode == "en"
                                          ? product.NameEN
                                          : product.NameAR,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: KTextColor),
                                    ),
                                  ),
                                  // Align(
                                  //   alignment: Alignment.topLeft,
                                  //   child: Row(
                                  //     children: <Widget>[
                                  //       Text(
                                  //         AppLocalizations.of(context)
                                  //             .translate("Made by "),
                                  //         textAlign: TextAlign.left,
                                  //         style: TextStyle(
                                  //             fontWeight: FontWeight.normal,
                                  //             fontSize: 15),
                                  //       ),
                                  //       Expanded(
                                  //           child: Text(
                                  //             appLanguage.appLocal.languageCode == "en"
                                  //                 ? product.NameEN
                                  //                 : product.NameAR,
                                  //             textDirection: TextDirection.ltr,
                                  //             textAlign:
                                  //             appLanguage.appLocal.languageCode ==
                                  //                 "en"
                                  //                 ? TextAlign.left
                                  //                 : TextAlign.right,
                                  //             style: TextStyle(
                                  //                 fontWeight: FontWeight.bold,
                                  //                 fontSize: 18,
                                  //                 color: KTextColor),
                                  //           ))
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${double.parse(product.Price.toStringAsFixed(2)) * _count} ${AppLocalizations.of(context).translate("EGP")}",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.red),
                                  ),
                                  Spacer(),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _count += 1;

                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(3.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(),
                                              color: Color.fromRGBO(
                                                  160, 171, 255, 1.0)),
                                          child: Icon(
                                            Icons.add,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 15.0),
                                      Text(
                                        "$_count",
                                        style: TextStyle(
                                            color: KTextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(width: 15.0),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (_count > 1) {
                                              _count -= 1;
                                            }
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(3.0),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(),
                                              color: Color.fromRGBO(
                                                  223, 227, 255, 1.0)),
                                          child: Icon(Icons.remove,
                                              color: Color.fromRGBO(
                                                  65, 87, 255, 1.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),


                        GetBuilder<CartViewModel>(
                            init: Get.find(),
                            builder: (controller) => Container(
                              // margin: EdgeInsets.only(bottom : 40),
                              padding: EdgeInsets.only(
                                  right: 20, left: 20, bottom: 20, top: 20),
                              child: SizedBox(
                                // padding: EdgeInsets.only(
                                //     right: 20, left: 20, bottom: 40, top: 10),
                                width: double.infinity,
                                height: getProportionateScreenHeight(56),
                                child: RaisedButton(
                                  splashColor: Colors.indigo,
                                  onPressed: () async {


                                    SharedPreferences prefs = await SharedPreferences.getInstance();

                                    controller.addDeliveryShipping(prefs.getDouble("shippingCost"));
                                    controller.getAllProduct();
                                    controller.getTotalPrice();
                                    print("controller.shippingCost: ${controller.shippingCost}");



                                    if (controller.cartProductModel.length == 0) {
                                      controller.addProduct(
                                          CartProductModel(
                                              id: product.id,
                                              title: product.NameEN,
                                              image: (product.Type == "Medicine")? "assets/images/Medicon.png" : "assets/images/cos.png",
                                              titleAr: product.NameAR,
                                              type: product.Type,
                                              price: product.Price.toDouble(),
                                              count: _count));

                                      showGeneralDialog(
                                        // barrierDismissible: false,
                                        context: context,
                                        barrierColor: Colors.black54, // space around dialog
                                        transitionDuration: Duration(milliseconds: 800),
                                        transitionBuilder: (context, a1, a2, child) {
                                          return ScaleTransition(
                                            scale: CurvedAnimation(
                                                parent: a1,
                                                curve: Curves.elasticOut,
                                                reverseCurve: Curves.easeOutCubic),
                                            child: CustomDialog( // our custom dialog
                                              title: AppLocalizations.of(context).translate("Congratulations"),
                                              content:
                                              AppLocalizations.of(context).translate("The product has been successfully added to the basket. Do you want to continue shopping or go to the basket ?"),
                                              positiveBtnText: AppLocalizations.of(context).translate("Cart"),
                                              negativeBtnText: AppLocalizations.of(context).translate("Continue"),
                                              positiveBtnPressed: () {
                                                // Do something here
                                                setState(() {
                                                  _count = 1;
                                                  Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                          builder:
                                                              (BuildContext context) =>
                                                          new CartScreen(
                                                          )));
                                                });
                                              },

                                            ),
                                          );
                                        },
                                        pageBuilder: (BuildContext context, Animation animation,
                                            Animation secondaryAnimation) {
                                          return null;
                                        },
                                      );

                                    }
                                    else {
                                      bool test = ((controller.cartProductModel.singleWhere((it) => it.id == product.id,
                                          orElse: () => null)) != null);


                                      print("status $test");
                                      if(test == true)  {

                                        print('Already exists!');
                                        for(int index = 0; index < controller.cartProductModel.length; index++){
                                          if(product.id == controller.cartProductModel[index].id){

                                            print("found");
                                            for(int c = 0; c < _count; c++){
                                              controller.increaseQuantity(index);
                                            }
                                            break;
                                          }
                                        }


                                      } else
                                        {
                                        print('Added!');
                                        controller.addProduct(
                                            CartProductModel(
                                                id: product.id,
                                                title: product.NameEN,
                                                type: product.Type,
                                                image: (product.Type == "Medicine")? "assets/images/Medicon.png" : "assets/images/cos.png",
                                                titleAr: product.NameAR,
                                                price: product.Price.toDouble(),
                                                count: _count));
                                      }



                                      showGeneralDialog(
                                        // barrierDismissible: false,
                                        context: context,
                                        barrierColor: Colors.black54, // space around dialog
                                        transitionDuration: Duration(milliseconds: 800),
                                        transitionBuilder: (context, a1, a2, child) {
                                          return ScaleTransition(
                                            scale: CurvedAnimation(
                                                parent: a1,
                                                curve: Curves.elasticOut,
                                                reverseCurve: Curves.easeOutCubic),
                                            child: CustomDialog( // our custom dialog
                                              title: AppLocalizations.of(context).translate("Congratulations"),
                                              content:
                                              AppLocalizations.of(context).translate("The product has been successfully added to the basket. Do you want to continue shopping or go to the basket ?"),
                                              positiveBtnText: AppLocalizations.of(context).translate("Cart"),
                                              negativeBtnText: AppLocalizations.of(context).translate("Continue"),
                                              positiveBtnPressed: () {
                                                // Do something here
                                                setState(() {
                                                  _count = 1;
                                                  Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                          builder:
                                                              (BuildContext context) =>
                                                          new CartScreen(
                                                          )));
                                                });
                                              },

                                            ),
                                          );
                                        },
                                        pageBuilder: (BuildContext context, Animation animation,
                                            Animation secondaryAnimation) {
                                          return null;
                                        },
                                      );


                                      print("product.id ${product.id}");
                                    }



                                    setState(() {
                                      _count = 1;
                                      // Navigator.of(context).pushReplacement(
                                      //     MaterialPageRoute(
                                      //         builder:
                                      //             (BuildContext context) =>
                                      //         new HomeScreen(
                                      //         )));






                                    });




                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(20)),
                                  color: Color.fromRGBO(65, 87, 255, 1.0),
                                  child: Text(
                                    AppLocalizations.of(context)
                                        .translate("Add To Cart"),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );


  }
}


class CustomDialog extends StatelessWidget {
  final String title, content, positiveBtnText, negativeBtnText;
  final GestureTapCallback positiveBtnPressed;

  CustomDialog({
    @required this.title,
    @required this.content,
    @required this.positiveBtnText,
    @required this.negativeBtnText,
    @required this.positiveBtnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(  // Bottom rectangular box
          margin: EdgeInsets.only(top: 40), // to push the box half way below circle
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.only(top: 60, left: 10, right: 10), // spacing inside the box
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(fontSize: 18,color: Colors.green,fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                content,
                style: TextStyle(fontSize: 16,color: Colors.grey,fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(

                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(right: 25,left: 25,bottom: 10,top: 10),
                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: Text(negativeBtnText,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),),
                    ),

                    onTap: () => Navigator.of(context).pop(),
                  ),
                  GestureDetector(
                    child:
                    Container(
                      padding: EdgeInsets.only(right: 25,left: 25,bottom: 10,top: 10),
                      margin: EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(child: Text(positiveBtnText,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),),
                    ),
                    
                    onTap: positiveBtnPressed,
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
        CircleAvatar( // Top Circle with icon
          maxRadius: 40.0,
          backgroundColor: Colors.transparent,
          child: Image.asset("assets/images/ok.png"),
        ),
      ],
    );
  }

}