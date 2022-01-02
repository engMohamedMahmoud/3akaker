import 'package:aakaker/screens/home/components/home_services/bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aakaker/screens/home/components/productcontainer.dart';
import 'package:aakaker/screens/search_and_see_all/components/test.dart';
import 'package:aakaker/screens/home/components/home_services/model.dart';


class MySearchApp extends StatelessWidget {
  final String selectedType;
  MySearchApp(this.selectedType);





  @override
  Widget build(BuildContext context) {
    return Provider<PhotoBloc>(
        create: (context) => PhotoBloc(selectedType),
        dispose: (context, bloc) => bloc.dispose(),
        child:  paganationTabs(selectedType)

    );
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

    maTypes.addAll(List.generate(50, (x) => x));

    types = {};
    //
  }



  bool onNotification(ScrollNotification scrollInfo, PhotoBloc bloc) {
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
      return Center(child: CircularProgressIndicator());
    }

    types.addAll(snapshot.data);

    return GridView.builder(
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
            product: types.elementAt(index)
        );
      },
    );



  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<PhotoBloc>(context);

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
