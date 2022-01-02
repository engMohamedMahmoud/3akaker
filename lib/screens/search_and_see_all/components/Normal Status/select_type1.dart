// import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
// import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:aakaker/size_config.dart';
import 'package:aakaker/screens/home/components/example_tab_bar.dart';
import 'package:aakaker/constants.dart';
import 'package:flutter_offline/flutter_offline.dart';




class TabButtons extends StatefulWidget {

  @override
  _TabButtonsState createState() => _TabButtonsState();
}

class _TabButtonsState extends State<TabButtons> with WidgetsBindingObserver{



  String transcription = '';
  TabController _tabController;
  String type = "Medicine";





  @override
  void initState() {
    // _tabController = TabController(length: 2, vsync: this);

    super.initState();

  }



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {


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
        return Center(

          child: DefaultTabController(
              length: 2,
              child: Center(
                child: Column(
                  children: <Widget>[

                    SizedBox(height: getProportionateScreenWidth(20)),
                    Container(
                        padding: EdgeInsets.only(bottom: 15),
                        alignment: Alignment.center,


                        child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              // color: Colors.white
                            ),

                            child:Container(
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
                                      color: myColor
                                  ),
                                  labelColor: Colors.white,
                                  labelStyle: TextStyle(fontSize: 15),
                                  unselectedLabelColor: KTextColor,
                                  tabs: [
                                    // first tab [you can add an icon using the icon property]
                                    Tab(
                                      text: AppLocalizations.of(context).translate("Medicines"),
                                    ),

                                    // second tab [you can add an icon using the icon property]
                                    Tab(
                                      text: AppLocalizations.of(context).translate("Cosmetics"),
                                    ),
                                  ],
                                ),
                              ),
                            )

                        )),
                    SizedBox(height: getProportionateScreenWidth(10)),

                    Expanded(
                      child: TabBarView(

                        controller: _tabController,
                        children: <Widget>[
                          MyApp12("Medicine"),
                          MyApp12("Cosmetic"),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenWidth(20)),
                  ],
                ),
              )),
        );
      },
    );




  }



}


