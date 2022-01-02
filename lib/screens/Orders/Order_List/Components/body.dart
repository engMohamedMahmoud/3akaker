import 'dart:convert';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:aakaker/components/default_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import '../../../../size_config.dart';
import '../details.dart';
import '../order_screen.dart';
import 'NetworkOrders.dart';
import 'order_model.dart';

class MyAppOrdersList extends StatelessWidget {
  final String id;

  MyAppOrdersList(this.id);

  @override
  Widget build(BuildContext context) {
    return Provider<OrdersBloc>(
        create: (context) => OrdersBloc(id),
        dispose: (context, bloc) => bloc.dispose(),
        child: Body(id));
  }
}

class Body extends StatefulWidget {
  final String id;

  Body(this.id);

  @override
  _BodyState createState() => _BodyState(id);
}

class _BodyState extends State<Body> with WidgetsBindingObserver{
  int _count = 1;
  String notes;
  var textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double _ratingStar = 0;





  String id;
  Set<OrdersModel> types;
  Set<int> maTypes = {};
  var rating = 0.0;

  _BodyState(this.id);



  @override
  void initState() {
    super.initState();

    // maTypes.addAll(List.generate(20, (x) => x));

    types = {};
    //
  }

  String convertTimeStampToHumanDate(int timeStamp) {
    var dateToTimeStamp = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return DateFormat('yyyy-MM-dd - hh:mm:ss').format(dateToTimeStamp);
  }

  bool onNotification(ScrollNotification scrollInfo, OrdersBloc bloc) {
    if (scrollInfo is OverscrollNotification) {
      bloc.sink.add(scrollInfo);

    }

    return false;
  }

