import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import '../../../size_config.dart';
import 'package:async/async.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../size_config.dart';
import 'BannarModel.dart';

class DiscountBanner1 extends StatefulWidget {

  DiscountBanner1({
    Key key,
  }) : super(key: key);

  @override
  _DiscountBannerState createState() => _DiscountBannerState();
}

class _DiscountBannerState extends State<DiscountBanner1>  {


  String img;
  Advert obj;
  String imageId;
  CarouselSlider carouselSlider;
  int _current = 0;
  Future<List<BannarModel>> _bannarsList;

  Future<List<BannarModel>> fetchBannars() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse("$url/Advertising/EN"),
        headers: {"authorization":prefs.getString('token')});

    print("$url/Advertising/EN");
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {

      List data = json.decode(response.body);
      print(data);

      return data.map((data) => new BannarModel.fromMap(data)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      _bannarsList = fetchBannars();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return

      FutureBuilder<List<BannarModel>>(
        future: _bannarsList,
        builder: (context, snapshot) {


          print(snapshot.hasData);

          if (!snapshot.hasData) {
            return Shimmer.fromColors(
                baseColor: Colors.black38,
                highlightColor: Colors.white,
                child: Container(


                  height: 110,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(right: 10,left: 10),

                  decoration: BoxDecoration(
                    color: Colors.black26,
                    // color: Color.fromRGBO(246, 246, 248, 1.0),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.black12, width: 1.0),
                  ),
                ));
          }


          return

            snapshot.data.length > 0 ?
            GestureDetector(
              child: Container(
                height: 170,
                width: double.infinity,
                margin: EdgeInsets.only(
                    left: getProportionateScreenWidth(5),
                    right: getProportionateScreenWidth(5)),

                child: Builder(
                  builder: (context) {
                    final double height = MediaQuery.of(context).size.height;

                    return
                      (snapshot.data.length != 0)?
                      CarouselSlider(
                        options: CarouselOptions(
                          height: height,
                          viewportFraction: 1.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                        ),
                        items: snapshot.data.map((item) {

                          img = item.picture;


                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(right: 10,left: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.0)

                                  ),
                                  child: GestureDetector(
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8.0),
                                          child:

                                          Image.network(
                                            item.picture,
                                            width: 110.0,
                                            height: 110.0,
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
                                          )
                                      ),
                                      onTap: () {


                                        if (img != null){
                                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                                            return DetailScreen(

                                              obj: item.picture,
                                              // image: 'assets/images/banar1.jpeg',
                                            );
                                          }));
                                        }else{
                                          Navigator.push(context, MaterialPageRoute(builder: (_) {
                                            return DetailScreen1();
                                          }));
                                        }


                                      }));
                            },
                          );

                          return


                            Container(
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child:

                                  Image.network(
                                    img,
                                    fit: BoxFit.fill,
                                    width: height,
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
                                  )
                              ),

                            );

                        }


                        ).toList(),
                      ) :
                      Padding(padding: EdgeInsets.only(right: 20,left: 20),child:ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: CircularProgressIndicator(),
                      ))

                    ;
                  },
                ),

              ),

            ) :
            Container();



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
          icon: Icon(Icons.clear, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        // title: Text(
        //   "assets/images/banar1.jpeg",
        //   style: TextStyle(color: kPrimaryColor),
        // ),
        backgroundColor: Colors.white,

      ),
      body: GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Hero(
              tag: 'imageHero',
              child: Image.network(
                obj,
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width,
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
            icon: Icon(Icons.clear, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
          // title: Text(
          //   "assets/images/banar1.jpeg",
          //   style: TextStyle(color: kPrimaryColor),
          // ),
          backgroundColor: Colors.white,

        ),
        body: GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Hero(
                tag: 'imageHero1',
                child: Image.asset('assets/images/banar1.jpeg')
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        )
    );
  }
}




class Advert {
  final String id, Picture;

  Advert({this.id,this.Picture});

  Advert.fromJson(Map json)
      : this.id = json["_id"],
        this.Picture = json["Picture"];
}