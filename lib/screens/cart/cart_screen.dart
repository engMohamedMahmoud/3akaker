import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/Conection/test_conection.dart';
import 'package:aakaker/screens/Empty_cart/empty_screen.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import '../../size_config.dart';
import 'components/body.dart';
import 'components/cart_view_model.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return CartComponents();
  }
}


class CartComponents extends StatefulWidget {
  CartComponents({
    Key key,
  }) : super(key: key);
  @override
  _CartComponentsState createState() => _CartComponentsState();
}

class _CartComponentsState extends State<CartComponents> {


  Map _source = {ConnectivityResult.none: false};
  MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    // getUserLocation();
    // TODO: implement initState
    setState(() {
    });
    super.initState();
    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });


  }


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return

      WillPopScope(
        onWillPop: () => Future.value(false),
    child:
      GetBuilder<CartViewModel>(
          init: Get.find(),
          builder: (controller) => (controller.cartProductModel.length == 0)
              ? EmptyCartScreen()
              :
          Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder:
                            (BuildContext context) =>
                        new HomeScreen(
                        ))),
              ),
              centerTitle: true,

              title: Text(
                AppLocalizations.of(context).translate("Basket Orders"),
                style: TextStyle(color: KTextColor),
              ),
              backgroundColor: Kbg,
            ),

            body: Body(),
            backgroundColor: Kbg,
          )));



  }
}