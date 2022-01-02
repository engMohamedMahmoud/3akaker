import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/cart/components/cart_view_model.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import 'package:aakaker/screens/cart/components/check_out_card.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:aakaker/screens/Conection/components/body.dart';


class Body extends StatefulWidget {
  Body({
    Key key
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // int _count = 1;
  var textController = TextEditingController();

  // Map _source = {ConnectivityResult.none: false};
  // MyConnectivity _connectivity = MyConnectivity.instance;

  double deliverCost = 10.00;
  double discountCost = 0.00;


  @override
  void initState() {
    // TODO: implement initState
    // TODO: implement initState
    setState(() {});
    super.initState();
    // _connectivity.initialise();
    // _connectivity.myStream.listen((source) {
    //   setState(() => _source = source);
    // });
  }

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
        return SingleChildScrollView( // <- added
          child: Column(
            children: <Widget>[
              myBody(),
              CheckoutCard()
            ],
          ),
        );
      },
    );


  }



}



class myBody extends StatefulWidget {
  myBody({
    Key key,
  }) : super(key: key);

  @override
  _myBodyState createState() => _myBodyState();
}

class _myBodyState extends State<myBody> {
  int _count = 1;
  var textController = TextEditingController();

  // Map _source = {ConnectivityResult.none: false};
  // MyConnectivity _connectivity = MyConnectivity.instance;

  double deliverCost = 10.00;
  double discountCost = 0.00;

  @override
  void initState() {
    // TODO: implement initState
    // TODO: implement initState
    setState(() {});
    super.initState();
    // _connectivity.initialise();
    // _connectivity.myStream.listen((source) {
    //   setState(() => _source = source);
    // });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var appLanguage = Provider.of<AppLanguage>(context,listen: false);
    return GetBuilder<CartViewModel>(
        init: Get.find(),
        builder: (controller) => Container(
          padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(2)),
          child: (controller.cartProductModel.length == 0) ?
          Center(child: CircularProgressIndicator(),) :
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: controller.cartProductModel.length,
            // separatorBuilder: (BuildContext context, int index) => Divider(height: 2),
            itemBuilder: (context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                key: Key(controller.cartProductModel[index].id),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: Colors.black,
                                width: 0.5))),
                    padding: EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 88,
                          child: AspectRatio(
                            aspectRatio: 0.88,
                            child: Container(
                              padding: EdgeInsets.all(
                                  getProportionateScreenWidth(
                                      15)),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(15),
                              ),
                              child: Hero(
                                tag: controller
                                    .cartProductModel[index].id,
                                child: Image.asset(
                                  controller.cartProductModel[index].image,
                                  // loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent
                                  //     loadingProgress) {
                                  //   if (loadingProgress == null)
                                  //     return child;
                                  //   return Center(
                                  //     child:
                                  //     CircularProgressIndicator(
                                  //       value: loadingProgress
                                  //           .expectedTotalBytes !=
                                  //           null
                                  //           ? loadingProgress
                                  //           .cumulativeBytesLoaded /
                                  //           loadingProgress
                                  //               .expectedTotalBytes
                                  //           : null,
                                  //     ),
                                  //   );
                                  // },
                                ),
                              ),
                              // Image.network(
                              //     controller.cartProductModel[index].image),
                            ),
                          ),
                        ),
                        // SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    appLanguage.appLocal
                                        .languageCode ==
                                        "en"
                                        ? controller
                                        .cartProductModel[
                                    index]
                                        .title
                                        : controller
                                        .cartProductModel[
                                    index]
                                        .titleAr,
                                    style: TextStyle(
                                        color: KTextColor,
                                        // fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    maxLines: 2,
                                  ),

                                ],
                              ),
                              SizedBox(height: 10),
                              Text.rich(
                                TextSpan(
                                  text:
                                  "${(controller.cartProductModel[index].price * controller.cartProductModel[index].count).toStringAsFixed(2)} ${AppLocalizations.of(context).translate("EGP")}",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red),
                                ),
                              )
                            ],
                          ),
                        ),
                        // Spacer(),
                        Expanded(
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                  padding:
                                  EdgeInsets.only(left: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisSize:
                                        MainAxisSize.min,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // controller.cartProductModel[index].count += 1;
                                                controller
                                                    .increaseQuantity(
                                                    index);
                                              });
                                            },
                                            child: Container(
                                              padding:
                                              const EdgeInsets
                                                  .all(3.0),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape
                                                      .circle,
                                                  border: Border
                                                      .all(),
                                                  color: Color
                                                      .fromRGBO(
                                                      160,
                                                      171,
                                                      255,
                                                      1.0)),
                                              child: Icon(
                                                Icons.add,
                                                color:
                                                Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 5.0),
                                          Text(
                                            "${controller.cartProductModel[index].count}",
                                            style: TextStyle(
                                                color: KTextColor,
                                                fontSize: 18,
                                                fontWeight:
                                                FontWeight
                                                    .w700),
                                          ),
                                          SizedBox(width: 5.0),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (controller.cartProductModel[index].count > 1) {
                                                  setState(() {
                                                    controller.decreaseQuantity(index);
                                                    // controller.getAllProduct();
                                                    controller.getTotalPrice();
                                                  });



                                                } else {

                                                  setState(() {
                                                    // controller.cartProductModel.removeAt(index);
                                                    controller.deleteItem(index);

                                                    controller.getAllProduct();
                                                    controller.getTotalPrice();

                                                  });
                                                  // controller.deleteItem(index);

                                                }
                                              });



                                            },
                                            child: Container(
                                              padding:
                                              const EdgeInsets
                                                  .all(3.0),
                                              decoration: BoxDecoration(
                                                  shape: BoxShape
                                                      .circle,
                                                  border: Border
                                                      .all(),
                                                  color: Color
                                                      .fromRGBO(
                                                      223,
                                                      227,
                                                      255,
                                                      1.0)),
                                              child: Icon(
                                                  Icons.remove,
                                                  color: Color
                                                      .fromRGBO(
                                                      65,
                                                      87,
                                                      255,
                                                      1.0)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        )
                      ],
                    )),
              );
            },
          )
          ,)
    );
  }
}