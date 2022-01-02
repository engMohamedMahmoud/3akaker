// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:phrama/localization/AppLanguage.dart';
// import 'package:phrama/localization/app_localizations.dart';
// import 'package:phrama/screens/details/components/counter.dart';
// import 'package:phrama/screens/home/components/home_services/model.dart';
// import 'package:provider/provider.dart';
//
// import '../../../constants.dart';
// import '../../../size_config.dart';
//
// class ProductDescription extends StatelessWidget {
//   const ProductDescription({
//     Key key,
//     @required this.product,
//     this.pressOnSeeMore,
//   }) : super(key: key);
//
//   final Product product;
//   final GestureTapCallback pressOnSeeMore;
//
//   @override
//   Widget build(BuildContext context) {
//     var appLanguage = Provider.of<AppLanguage>(context);
//     return
//       Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding:
//           EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
//           child: Column(
//             children: [
//               Align(
//                 alignment:(appLanguage.appLocal.languageCode  == "en")?  Alignment.centerLeft: Alignment.centerRight,
//
//                 child: Text(appLanguage.appLocal.languageCode  == "en" ? product.NameEN : product.NameAR, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: KTextColor),),
//               ),
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Row(
//                   children: <Widget>[
//                     Text(
//                      AppLocalizations.of(context).translate( "Made by "),
//                       textAlign: TextAlign.left,
//                       style: TextStyle(fontWeight: FontWeight.normal,fontSize: 15),
//                     ),
//                     Expanded(
//                         child: Text(
//                           appLanguage.appLocal.languageCode  == "en" ? product.NameEN : product.NameAR,
//                           textDirection: TextDirection.ltr,
//                           textAlign: appLanguage.appLocal.languageCode == "en"? TextAlign.left : TextAlign.right,
//                           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: KTextColor),
//                         ))
//                   ],
//                 ),
//               ),
//
//             ],
//           ),
//
//         ),
//         Padding(
//           padding: EdgeInsets.all(20),
//           child:Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               Text(
//                 "${product.Price} ${AppLocalizations.of(context).translate("EGP")}",
//                 textAlign: TextAlign.left,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
//               ),
//               Spacer(),
//               Counter(),
//             ],
//           ),),
//
//         Padding(
//           padding: EdgeInsets.all(20),
//           // child: Text(
//           //   product.description, style: TextStyle(color: Colors.black54,fontWeight: FontWeight.normal,fontSize: 18),
//           //   maxLines: 10,
//           // ),
//         ),
//
//       ],
//     );
//   }
// }
