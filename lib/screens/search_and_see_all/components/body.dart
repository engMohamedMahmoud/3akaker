import 'package:aakaker/helper/database_heloper/cart_model_product.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/screens/cart/components/cart_view_model.dart';
import 'package:aakaker/screens/details/details_screen.dart';
import 'package:aakaker/screens/home/components/productcontainer.dart';
import 'package:aakaker/screens/search_and_see_all/components/SearchWidget.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:aakaker/screens/home/components/example_tab_bar.dart';
import 'package:aakaker/screens/home/components/home_services/model.dart';
import 'package:aakaker/constants.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../size_config.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Normal Status/productsListForSearch.dart';





class SearchBody extends StatefulWidget {

  SearchBody({
    Key key,
  }) : super(key: key);

  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody>   {

  var _searchEdit = new TextEditingController();
  bool _isWriting = false;
  List<MyProduct> items = [];
  List<MyProduct> items1 = [];
  Future<List<MyProduct>> fliitered;
  List<dynamic> myData;
  MyProduct product;
  int _count = 1;




  Future<List<MyProduct>> getSearch(int albumId,String textSearch)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse("$url/Products/Filter/$textSearch/EN/$albumId"),headers: {"authorization":prefs.getString('token')});
    print("$url/Products/Filter/$textSearch/EN/$albumId");
    print(prefs.getString('token'));

    if(response.statusCode == 200){
      List jsonData = json.decode(response.body.toString());
      setState(() {
        myData = jsonData;
      });
      return jsonData.map((c) => MyProduct.fromJson(c)).toList();
    }else{
      throw Exception('Unexpected error occured!');
    }

  }


  @override
  void initState() {
    super.initState();
  }



  @override
  void dispose() {
    // _searchEdit.dispose();
    super.dispose();
    _searchEdit.dispose();
  }

  @override
  Widget build(BuildContext context)  {
    SizeConfig().init(context);




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

        var appLanguage = Provider.of<AppLanguage>(context,listen: false);

        return SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getProportionateScreenWidth(5)),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 0),
                  // width: SizeConfig.screenWidth * 0.8,
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(padding: EdgeInsets.all(5), child:

                  TextField(
                    controller: _searchEdit,
                    maxLength: 100,

                    onChanged:  (value )  {



                      // setState(() {
                      //
                      //   fliitered =  getSearch(0, value);
                      //
                      //   print(_isWriting);
                      //
                      //   print("Value is : $value");
                      // });


                      if (!_isWriting){
                        _isWriting = true;
                        print(_isWriting ? "Writing..." : "writing stopped");

                        setState(()  {

                          // fliitered =  getSearch(0, value);
                          // print("Value is : $value");

                        });

                        Future.delayed(Duration(milliseconds: 100)).whenComplete(() {
                          _isWriting = false;
                          setState(()  {
                            fliitered =  getSearch(0, value);
                            print(_isWriting);
                            print("Value is : $value");
                          });

                        });
                      }

                    },

                    onTap: (){

                      // MyAppSearch(editingController.text);
                    },
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: getProportionateScreenWidth(20),
                            vertical: getProportionateScreenWidth(10)),

                        hintText: AppLocalizations.of(context).translate("Search Medicine"),
                        counterStyle: TextStyle(color: Colors.transparent),

                        prefixIcon: Icon(Icons.search,)),

                  ),


                  ),
                ),

                SizedBox(height: getProportionateScreenWidth(20)),



                FutureBuilder<List<MyProduct>>(

                  future: fliitered,
                  builder: (context, snapshot) {

                    // print(snapshot.data.length);

                    if (!snapshot.hasData) {
                      return MyApp13("Medicine");
                    }
                    print("myData : ${snapshot.data.length}");

                    return myData.length > 0 ?
                    GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      padding: const EdgeInsets.all(20),
                      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 9.0),
                      itemBuilder:  (BuildContext context, int index) {

                        print("ff ${snapshot.data.elementAt(index).NameEN ?? ""}");


                        return

                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(
                                  context,
                                  DetailsScreen.routeName,
                                  arguments: ProductDetailsArguments(product: snapshot.data.elementAt(index)),
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

                                          tag: "image1 ${snapshot.data.elementAt(index).id}",
                                          child:
                                          Image.asset(
                                            (snapshot.data.elementAt(index).Type == "Medicine")? "assets/images/Medicon.png" : "assets/images/cos.png",
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
                                              appLanguage.appLocal.languageCode == "en" ? snapshot.data.elementAt(index).NameEN : snapshot.data.elementAt(index).NameAR,
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
                                                "${double.parse(snapshot.data.elementAt(index).Price.toStringAsFixed(2))}${AppLocalizations.of(context).translate("EGP")}",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.red,
                                                ),
                                              ),
                                              Spacer(),
                                              GetBuilder<CartViewModel>(
                                                init: CartViewModel(),
                                                builder: (controller) =>
                                                    InkWell(
                                                      splashColor: Colors.indigo,
                                                      borderRadius: BorderRadius.circular(50),
                                                      onTap: () {

                                                      },

                                                      child:  GestureDetector(
                                                        onTap: () {
                                                          // add to card
                                                          if (controller.cartProductModel.length == 0) {
                                                            controller.addProduct(
                                                                CartProductModel(
                                                                    id: snapshot.data.elementAt(index).id,
                                                                    title: snapshot.data.elementAt(index).NameEN,
                                                                    image: (snapshot.data.elementAt(index).Type == "Medicine")? "assets/images/Medicon.png" : "assets/images/cos.png",
                                                                    titleAr: snapshot.data.elementAt(index).NameAR,
                                                                    price: snapshot.data.elementAt(index).Price.toDouble(),
                                                                    count: _count),);
                                                          }
                                                          else {
                                                            bool test = ((controller.cartProductModel.singleWhere((it) => it.id == snapshot.data.elementAt(index).id,
                                                                orElse: () => null)) != null);


                                                            print("status $test");
                                                            if(test == true)  {

                                                              print('Already exists!');
                                                              for(int index = 0; index < controller.cartProductModel.length; index++){
                                                                if(snapshot.data.elementAt(index).id == controller.cartProductModel[index].id){

                                                                  print("found");
                                                                  controller.increaseQuantity(index);
                                                                  break;
                                                                }
                                                              }


                                                            } else {
                                                              print('Added!');
                                                              controller.addProduct(
                                                                  CartProductModel(
                                                                      id: snapshot.data.elementAt(index).id,
                                                                      title: snapshot.data.elementAt(index).NameEN,
                                                                      image: (snapshot.data.elementAt(index).Type == "Medicine")? "assets/images/Medicon.png" : "assets/images/cos.png",
                                                                      titleAr: snapshot.data.elementAt(index).NameAR,
                                                                      price: snapshot.data.elementAt(index).Price.toDouble(),
                                                                      count: _count));
                                                            }





                                                            print("product.id ${snapshot.data.elementAt(index).id}");
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
                          )  ;

                          // Text(
                          //   snapshot.data.elementAt(index).NameEN,
                          //   textScaleFactor: 1.3,
                          // );

                          // ProductContainer(product: snapshot.data.elementAt(index));



                      },
                    ) :Container(
                      alignment: Alignment.center,
                      child: Text(
                        AppLocalizations.of(context).translate("No Search Result"),
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),);

                  },
                ),

              ],
            ),
          ),
        );
      },
    );

  }





}






