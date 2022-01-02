// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:phrama/screens/home/components/productcontainer.dart';
// import 'home_services/bloc.dart';
// import 'home_services/model.dart';
//
// class MySearchResult12 extends StatelessWidget {
//   final String textSearch;
//   MySearchResult12(this.textSearch);
//
//
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Provider<SearchResultBloc>(
//         builder: (context) => SearchResultBloc(textSearch),
//         dispose: (context, bloc) => bloc.dispose(),
//         child:  paganationTabs(textSearch)
//
//     );
//   }
// }
//
// class paganationTabs extends StatefulWidget {
//
//   final String textSearch;
//   paganationTabs(this.textSearch);
//
//   @override
//   _paganationTabsState createState() => _paganationTabsState(textSearch);
// }
//
// class _paganationTabsState extends State<paganationTabs> {
//
//
//
//   String textSearch;
//   List<Product> types;
//   List<int> maTypes = [];
//
//
//   _paganationTabsState(this.textSearch);
//   @override
//   void initState() {
//
//     super.initState();
//
//     maTypes.addAll(List.generate(50, (x) => x));
//
//     types = [];
//     //
//   }
//
//
//
//   bool onNotification(ScrollNotification scrollInfo, SearchResultBloc bloc) {
//     // print(scrollInfo);
//     if (scrollInfo is OverscrollNotification) {
//       bloc.sink.add(scrollInfo);
//
//
//     }
//
//     return false;
//   }
//
//
//
//   Widget buildListView(
//       BuildContext context,
//       AsyncSnapshot<List<Product>> snapshot,
//       ) {
//     if (!snapshot.hasData) {
//       return Center(child: CircularProgressIndicator());
//     }
//
//     types.addAll(snapshot.data);
//
//     return GridView.builder(
//       // padding: const EdgeInsets.all(15),
//       shrinkWrap: true,
//       // primary: false,
//       physics: ScrollPhysics(),
//       scrollDirection: Axis.vertical,
//       itemCount: (textSearch == "Medicine") ?
//       (maTypes.length > types.length) ? types.length + 1 : types.length : types.length,
//       padding: const EdgeInsets.all(20),
//       gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           childAspectRatio: 0.7,
//           crossAxisSpacing: 10.0,
//           mainAxisSpacing: 10.0),
//       itemBuilder: (BuildContext context, int index) {
//         return ProductContainer(
//             product: types[index]
//         );
//       },
//     );
//
//
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = Provider.of<SearchResultBloc>(context);
//
//     return NotificationListener<ScrollNotification>(
//       onNotification: (notification) => onNotification(notification, bloc),
//       child: StreamBuilder<List<Product>>(
//         stream: bloc.stream,
//         builder: (context, AsyncSnapshot<List<Product>> snapshot) {
//           return buildListView(context, snapshot);
//         },
//       ),
//     );
//   }
// }
