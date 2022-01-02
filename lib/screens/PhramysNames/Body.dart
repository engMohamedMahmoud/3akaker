import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:random_color/random_color.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../constants.dart';
import 'NetworkModel/NetworkNames.dart';
import 'NetworkModel/PharmaciesModel.dart';



class PharmaciesList extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {

    return Provider<OrdersBloc>(
        create: (context) => OrdersBloc(),
        dispose: (context, bloc) => bloc.dispose(),
        child: Body()
    );
  }
}


class Body extends StatefulWidget {
  Body({
    Key key
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}


class _BodyState extends State<Body> with WidgetsBindingObserver{
  int _count = 1;
  String notes;
  var textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  double _ratingStar = 0;





  Set<PharmaciesModel> types;
  Set<int> maTypes = {};
  var rating = 0.0;




  RandomColor _randomColor = RandomColor();
  Color _color;
  @override
  void initState() {
    setState(() {
       _color = _randomColor.randomColor();
    });
    super.initState();

    // maTypes.addAll(List.generate(20, (x) => x));

    types = {};
    //
  }



  bool onNotification(ScrollNotification scrollInfo, OrdersBloc bloc) {
    if (scrollInfo is OverscrollNotification) {
      bloc.sink.add(scrollInfo);

    }

    return false;
  }

  Widget buildListView(
      BuildContext context,
      AsyncSnapshot<List<PharmaciesModel>> snapshot,
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
                                    width: 50,
                                    height: 50,
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
                                          Padding(padding: EdgeInsets.only(left: 10,right: 10,top: 10),child: Container(height: 30,width: 200, color: Colors.black12,),),

                                        ],
                                      ),
                                      // SizedBox(height: 20),
                                    ],
                                  ),
                                  )
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
        ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemCount: snapshot.data.length,
          itemBuilder: (context, int index) {
            var appLanguage = Provider.of<AppLanguage>(context, listen: false);
            print("dddd ${types.elementAt(index).description.length}");
            return GestureDetector(
              onTap: () async {

                print("hello");

                SharedPreferences prefs = await SharedPreferences.getInstance();

                if(appLanguage.appLocal.languageCode == "en"){
                  prefs.setString('Pharmacy',types.elementAt(index).nameEn);
                }else{
                  prefs.setString('Pharmacy',types.elementAt(index).nameAr);
                }
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder:
                            (BuildContext context) =>
                        new HomeScreen()));




              },
              child:

              Container(
                padding: EdgeInsets.all(15.0),
                margin: EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0,top: 20.0),
                width: MediaQuery.of(context).size.width,

                decoration: BoxDecoration(
                  // color: Colors.white,
                  color: kPrimaryColor,
                  // color:  Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  border: Border.all(color: kPrimaryColor, width: 1.0),
                  borderRadius: BorderRadius.circular(25.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Column(

                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        SizedBox(height: 10,),
                        Container(child: Text(appLanguage.appLocal.languageCode == "en"?
                        types.elementAt(index).nameEn : types.elementAt(index).nameAr,
                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),width: MediaQuery.of(context).size.width / 2.0,),

                        SizedBox(height: 10,),
                        Container(child: Text(types.elementAt(index).description,

                          style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 16),),width: MediaQuery.of(context).size.width / 2.0 ,),
                      ],
                    ),

                    Center(child: Container(child: Image.network(
                      types.elementAt(index).picture,
                      height: 100,
                      width: 100,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent
                      loadingProgress) {
                        if (loadingProgress == null)
                          return child;
                        return Container(
                          padding: EdgeInsets.all(10.0),
                          // decoration: new BoxDecoration(shape: BoxShape.circle,),

                          height: 100,
                          width: 100,
                          alignment:appLanguage.appLocal.languageCode == 'en'? Alignment.topLeft: Alignment.topRight,
                          child: CircularProgressIndicator(
                            value: loadingProgress
                                .expectedTotalBytes !=
                                null
                                ? loadingProgress
                                .cumulativeBytesLoaded /
                                loadingProgress
                                    .expectedTotalBytes
                                : null,
                          ),
                        );
                      },
                    ),),)

                    // Positioned(child: Container(
                    //   // height: types.elementAt(index).nameAr.length > 30 || types.elementAt(index).nameEn.length > 30? 400: 100,
                    //   height: types.elementAt(index).description.length > 50? 150: 100,
                    //   margin: EdgeInsets.only(left: 5.0, right: 5.0,bottom: 5.0),
                    //
                    //
                    //
                    //   child: Image.network(
                    //     types.elementAt(index).picture,
                    //     height: types.elementAt(index).description.length > 50? 150: 100,
                    //     width: 100,
                    //     fit: BoxFit.fill,
                    //     loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent
                    //     loadingProgress) {
                    //       if (loadingProgress == null)
                    //         return child;
                    //       return Container(
                    //         padding: EdgeInsets.all(10.0),
                    //         // decoration: new BoxDecoration(shape: BoxShape.circle,),
                    //
                    //         height: 100,
                    //         width: 100,
                    //         alignment:appLanguage.appLocal.languageCode == 'en'? Alignment.topLeft: Alignment.topRight,
                    //         child: CircularProgressIndicator(
                    //           value: loadingProgress
                    //               .expectedTotalBytes !=
                    //               null
                    //               ? loadingProgress
                    //               .cumulativeBytesLoaded /
                    //               loadingProgress
                    //                   .expectedTotalBytes
                    //               : null,
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),left: 30,)





                  ],
                ),
              ),

            );




          },
        ) :
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,


          ),
          child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/images/nodata.png", height: 100,width: 100,fit: BoxFit.cover,),
                  SizedBox(height: 10,),
                  Text(

                    AppLocalizations.of(context).translate("No data Available"),style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 18),)
                ],
              )
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
      child: StreamBuilder<List<PharmaciesModel>>(
        stream: bloc.stream,
        builder: (context, AsyncSnapshot<List<PharmaciesModel>> snapshot) {
          return buildListView(context, snapshot);
        },
      ),
    );
  }



}




Widget _imageLoading(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(20.0),
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: 20,
      // separatorBuilder: (BuildContext context, int index) => Divider(height: 2),
      itemBuilder: (context, int index) {
        return Shimmer.fromColors(
            baseColor: Colors.black38,
            highlightColor: Colors.white,
            child: Container(
              padding: EdgeInsets.all(5.0),
              margin: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(5.0)
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(color: Colors.black12,width: 40,height: 40,),
                  SizedBox(width: 10,),
                  Container(color: Colors.black12,width: 100,height: 40,),
                ],
              ),
            )
        );
      },
    ),
  );
}