  Widget buildListView(
    BuildContext context,
    AsyncSnapshot<List<OrdersModel>> snapshot,
  ) {




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
        if (!snapshot.hasData) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 20,
              // separatorBuilder: (BuildContext context, int index) => Divider(height: 2),
              itemBuilder: (context, int index) {


                return
                  Shimmer.fromColors(
                      baseColor: Colors.black38,
                      highlightColor: Colors.white,
                      child: Container(
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(
                          // color: Color.fromRGBO(246, 246, 248, 1.0),
                          borderRadius: BorderRadius.circular(18.0),
                          border: Border.all(color: Colors.black12, width: 1.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Container(

                              padding: EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 70,
                                    height: 70,
                                    child: AspectRatio(
                                      aspectRatio: 0.88,
                                      child: Container(
                                        padding: EdgeInsets.only(right: 5, left: 5, top: 0),
                                        color: Colors.black12,


                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 10),
                                  Expanded(child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),child: Container(height: 10,width: 200, color: Colors.black12,),),
                                          Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),child: Container(height: 10,width: 200, color: Colors.black12,),),
                                          Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),child: Container(height: 10,width: 200, color: Colors.black12,),),

                                        ],
                                      ),
                                      // SizedBox(height: 20),
                                    ],
                                  ),)
                                  ,



                                ],
                              )),
                        ),
                      )
                  );
              },
            ),
          );
        }

        types.addAll(snapshot.data);

        return (types.length != 0)?
        Card(child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: types.length,
            // separatorBuilder: (BuildContext context, int index) => Divider(height: 2),
            itemBuilder: (context, int index) {

              return GestureDetector(
                onTap: () {

                  print(types.elementAt(index).orderId);

                  Navigator.pushNamed(
                      context,
                      OrderDetailssScreen.routeName,
                      arguments: OrderDetailsArguments(order: types.elementAt(index)));



                },
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                      decoration: BoxDecoration(
                          border: Border(

                              bottom: (index == types.length - 1)? BorderSide(color: Colors.transparent, width: 0.0):BorderSide(color: Colors.grey, width: 0.5)
                          )),
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 70,
                            child: AspectRatio(
                              aspectRatio: 0.88,
                              child: Container(
                                padding: EdgeInsets.only(right: 5, left: 5, top: 0),
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

                          SizedBox(width: 10),
                          Expanded(child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${convertTimeStampToHumanDate(
                                        types.elementAt(index).creationDate)}",
                                    style: TextStyle( fontWeight: FontWeight.bold,
                                        color: Colors.black, fontSize: 18),
                                  ),

                                  SizedBox(height: 3,),
                                  // Text(
                                  //   "${AppLocalizations.of(context).translate("statusOrder")} : ${(types.elementAt(index).status != "New" && types.elementAt(index).status != "Onwey" )? AppLocalizations.of(context).translate("Arrived"): (types.elementAt(index).status != "New" && types.elementAt(index).status != "Delivered" )? AppLocalizations.of(context).translate("PreParing"):AppLocalizations.of(context).translate("NewOrder")}" ,
                                  //   style: TextStyle(
                                  //       color: Colors.grey, fontSize: 16),
                                  // ),
                                  // if(types.elementAt(index).status == "New")
                                  //   Text(
                                  //     "${AppLocalizations.of(context).translate("statusOrder")} : ${AppLocalizations.of(context).translate("NewOrder")}" ,
                                  //     style: TextStyle(
                                  //         color: Colors.grey, fontSize: 16),
                                  //   ),
                                  //
                                  if(types.elementAt(index).status == "Delivered")
                                    Text(
                                      "${AppLocalizations.of(context).translate("statusOrder")} : ${AppLocalizations.of(context).translate("Delivered")}" ,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    )
                                    else if(types.elementAt(index).status == "New")
                                    Text(
                                      "${AppLocalizations.of(context).translate("statusOrder")} : ${AppLocalizations.of(context).translate("NewOrder")}" ,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ) else
                                    Text(
                                      "${AppLocalizations.of(context).translate("statusOrder")} : ${AppLocalizations.of(context).translate("Onwey")}" ,
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 16),
                                    ),
                                  SizedBox(height: 3,),
                                  (types.elementAt(index).products.length != 0)? Visibility(child: Text(
                                    AppLocalizations.of(context).translate("Roashta"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16),

                                  ), visible: false,): Visibility(child: Padding(padding: EdgeInsets.only(top: 2,bottom: 2),child: Text(
                                    AppLocalizations.of(context).translate("Roashta"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 16),

                                  ),), visible: true,),
                                  SizedBox(height: 3,),
                                  Text(
                                    "${AppLocalizations.of(context).translate("Pharmacy")} : ${types.elementAt(index).pharmacy}" ,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 16),
                                  ),

                                  SizedBox(height: 3,),
                                  Text("${(types.elementAt(index).orderId)}", style: TextStyle(color: Colors.grey, fontSize: 16),),
                                  SizedBox(height: 3,),
                                  (types.elementAt(index).rate != 0) ?
                                  Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,

                                    children: [

                                      SizedBox(
                                          height:
                                          getProportionateScreenHeight(5)),

                                      // RatingBar(
                                      //
                                      //   initialRating: types[index].rate.toDouble(),
                                      //
                                      //
                                      //   filledIcon: Icons.star,
                                      //   emptyIcon: Icons.star_border,
                                      //   emptyColor: Color.fromRGBO(211, 160, 42, 1.0),
                                      //   filledColor: Color.fromRGBO(211, 160, 42, 1.0),
                                      //   size: 23.0,
                                      // ),

                                      RatingBar.readOnly(
                                        initialRating: types.elementAt(index).rate.toDouble(),
                                        isHalfAllowed: true,
                                        halfFilledIcon: Icons.star_half,
                                        filledIcon: Icons.star,
                                        emptyIcon: Icons.star_border,
                                        size: 23,
                                        emptyColor: Color.fromRGBO(211, 160, 42, 1.0),
                                        filledColor: Color.fromRGBO(211, 160, 42, 1.0),
                                      )

                                    ],
                                  )
                                      :
                                  new GestureDetector(
                                    onTap: () {

                                      print("items ${types.elementAt(index).status}");
                                      if(types.elementAt(index).status == "Delivered"){
                                        openAlertBox(types.elementAt(index).id);
                                      }else{
                                        Toast.show(AppLocalizations.of(context).translate("Wait, Until Completed your Order"),context,backgroundColor:Colors.red, textColor: Colors.white);
                                      }




                                    },
                                    child: new Center(child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(5.0)
                                      ),
                                      // color: Colors.green,
                                      // padding: EdgeInsets.only(top:60, bottom: 0, left: 10),
                                      margin: EdgeInsets.only(top: 5.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            "assets/icons/rate.svg",
                                            width: 25,
                                            height: 25,
                                            color: Colors.black,
                                          ),
                                          Text("  "),
                                          Text(
                                            AppLocalizations.of(
                                                context)
                                                .translate("Rate"),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ],
                                      ),
                                    ),),
                                  ),

                                ],
                              ),
                              // SizedBox(height: 20),
                            ],
                          ),)
                          ,



                        ],
                      )),
                ),
              );
            },
          ),
        ),) :
        Container(
          alignment: Alignment.center,
          child: Column(

            children: [
              Center(child: Image.asset("assets/icons/empty2.png",height: 200, width: 200,),),
              Text(
                AppLocalizations.of(context).translate("No Orders"),
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),

              SizedBox(height: getProportionateScreenHeight(15)),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 50),
                child: SecondButton(
                  text:  AppLocalizations.of(context).translate("Browse Medicines"),

                  press: () {

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder:
                                (BuildContext context) =>
                            new HomeScreen()));
                  },
                ),
              )

            ],
          ),
        );
      },
    );


  }



  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<OrdersBloc>(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) => onNotification(notification, bloc),
      child: StreamBuilder<List<OrdersModel>>(
        stream: bloc.stream,
        builder: (context, AsyncSnapshot<List<OrdersModel>> snapshot) {
          return buildListView(context, snapshot);
        },
      ),
    );
  }








  openAlertBox(String id) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          var appLanguage = Provider.of<AppLanguage>(context,listen: false);
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
                contentPadding: EdgeInsets.all(1.0),

                content: Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                          child: Text(
                              AppLocalizations.of(context).translate("Rate"),
                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: kPrimaryColor))),
                      SizedBox(
                        height: 5.0,
                      ),
                      RatingBar(

                        onRatingChanged: (rating) =>
                            setState(() => _ratingStar = rating),
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        emptyColor: Color.fromRGBO(211, 160, 42, 1.0),
                        filledColor: Color.fromRGBO(211, 160, 42, 1.0),

                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      TextField(
                         // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,

                        maxLines: 7,
                        maxLength: 200,
                        controller: textController,
                        decoration: InputDecoration(

                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          hintText: AppLocalizations.of(context).translate("Enter Comment"),
                          counterText: "",
                          contentPadding: EdgeInsets.all(10.0)
                        ),

                      ),
                      SizedBox(
                        height: 20.0,
                      ),

                      ArgonButton(
                        height: 40,

                        roundLoadingShape: true,
                        color: kPrimaryColor,
                        width: MediaQuery.of(context)
                            .size
                            .width *
                            0.75,
                        onTap: (startLoading, stopLoading,
                            btnState) async {


                          if (btnState == ButtonState.Idle) {
                            stopLoading();

                            if (_ratingStar != 0.0) {

                              stopLoading();
                              // createUser(id, textController.text);
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              final String apiUrl = "$url/Rate/Add";

                              final response = await http.post(apiUrl, body: {
                                'Rate': _ratingStar.toString(),
                                "RateNote": textController.text,
                                "_id": id,
                                "Language": appLanguage.appLocal.languageCode.toUpperCase()
                              },headers: {"authorization":prefs.getString('token')});

                              var jsonData = json.decode(response.body);

                              try {
                                if (response.statusCode == 200) {

                                  stopLoading();
                                  Toast.show(AppLocalizations.of(context).translate("Rate Order Success"),context,backgroundColor:Colors.green, textColor: Colors.white);
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  if (prefs.getString('_id') != "" ){
                                    final navigator = Navigator.of(context);
                                    await navigator.push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            OrdersScreen(id: prefs.getString("_id")),
                                      ),
                                    );
                                  }






                                } else {
                                  stopLoading();
                                  Toast.show(AppLocalizations.of(context).translate("There is a problem"),context,backgroundColor:Colors.green, textColor: Colors.white,duration: 40);
                                }
                              } catch (err) {
                                stopLoading();
                              }

                            }
                          }






                        },
                        child: Text(
                          AppLocalizations.of(context).translate("Rate Number"),
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                        loader: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black38,
                                    blurRadius: 20.0)
                              ],
                              borderRadius:
                              BorderRadius.circular(
                                  50.0),
                              gradient: LinearGradient(
                                  colors: <Color>[
                                    Colors.white,
                                    kPrimaryColor
                                  ])),
                          child: SpinKitRotatingCircle(
                            color: kPrimaryColor,
                            // size: loaderWidth ,
                          ),
                        ),
                        borderRadius: 20.0,
                      ),

                      SizedBox(
                        height: 20.0,
                      ),



                    ],
                  ),
                ),
              ));
        }).then((value) {
      setState(() {
        textController.text = "";
      });
    }).then((value) => setState(() {
      textController.text = "";
    }));
  }


  createUser(String id, String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var appLanguage = Provider.of<AppLanguage>(context,listen: false);
    final String apiUrl = "$url/Rate/Add";

    final response = await http.post(apiUrl, body: {
      'Rate': _ratingStar.toString(),
      "RateNote": text,
      "_id": id,
      "Language": appLanguage.appLocal.languageCode.toUpperCase()
    },headers: {"authorization":prefs.getString('token')});

    var jsonData = json.decode(response.body);

    try {
      if (response.statusCode == 200) {

        Toast.show(AppLocalizations.of(context).translate("Rate Order Success"),context,backgroundColor:Colors.green, textColor: Colors.white);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getString('_id') != "" ){
          final navigator = Navigator.of(context);
          await navigator.push(
            MaterialPageRoute(
              builder: (context) =>
                  OrdersScreen(id: prefs.getString("_id")),
            ),
          );
        }






      } else {
        Toast.show(AppLocalizations.of(context).translate("There is a problem"),context,backgroundColor:Colors.green, textColor: Colors.white);
      }
    } catch (err) {
    }
  }
}

class ReOrderApi {
  final String id;
  final int price;
  final int orderCount;

  ReOrderApi({
    this.id,
    this.price,
    this.orderCount,
  });

  ReOrderApi.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        price = json['Price'],
        orderCount = json['OrderCount'];

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "Price": price,
      "OrderCount": orderCount,
    };
  }
}
