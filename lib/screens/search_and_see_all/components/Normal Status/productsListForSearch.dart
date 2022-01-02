import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/home/components/home_services/model.dart';
import 'package:aakaker/screens/home/components/productcontainer.dart';
import 'package:aakaker/screens/search_and_see_all/components/Normal%20Status/searchBloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';



class MyApp13 extends StatelessWidget {
  final String selectedType;

  MyApp13(this.selectedType);

  @override
  Widget build(BuildContext context) {
    return Provider<MySearchBloc>(
        create: (context) => MySearchBloc(selectedType),
        dispose: (context, bloc) => bloc.dispose(),
        child: paganationTabs(selectedType));
  }
}

class paganationTabs extends StatefulWidget {
  final String selectedType;

  paganationTabs(this.selectedType);

  @override
  _paganationTabsState createState() => _paganationTabsState(selectedType);
}

class _paganationTabsState extends State<paganationTabs> {
  String selectedType;
  Set<MyProduct> types;
  Set<int> maTypes = {};

  String get _selectedType => selectedType ?? "Medicines";

  _paganationTabsState(this.selectedType);

  @override
  void initState() {
    super.initState();

    // maTypes.addAll(List.generate(50, (x) => x));

    types = {};
    //
  }

  bool onNotification(ScrollNotification scrollInfo, MySearchBloc bloc) {
    if (scrollInfo is OverscrollNotification) {
      bloc.sink.add(scrollInfo);
    }

    return false;
  }

  Widget buildListView(
      BuildContext context,
      AsyncSnapshot<List<MyProduct>> snapshot,
      ) {
    if (!snapshot.hasData) {
      return GridView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: 20,
        padding: EdgeInsets.only(left: 20, right: 20),
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 9.0
        ),
        itemBuilder: (BuildContext context,int index){
          return Shimmer.fromColors(
              baseColor: Colors.black38,
              highlightColor: Colors.white,
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(246, 246, 248, 1.0),
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(color: Colors.black12, width: 1.0),
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
                            color: Colors.black12,
                            // borderRadius: BorderRadius.circular(15),
                          ),
                          child:
                          // (product.Type == "Medicine")?
                          Center(
                            child: Container(
                              height: 80,
                              width: 80.0,
                              color: Colors.black12,
                            ),
                          )

                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(top: 5, bottom: 5,right: 10,left: 10),
                      decoration: BoxDecoration(
                        // color: Colors.white,
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
                            Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5,right: 10,left: 10),

                              child: Container(
                                height: 10,
                                width: 120.0,
                                color: Colors.black12,

                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, bottom: 5,right: 10,left: 10),

                              child: Container(
                                height: 10,
                                width: 120.0,
                                color: Colors.black12,

                              ),
                            ),

                          ]),
                    )
                  ],
                ),
              )
          );
        },
      );
    }

    types.addAll(snapshot.data);

    return
      // snapshot.data.length > 0?
      GridView.builder(
        // padding: const EdgeInsets.all(15),
        shrinkWrap: true,
        // primary: false,
        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        // itemCount: (selectedType == "Medicine") ?
        // (maTypes.length > types.length) ? types.length + 1 : types.length : types.length,
        itemCount: types.length,
        // (maTypes.length > types.length) ? types.length + 1 : types.length,
        // padding: const EdgeInsets.all(20),
        padding: EdgeInsets.only(left: 20, right: 20),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.0,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 9.0),
        itemBuilder: (BuildContext context, int index) {
          return ProductContainer(
            product: types.elementAt(index),
          );
        },
      )
    // :
    //   Container(
    //     width: MediaQuery.of(context).size.width,
    //     height: 200,
    //     decoration: BoxDecoration(
    //       shape: BoxShape.circle,
    //
    //
    //     ),
    //     child: Center(
    //         child: Column(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           mainAxisAlignment: MainAxisAlignment.start,
    //           children: [
    //             Image.asset("assets/images/nodata.png", height: 100,width: 100,fit: BoxFit.cover,),
    //             SizedBox(height: 10,),
    //             Text(
    //
    //               AppLocalizations.of(context).translate("No data Available"),style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 18),)
    //           ],
    //         )
    //     ),
    //   )
        ;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<MySearchBloc>(context);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) => onNotification(notification, bloc),
      child: StreamBuilder<List<MyProduct>>(
        stream: bloc.stream,
        builder: (context, AsyncSnapshot<List<MyProduct>> snapshot) {
          return buildListView(context, snapshot);
        },
      ),
    );
  }
}