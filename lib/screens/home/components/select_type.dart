import 'dart:convert';

import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:aakaker/screens/cart/cart_screen.dart';
import 'package:aakaker/screens/cart/components/cart_view_model.dart';
import 'package:aakaker/screens/home/components/body.dart';
import 'package:aakaker/screens/home/components/icon_btn_with_counter.dart';
import 'package:aakaker/screens/search_and_see_all/search_see_all_screen.dart';
import 'package:aakaker/size_config.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

enum WidgetMarker { Medicine, Cosmetics }



class TabButtons extends StatefulWidget {
  // final String type;
  TabButtons({Key key}) : super(key: key);

  @override
  _TabButtonsState createState() => _TabButtonsState();
}

class _TabButtonsState extends State<TabButtons>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<bool> isSelected;
  String imagUrl;
  String name;
  String type = "Medicines";

  String cashImage;

  // String get _selectedType => type ?? "Medicines";

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _showMessageInScaffold(String message){
    try {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            // behavior: SnackBarBehavior.floating,
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(15),
            // ),
            backgroundColor: myColor,
            content: Text(message,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
            duration: Duration(seconds: 2, milliseconds: 500),
          )
      );
    } on Exception catch (e, s) {
      print(s);
    }
  }





  @override
  void initState() {


      if ((cashImage == null || cashImage == '') &&
          (imagUrl == null || imagUrl.length == 0)) {
        cashImage = "assets/icons/person.png";
      }
      getUserDetails();

    super.initState();


  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      if (prefs.getString("ProfilePicture") != null) {
        imagUrl = "${prefs.getString("ProfilePicture")}";
      }

      if (prefs.getString("FirstName") != "" &&
          prefs.getString("LastName") != "") {
        name = "${prefs.getString("FirstName")} ${prefs.getString("LastName")}";
      }
    });
  }



  @override
  Widget build(BuildContext context) {


    return



      OfflineBuilder(
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
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Kbg,
          body: DefaultTabController(
              length: 2,
              child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/bg1.jpg"),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                          )),
                      padding:
                      EdgeInsets.only(top: getProportionateScreenWidth(30)),
                      child: Stack(
                        clipBehavior: Clip.none, alignment: Alignment.center,
                        children: [


                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {

                                    }, // choose image on click of profile
                                    child: Container(
                                      margin:
                                      EdgeInsets.only(left: 20, right: 20),
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child:

                                      GestureDetector(
                                        onTap: (){


                                          if(imagUrl != null){
                                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                                              return DetailScreen(


                                                obj: imagUrl,
                                              );
                                            }));
                                          }else{
                                            Navigator.push(context, MaterialPageRoute(builder: (_) {
                                              return DetailScreen1();
                                            }));
                                          }
                                        },
                                        child: Hero(
                                          tag: "img1",
                                          child: imagUrl != null ?
                                          ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(25),

                                            child:
                                            Image.network(
                                              imagUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ) : ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(25),

                                            child: Image.asset(
                                              cashImage,
                                              color: Colors.white,

                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  GetBuilder<CartViewModel>(
                                    init: Get.find(),
                                    builder: (controller) => Container(
                                      padding:
                                      EdgeInsets.only(left: 10, right: 10),
                                      child: IconBtnWithCounter(
                                          svgSrc:
                                          "assets/icons/white cart icon.svg",
                                          numOfitem: controller.numberOfList,
                                          press: () {
                                            print("controller.numberOfList ${controller.numberOfList}");


                                            Navigator.of(context).pushReplacement(
                                                MaterialPageRoute(
                                                    builder:
                                                        (BuildContext context) =>
                                                    new CartScreen()));



                                          }),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: getProportionateScreenWidth(30)),
                            ],
                          ),
                          SizedBox(height: getProportionateScreenWidth(25)),
                          Positioned(
                              bottom: getProportionateScreenWidth(-20),
                              child:
                              GestureDetector(

                                child: Container(
                                    height: 50.0,
                                    width: SizeConfig.screenWidth * 0.8,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Icon(
                                          Icons.search_sharp,
                                          color: Colors.grey.withOpacity(0.7),
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: 20.0,
                                        ),
                                        Text(AppLocalizations.of(context).translate("Search Medicine"),style: TextStyle(color: Colors.grey,fontSize: 16),)
                                      ],
                                    )


                                ),
                                onTap: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                          new SeeAllSearchScreen()));
                                },
                              )

                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenWidth(40)),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            25.0,
                          ),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          // give the indicator a decoration (color and border radius)
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                              color: myColor),
                          labelColor: Colors.white,
                          unselectedLabelColor: KTextColor,
                          tabs: [
                            // first tab [you can add an icon using the icon property]
                            Tab(
                              text: AppLocalizations.of(context)
                                  .translate("Medicines"),
                            ),

                            // second tab [you can add an icon using the icon property]
                            Tab(
                              // text: AppLocalizations.of(context).translate("Cosmetics"),
                              child: Text(
                                AppLocalizations.of(context)
                                    .translate("Cosmetics"),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          Body(
                            selectedType: "Medicine",
                          ),
                          Body(
                            selectedType: "Cosmetic",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );

  }
}


class DetailScreen extends StatelessWidget {
  final String obj;
  DetailScreen({Key key, @required this.obj}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.clear, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          // title: Text(
          //   "assets/images/banar1.jpeg",
          //   style: TextStyle(color: kPrimaryColor),
          // ),
          backgroundColor: Colors.black,

        ),
        body: GestureDetector(
          child: Container(

            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Hero(
                tag: 'imageHero1fromUrl',
                child: Center(
                  child: Image.network(
                    obj,
                    // height: 200,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fill,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes !=
                              null
                              ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes
                              : null,
                        ),
                      );
                    },
                  ),
                )
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        )
    );
  }
}

class DetailScreen1 extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.clear, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          // title: Text(
          //   "assets/images/banar1.jpeg",
          //   style: TextStyle(color: kPrimaryColor),
          // ),
          backgroundColor: Colors.black,

        ),
        backgroundColor: Colors.black,
        body: GestureDetector(
          child: Container(
            color: Colors.black,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Hero(
                tag: 'imageHero1FromApp',
                child: Center(
                  child: Container(
                    child: Image.asset("assets/icons/person.png",height: 200,),
                  ),
                )
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        )
    );
  }
}
