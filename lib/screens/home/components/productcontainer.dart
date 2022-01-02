import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/helper/database_heloper/cart_model_product.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/cart/components/cart_view_model.dart';
import 'package:aakaker/screens/details/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_services/model.dart';
import 'package:http/http.dart' as http;


class ProductContainer extends StatefulWidget {
  final MyProduct product;

  const ProductContainer({Key key, @required this.product}) : super(key: key);
  @override
  _ProductContainerState createState() => _ProductContainerState(product);
}

class _ProductContainerState extends State<ProductContainer> {

  final MyProduct product;
  _ProductContainerState(this.product);


  int _count = 1;




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


    setState(() {
      getDeliveryCost();
    });


    super.initState();


  }



  @override
  Widget build(BuildContext context) {

    var appLanguage = Provider.of<AppLanguage>(context,listen: false);

    return GestureDetector(
      onTap: () =>
          Navigator.pushNamed(
        context,
        DetailsScreen.routeName,
        arguments: ProductDetailsArguments(product: product),
      ),


      child: Container(
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          color: Color.fromRGBO(246, 246, 248, 1.0),
          borderRadius: BorderRadius.circular(18.0),
          border: Border.all(color: Colors.blueAccent, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 5, right: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: kSecondaryColor.withOpacity(0.1),
                  // borderRadius: BorderRadius.circular(15),
                ),
                child:
                // (product.Type == "Medicine")?
                Hero(

                  tag: "image1 ${product.id}",
                  child:
                  Image.asset(
                    (product.Type == "Medicine")? "assets/images/Medicon.png" : "assets/images/cos.png",
                    height: 80,
                    width: 80.0,
                    // loadingBuilder:
                    //     (BuildContext context, Widget child,
                    //     ImageChunkEvent loadingProgress) {
                    //   if (loadingProgress == null) return child;
                    //   return Center(
                    //     child: CircularProgressIndicator(
                    //       value: loadingProgress.expectedTotalBytes != null
                    //           ? loadingProgress.cumulativeBytesLoaded /
                    //               loadingProgress.expectedTotalBytes
                    //           : null,
                    //     ),
                    //   );
                    // },
                  ),
                )
                    // :
                // Hero(
                //   tag: product.id+ "test" ,
                //   child:  Image.asset(
                //     "assets/images/cos.png",
                //     height: 80,
                //     width: 130.0,
                //     // loadingBuilder: (BuildContext context, Widget child,
                //     //     ImageChunkEvent loadingProgress) {
                //     //   if (loadingProgress == null) return child;
                //     //   return Center(
                //     //     child: CircularProgressIndicator(
                //     //       value: loadingProgress.expectedTotalBytes != null
                //     //           ? loadingProgress.cumulativeBytesLoaded /
                //     //           loadingProgress.expectedTotalBytes
                //     //           : null,
                //     //     ),
                //     //   );
                //     // },
                //   ),
                // ),
              ),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 5, bottom: 5,right: 10,left: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.circular(18),
                  // border: Border.fromBorderSide(top:1,)
                  borderRadius: new BorderRadius.only(
                    bottomLeft: const Radius.circular(18.0),
                    bottomRight: const Radius.circular(18.0),
                  )

                // color: Color.fromRGBO(246, 246, 248, 1.0),
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: appLanguage.appLocal.languageCode == "en"? Alignment.topLeft: Alignment.topRight,
                      child: Text(
                        // appLanguage.appLocal.languageCode == "en" ? "${product.NameEN.substring(0,25)}...." : "${product.NameAR.substring(0,25)}....",
                        appLanguage.appLocal.languageCode == "en" ? product.NameEN : product.NameAR,
                        // overflow: TextOverflow.ellipsis,
                        overflow: TextOverflow.fade,
                        maxLines: 1,
                        softWrap: false,
                        style: TextStyle(
                            color: KTextColor, fontWeight: FontWeight.bold),

                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${double.parse(product.Price.toStringAsFixed(2))}${AppLocalizations.of(context).translate("EGP")}",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                        Spacer(),
                        GetBuilder<CartViewModel>(
                          init: Get.find(),
                          builder: (controller) =>
                        InkWell(
                          splashColor: Colors.indigo,
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {

                          },

                          child:  GestureDetector(
                            onTap: () async {


                              // add to card

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
                                        count: _count)

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
                                      controller.increaseQuantity(index);
                                      break;
                                    }
                                  }


                                } else {
                                  print('Added!');
                                  controller.addProduct(
                                      CartProductModel(
                                          id: product.id,
                                          title: product.NameEN,
                                          image: (product.Type == "Medicine")? "assets/images/Medicon.png" : "assets/images/cos.png",
                                          titleAr: product.NameAR,
                                          type: product.Type,
                                          price: product.Price.toDouble(),
                                          count: _count));
                                }





                                print("product.id ${product.id}");
                              }


                            },
                            child: Container(
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  // border: Border.all(),
                                  color: Color.fromRGBO(160, 171, 255, 1.0)),
                              child: Icon(
                                Icons.add,
                                color: Colors.white,

                              ),
                            ),
                          ),

                        ),),
                      ],
                    )
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
