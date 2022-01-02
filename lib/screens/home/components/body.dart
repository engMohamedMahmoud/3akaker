import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/home/components/example_tab_bar.dart';
import 'package:aakaker/screens/home/components/section_title.dart';
import 'package:aakaker/screens/search_and_see_all/components/Normal%20Status/displayAllProducts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'BannarModel.dart';
import 'discount_banner.dart';



class Body extends StatefulWidget {
  final String selectedType;

  const Body({Key key, @required this.selectedType}) : super(key: key);
  @override
  _BodyState createState() => _BodyState(selectedType);
}

class _BodyState extends State<Body> {


  List<bool> isSelected;
  int index;
  String selectedType;

  _BodyState(this.selectedType);

  String get _selectedType => selectedType ?? "Medicines";





  @override
  void initState() {

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    // You have to call SizeConfig on your starting page
    SizeConfig().init(context);
    // double defaultSize = SizeConfig.defaultSize;
    return SafeArea(
      child: SingleChildScrollView(
        // padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // SizedBox(height: getProportionateScreenWidth(10)),
            DiscountBanner1(),

            SizedBox(height: getProportionateScreenWidth(15)),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  SectionTitle(
                      title: selectedType == "Medicine" ? AppLocalizations.of(
                          context).translate("Medicines") : AppLocalizations
                          .of(context).translate("Cosmetics"),
                      press: () {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder:
                                    (BuildContext context) =>
                                new DisplayAllSearchScreen(
                                )));
                      }),
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder:
                                  (BuildContext context) =>
                              new DisplayAllSearchScreen(
                              )));
                    },
                    child: Text(
                      AppLocalizations.of(context).translate("See All"),
                      style: TextStyle(
                          fontSize: getProportionateScreenWidth(12),
                          color: KTextColor),
                    ),
                  )
                ],
              ),
            ),






            SizedBox(height: getProportionateScreenWidth(20)),
            MyApp12(selectedType),
            SizedBox(height: getProportionateScreenWidth(30)),
            // (selectedType == "Medicine" || selectedType == "Cosmatics")? MyApp12(selectedType) : MySearchResult12(selectedType),
          ],
        ),
      ),
    );
  }






}


