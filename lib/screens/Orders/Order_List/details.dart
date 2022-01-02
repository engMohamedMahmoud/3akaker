import 'package:flutter_offline/flutter_offline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:map_pin_picker/map_pin_picker.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:aakaker/screens/Orders/Order_List/Components/order_model.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'order_screen.dart';

class OrderDetailssScreen extends StatelessWidget {
  static String routeName = "/orderDetails";


  String convertTimeStampToHumanDate(int timeStamp) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    return DateFormat('dd/MM/yyyy HH:MM').format(dateToTimeStamp);
  }

  @override
  Widget build(BuildContext context) {
    final OrderDetailsArguments agrs =
        ModalRoute.of(context).settings.arguments;
    return
      WillPopScope(
        onWillPop: () => Future.value(false),
    child:
      Scaffold(
      backgroundColor: KbackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (prefs.getString('_id') != "" ){

              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder:
                          (BuildContext context) =>
                      new OrdersScreen(id: prefs.getString("_id"))));

            }
          },
        ),
        title: Text(
          AppLocalizations.of(context)
              .translate("Order Details"),
          style: TextStyle(color: kPrimaryColor),
        ),
        centerTitle: true,
        backgroundColor: KbackgroundColor,
      ),
      body: Body(order: agrs.order),
    ));
  }
}

class OrderDetailsArguments {
  final OrdersModel order;

  OrderDetailsArguments({@required this.order});

}

class Body extends StatefulWidget {
  final OrdersModel order;


  const Body({Key key, @required this.order}) : super(key: key);

  @override
  _BodyState createState() => _BodyState(order);

}



class _BodyState extends State<Body> {

  String notes;
  var textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double _ratingStar = 0;
  OrdersModel order;

  String phramcyName = "";
  MapPickerController mapPickerController = MapPickerController();
  // Map _source = {ConnectivityResult.none: false};
  // MyConnectivity _connectivity = MyConnectivity.instance;

  _BodyState(this.order);
  @override
  void initState() {
    setState(() {
      phramcyName = order.pharmacy;
      print("phramcyName $phramcyName");
    });
    // TODO: implement initState
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
        return SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              // padding: EdgeInsets.symmetric(horizontal: 10),
                child: (order.type == "Normal")
                    ? Padding(padding: appLanguage.appLocal.languageCode == 'en'
                    ? EdgeInsets.only(left: 0, right: 0)
                    : EdgeInsets.only(left: 0, right: 0), child:
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MapPicker(
                      // pass icon widget
                      iconWidget: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 50,
                      ),
                      //add map picker controller
                      mapPickerController: mapPickerController,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 110,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(order.deliveryAddress.lat,
                                  order.deliveryAddress.long), zoom: 16.0),
                          // zoomGesturesEnabled: true,
                        ),
                      ),

                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    Padding(
                      padding: appLanguage.appLocal.languageCode == 'en'
                          ? EdgeInsets.only(right: 15, left: 0)
                          : EdgeInsets.only(right: 0, left: 15),
                      child: Row(
                        children: [
                          appLanguage.appLocal.languageCode == 'en' ? Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 5, left: 5, top: 0),
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.asset(
                                        "assets/images/welcome_illustration.png",
                                        // height: 50,
                                        // width: 50.0,

                                      ),

                                    ),
                                  ),
                                ),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),


                              ],
                            ),
                          ) : Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 5, left: 5, top: 0),
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.asset(
                                        "assets/images/welcome_illustration.png",
                                        // height: 50,
                                        // width: 50.0,

                                      ),

                                    ),
                                  ),
                                ),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),


                              ],
                            ),
                          ),
                          SizedBox(width: 3),

                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: getProportionateScreenHeight(5)),
                                  Container(
                                    // padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
                                      alignment:
                                      appLanguage.appLocal.languageCode ==
                                          'en'
                                          ? Alignment.topLeft
                                          : Alignment.topRight,

                                      child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [


                                            Flexible(child:
                                            Text(
                                              "${order.userId.firstName} ${order.userId.lastName}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 22),
                                            ),
                                            )


                                          ])),

                                  SizedBox(height: getProportionateScreenHeight(5)),
                                  Text(
                                    convertTimeStampToHumanDate(
                                        order.creationDate),
                                    style: TextStyle(

                                      // fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Color.fromRGBO(29, 35, 96, 1.0)),
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(5)),



                                  Container(
                                    // padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
                                      alignment:
                                      appLanguage.appLocal.languageCode ==
                                          'en'
                                          ? Alignment.topLeft
                                          : Alignment.topRight,

                                      child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [

                                            Flexible(child: Text(
                                              // AppLocalizations.of(context).translate("Total"),
                                              "${AppLocalizations.of(context)
                                                  .translate("Totaled")} : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),),


                                            Flexible(child:
                                            Text(
                                              "${order.totalPrice + order
                                                  .shipping} ${AppLocalizations
                                                  .of(context).translate(
                                                  "EGP")}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(

                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      29, 35, 96, 1.0)),

                                            ),
                                            )


                                          ])),
                                  SizedBox(height: getProportionateScreenHeight(5)),


                                  Container(
                                    // padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
                                      alignment:
                                      appLanguage.appLocal.languageCode ==
                                          'en'
                                          ? Alignment.topLeft
                                          : Alignment.topRight,

                                      child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${AppLocalizations.of(context)
                                                  .translate(
                                                  "statusOrder")} : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            if(order.status == "Delivered")
                                              Flexible(child:Text(
                                                " ${AppLocalizations.of(context).translate("Delivered")}" ,
                                                style: TextStyle(

                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        29, 35, 96, 1.0)),
                                              ))
                                            else if(order.status == "New")
                                              Flexible(child: Text(
                                                " ${AppLocalizations.of(context).translate("NewOrder")}" ,
                                                style: TextStyle(

                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        29, 35, 96, 1.0)),
                                              ))
                                            else
                                              Flexible(child:Text(
                                                " ${AppLocalizations.of(context).translate("Onwey")}" ,
                                                style: TextStyle(

                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        29, 35, 96, 1.0)),
                                              ))
                                            ,
                                            // Flexible(child: Text(
                                            //   " ${(order.status != "New" &&
                                            //       order.status != "Onway")
                                            //       ? AppLocalizations.of(context)
                                            //       .translate("Delivered")
                                            //       : (order.status != "New" &&
                                            //       order.status != "Delivered")
                                            //       ? AppLocalizations.of(context)
                                            //       .translate("Onwey")
                                            //       : AppLocalizations.of(context)
                                            //       .translate("NewOrder")}",
                                            //   style: TextStyle(
                                            //
                                            //       fontSize: 16,
                                            //       color: Color.fromRGBO(
                                            //           29, 35, 96, 1.0)),
                                            // ),),


                                          ])),
                                  SizedBox(height: getProportionateScreenHeight(5)),

                                  Container(
                                    // padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
                                      alignment:
                                      appLanguage.appLocal.languageCode ==
                                          'en'
                                          ? Alignment.topLeft
                                          : Alignment.topRight,

                                      child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${AppLocalizations.of(context)
                                                  .translate(
                                                  "Pharmacy")} : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            Flexible(child: Text(
                                              order.pharmacy,
                                              style: TextStyle(

                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      29, 35, 96, 1.0)),
                                            ),),


                                          ])),
                                  SizedBox(height: getProportionateScreenHeight(5)),

                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)
                                              .translate("Order ID")} : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Flexible(child: Text(
                                          order.orderId.toString(),
                                          style: TextStyle(

                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  29, 35, 96, 1.0)),
                                        ))

                                      ],
                                    ),
                                  ),
                                  SizedBox(height: getProportionateScreenHeight(5)),
                                  (order.rate != 0) ? Visibility(
                                    child:
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                      children: [

                                        RatingBar.readOnly(
                                          initialRating: order.rate.toDouble(),
                                          isHalfAllowed: true,
                                          halfFilledIcon: Icons.star_half,
                                          filledIcon: Icons.star,
                                          emptyIcon: Icons.star_border,
                                          size: 25,
                                          emptyColor: Color.fromRGBO(211, 160, 42, 1.0),
                                          filledColor: Color.fromRGBO(211, 160, 42, 1.0),
                                        )

                                      ],
                                    ),
                                    visible: true,
                                  ) :

                                  Visibility(
                                    child:
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                      children: [


                                        RatingBar.readOnly(
                                          initialRating: order.rate.toDouble(),
                                          isHalfAllowed: true,
                                          halfFilledIcon: Icons.star_half,
                                          filledIcon: Icons.star,
                                          emptyIcon: Icons.star_border,
                                          size: 25,
                                          emptyColor: Color.fromRGBO(211, 160, 42, 1.0),
                                          filledColor: Color.fromRGBO(211, 160, 42, 1.0),
                                        )

                                      ],
                                    ),
                                    visible: false,
                                  )



                                ],
                              ),
                              // SizedBox(height: 20),
                            ],
                          ),),

                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey, width: 0.5))),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Padding(
                      padding: appLanguage.appLocal.languageCode == 'en'
                          ? EdgeInsets.only(right: 15, left: 0)
                          : EdgeInsets.only(right: 0, left: 15),
                      child: Row(
                        children: [
                          appLanguage.appLocal.languageCode == 'en' ? Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/location-pin.svg",
                                  width: 30,
                                  height: 38,
                                  color: Colors.green,
                                ),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                              ],
                            ),
                          ) : Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/location-pin.svg",
                                  width: 30,
                                  height: 38,
                                  color: Colors.green,
                                ),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                              ],
                            ),
                          ),
                          SizedBox(width: 3),

                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("Delivery Address"),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)
                                              .translate("City")} : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "${order.deliveryAddress.city}",
                                          style: TextStyle(

                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  29, 35, 96, 1.0)),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),

                                  Container(
                                    // padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
                                      alignment:
                                      appLanguage.appLocal.languageCode ==
                                          'en'
                                          ? Alignment.topLeft
                                          : Alignment.topRight,

                                      child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${AppLocalizations.of(context)
                                                  .translate("Street")} : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            Flexible(child: Text(
                                              "${order.deliveryAddress.street
                                                  .split(',')[0]}",
                                              style: TextStyle(

                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      29, 35, 96, 1.0)),
                                            ))

                                          ])),


                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)
                                              .translate("Building No")} : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "${order.deliveryAddress.building}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  29, 35, 96, 1.0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)
                                              .translate("Floor No")} : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "${order.deliveryAddress.floor}",
                                          style: TextStyle(

                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  29, 35, 96, 1.0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)
                                              .translate("Flat No")} : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "${order.deliveryAddress.flatNo}",
                                          style: TextStyle(

                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  29, 35, 96, 1.0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)
                                              .translate("Mobile")} : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "${order.deliveryAddress.number
                                              .substring(2)}",
                                          style: TextStyle(

                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  29, 35, 96, 1.0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                ],
                              ),
                              // SizedBox(height: 20),
                            ],
                          ),),

                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey, width: 0.5))),
                    ),
                    SizedBox(height: getProportionateScreenHeight(30)),


                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15), child: Row(
                      children: [
                        Text(
                          // AppLocalizations.of(context).translate("Total"),
                          AppLocalizations.of(context)
                              .translate("Products Order"),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Spacer(),
                        Text(""),
                      ],
                    ),),

                    SizedBox(height: getProportionateScreenHeight(10)),


                    ListTile(
                      title: Text(
                        AppLocalizations.of(context).translate("Name"),
                        style: TextStyle(
                            color: KTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      leading: Text(
                        AppLocalizations.of(context).translate("QTY"),
                        style: TextStyle(
                            color: KTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),
                      // subtitle: const Text('The airplane is only in Act II.'),
                      trailing: Text(
                        AppLocalizations.of(context).translate("Price"),
                        style: TextStyle(
                            color: KTextColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      ),

                    ),
                    (order.products.length != 0)
                        ? Visibility(
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: order.products.length,
                            // separatorBuilder: (BuildContext context, int index) => Divider(height: 2),
                            itemBuilder: (context, int index) {
                              return ListTile(
                                title: Text(
                                  appLanguage.appLocal.languageCode ==
                                      "en"
                                      ? order
                                      .products[index].nameEn
                                      : order
                                      .products[index].nameAr,

                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14),

                                ),
                                leading: Text(
                                  "${order.products[index].orderCount}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ),
                                // subtitle: const Text('The airplane is only in Act II.'),
                                trailing: Text(
                                  "${order.products[index]
                                      .price.toStringAsFixed(2)} ${AppLocalizations.of(context)
                                      .translate("EGP")}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ),

                              );
                            },
                          )
                        ],
                      ),
                      visible: true,
                    )
                        : Visibility(
                      child: Column(
                        children: <Widget>[
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: order.products.length,
                            // separatorBuilder: (BuildContext context, int index) => Divider(height: 2),
                            itemBuilder: (context, int index) {
                              return ListTile(
                                title: Text(
                                  appLanguage.appLocal.languageCode ==
                                      "en"
                                      ? order
                                      .products[index].id.nameEn
                                      : order
                                      .products[index].id.nameAr,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15),
                                  maxLines: 2,
                                ),
                                leading: Text(
                                    "${order.products[index].orderCount}"),
                                // subtitle: const Text('The airplane is only in Act II.'),
                                trailing: Text(
                                  "${order.products[index].price.toStringAsFixed(2)} ${AppLocalizations.of(context)
                                      .translate("EGP")}",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ),

                              );
                            },
                          )
                        ],
                      ),
                      visible: false,
                    ),

                    Container(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey, width: 0.5))),
                    ),

                    SizedBox(height: getProportionateScreenHeight(10)),


                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15), child: Row(
                      children: [
                        Text(
                          // AppLocalizations.of(context).translate("Total"),
                          AppLocalizations.of(context)
                              .translate("Order Summary"),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Spacer(),
                        Text(""),
                      ],
                    ),),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15), child: Row(
                      children: [
                        Text(
                          AppLocalizations.of(context).translate("Totaled"),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        Spacer(),
                        Text(
                          "${order.totalPrice.toStringAsFixed(2)} ${AppLocalizations.of(context)
                              .translate("EGP")}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        ),
                        Text("")
                      ],
                    ),),
                    SizedBox(height: getProportionateScreenHeight(10)),

                    SizedBox(height: getProportionateScreenHeight(10)),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15), child: Row(
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
                        Text(
                          "${order.shipping.toStringAsFixed(2)} ${AppLocalizations.of(context)
                              .translate("EGP")}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ],
                    ),),

                    SizedBox(height: getProportionateScreenHeight(10)),

                    Padding(padding: EdgeInsets.only(left: 15, right: 15),
                      child: Container(
                        // height: 70.0,
                          decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: Colors.black, width: 0.5),
                              ))),),
                    SizedBox(height: getProportionateScreenHeight(20)),
                    Padding(
                      padding: EdgeInsets.only(left: 15, right: 15), child:
                    Row(
                      children: [
                        Text(
                          // AppLocalizations.of(context).translate("Total"),
                          AppLocalizations.of(context)
                              .translate("TotalOrder"),
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Spacer(),
                        Text(
                          "${(order.totalPrice + order
                              .shipping).toStringAsFixed(2)} ${AppLocalizations.of(context)
                              .translate("EGP")}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              fontSize: 14),
                        ),
                      ],
                    ),),

                    SizedBox(height: getProportionateScreenHeight(10)),

                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    // SignUpForm(),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    SizedBox(height: getProportionateScreenHeight(20)),
                  ],
                ))
                    : Padding(padding: appLanguage.appLocal.languageCode == 'en'
                    ? EdgeInsets.only(left: 0, right: 0)
                    : EdgeInsets.only(left: 0, right: 0), child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    MapPicker(
                      // pass icon widget
                      iconWidget: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 50,
                      ),
                      //add map picker controller
                      mapPickerController: mapPickerController,
                      child: Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        height: 110,
                        child: GoogleMap(
                          initialCameraPosition: CameraPosition(
                              target: LatLng(order.deliveryAddress.lat,
                                  order.deliveryAddress.long), zoom: 16.0),
                          // zoomGesturesEnabled: true,
                        ),
                      ),

                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.01),
                    Padding(
                      padding: appLanguage.appLocal.languageCode == 'en'
                          ? EdgeInsets.only(right: 15, left: 0)
                          : EdgeInsets.only(right: 0, left: 15),
                      child: Row(
                        children: [
                          appLanguage.appLocal.languageCode == 'en' ? Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 5, left: 5, top: 0),
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.asset(
                                        "assets/images/welcome_illustration.png",
                                        // height: 50,
                                        // width: 50.0,

                                      ),

                                    ),
                                  ),
                                ),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),


                              ],
                            ),
                          ) : Padding(
                            padding: EdgeInsets.only(
                              left: 5,
                              right: 5,
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 70,
                                  child: AspectRatio(
                                    aspectRatio: 0.88,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          right: 5, left: 5, top: 0),
                                      decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.asset(
                                        "assets/images/welcome_illustration.png",
                                        // height: 50,
                                        // width: 50.0,

                                      ),

                                    ),
                                  ),
                                ),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),


                              ],
                            ),
                          ),
                          SizedBox(width: 3),

                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Text(
                                    "${order.userId.firstName} ${order.userId
                                        .lastName}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Text(
                                    convertTimeStampToHumanDate(
                                        order.creationDate),
                                    style: TextStyle(

                                      // fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Color.fromRGBO(29, 35, 96, 1.0)),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),


                                  Container(
                                    // padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
                                      alignment:
                                      appLanguage.appLocal.languageCode ==
                                          'en'
                                          ? Alignment.topLeft
                                          : Alignment.topRight,

                                      child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Flexible(child:
                                            Text(
                                              AppLocalizations.of(context)
                                                  .translate("Roashta"),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(

                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      29, 35, 96, 1.0)),

                                            ),
                                            )


                                          ])),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),


                                  Container(
                                    // padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
                                      alignment:
                                      appLanguage.appLocal.languageCode ==
                                          'en'
                                          ? Alignment.topLeft
                                          : Alignment.topRight,

                                      child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${AppLocalizations.of(context)
                                                  .translate(
                                                  "statusOrder")} : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),



                                            if(order.status == "Delivered")
                                              Flexible(child:Text(
                                                " ${AppLocalizations.of(context).translate("Delivered")}" ,
                                                style: TextStyle(

                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        29, 35, 96, 1.0)),
                                              ))
                                            else if(order.status == "New")
                                              Flexible(child: Text(
                                                " ${AppLocalizations.of(context).translate("NewOrder")}" ,
                                                style: TextStyle(

                                                    fontSize: 16,
                                                    color: Color.fromRGBO(
                                                        29, 35, 96, 1.0)),
                                              ))
                                            else
                                              Flexible(child:Text(
          " ${AppLocalizations.of(context).translate("Onwey")}" ,
          style: TextStyle(

              fontSize: 16,
              color: Color.fromRGBO(
                  29, 35, 96, 1.0)),
        ))
                                              ,

                                            ///elarousi
                                            // Flexible(child: Text(
                                            //   " ${(order.status != "New" &&
                                            //       order.status != "Onway")
                                            //       ? AppLocalizations.of(context)
                                            //       .translate("Delivered")
                                            //       : (order.status != "New" &&
                                            //       order.status != "Delivered")
                                            //       ? AppLocalizations.of(context)
                                            //       .translate("Onwey")
                                            //       : AppLocalizations.of(context)
                                            //       .translate("NewOrder")}",
                                            //   style: TextStyle(
                                            //
                                            //       fontSize: 16,
                                            //       color: Color.fromRGBO(
                                            //           29, 35, 96, 1.0)),
                                            // ),),


                                          ])),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),

                                  Container(
                                    // padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
                                      alignment:
                                      appLanguage.appLocal.languageCode ==
                                          'en'
                                          ? Alignment.topLeft
                                          : Alignment.topRight,

                                      child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${AppLocalizations.of(context)
                                                  .translate(
                                                  "Pharmacy")} : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16),
                                            ),
                                            Flexible(child: Text(
                                              order.pharmacy,
                                              style: TextStyle(

                                                  fontSize: 16,
                                                  color: Color.fromRGBO(
                                                      29, 35, 96, 1.0)),
                                            ),),


                                          ])),
                                  SizedBox(height: getProportionateScreenHeight(5)),

                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)
                                              .translate("Order ID")} : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16),
                                        ),
                                        Flexible(child: Text(
                                          order.orderId.toString(),
                                          style: TextStyle(

                                              fontSize: 16,
                                              color: Color.fromRGBO(
                                                  29, 35, 96, 1.0)),
                                        ))

                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  (order.rate != 0) ? Visibility(
                                    child:
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                      children: [


                                        RatingBar.readOnly(
                                          initialRating: order.rate.toDouble(),
                                          isHalfAllowed: true,
                                          halfFilledIcon: Icons.star_half,
                                          filledIcon: Icons.star,
                                          emptyIcon: Icons.star_border,
                                          size: 25,
                                          emptyColor: Color.fromRGBO(211, 160, 42, 1.0),
                                          filledColor: Color.fromRGBO(211, 160, 42, 1.0),
                                        )




                                      ],
                                    ),
                                    visible: true,
                                  ) :
                                  Visibility(
                                    child:
                                    Row(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,

                                      children: [


                                        RatingBar.readOnly(
                                          initialRating: order.rate.toDouble(),
                                          isHalfAllowed: true,
                                          halfFilledIcon: Icons.star_half,
                                          filledIcon: Icons.star,
                                          emptyIcon: Icons.star_border,
                                          size: 25,
                                          emptyColor: Color.fromRGBO(211, 160, 42, 1.0),
                                          filledColor: Color.fromRGBO(211, 160, 42, 1.0),
                                        )

                                      ],
                                    ),
                                    visible: false,
                                  ) ,


                                ],
                              ),
                              // SizedBox(height: 20),
                            ],
                          ),),

                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey, width: 0.5))),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),
                    Padding(
                      padding: appLanguage.appLocal.languageCode == 'en'
                          ? EdgeInsets.only(right: 15, left: 0)
                          : EdgeInsets.only(right: 0, left: 15),
                      child: Row(
                        children: [
                          appLanguage.appLocal.languageCode == 'en' ? Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/location-pin.svg",
                                  width: 30,
                                  height: 38,
                                  color: Colors.green,
                                ),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                              ],
                            ),
                          ) :
                          Padding(
                            padding: EdgeInsets.only(
                              left: 15,
                              right: 15,
                            ),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/location-pin.svg",
                                  width: 30,
                                  height: 38,
                                  color: Colors.green,
                                ),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                                Text(""),
                              ],
                            ),
                          ),
                          SizedBox(width: 3),

                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Text(
                                    AppLocalizations.of(context)
                                        .translate("Delivery Address"),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)
                                              .translate("City")} : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "${order.deliveryAddress.city}",
                                          style: TextStyle(

                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  29, 35, 96, 1.0)),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),

                                  Container(
                                    // padding: EdgeInsets.symmetric(vertical: getProportionateScreenWidth(20)),
                                      alignment:
                                      appLanguage.appLocal.languageCode ==
                                          'en'
                                          ? Alignment.topLeft
                                          : Alignment.topRight,

                                      child: Row(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${AppLocalizations.of(context)
                                                  .translate("Street")} : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18),
                                            ),
                                            Flexible(child: Text(
                                              "${order.deliveryAddress.street
                                                  .split(',')[0]}",
                                              style: TextStyle(

                                                  fontSize: 15,
                                                  color: Color.fromRGBO(
                                                      29, 35, 96, 1.0)),
                                            ))

                                          ])),


                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)
                                              .translate("Building No")} : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "${order.deliveryAddress.building}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  29, 35, 96, 1.0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)
                                              .translate("Floor No")} : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "${order.deliveryAddress.floor}",
                                          style: TextStyle(

                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  29, 35, 96, 1.0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)
                                              .translate("Flat No")} : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "${order.deliveryAddress.flatNo}",
                                          style: TextStyle(

                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  29, 35, 96, 1.0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${AppLocalizations.of(context)
                                              .translate("Mobile")} : ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "${order.deliveryAddress.number
                                              .substring(2)}",
                                          style: TextStyle(

                                              fontSize: 15,
                                              color: Color.fromRGBO(
                                                  29, 35, 96, 1.0)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      height:
                                      getProportionateScreenHeight(5)),
                                ],
                              ),
                              // SizedBox(height: 20),
                            ],
                          ),),

                        ],
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey, width: 0.5))),
                    ),
                    SizedBox(height: getProportionateScreenHeight(10)),

                    SizedBox(height: getProportionateScreenHeight(20)),
                  ],
                ))
            ),
          ),
        );
      },
    );


  }


  String convertTimeStampToHumanDate(int creationDate) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(creationDate);
    return DateFormat('yyyy-MM-dd  -  hh:mm:ss').format(dateToTimeStamp);
  }
}
