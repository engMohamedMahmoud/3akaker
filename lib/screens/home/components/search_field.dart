import 'package:flutter/material.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/search_and_see_all/search_see_all_screen.dart';

import '../../../size_config.dart';

// class SearchField extends StatelessWidget {
//   const SearchField({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: SizeConfig.screenWidth * 0.8,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(30),
//       ),
//       child: TextField(
//         onChanged: (value) => print(value),
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(
//                 horizontal: getProportionateScreenWidth(40),
//                 vertical: getProportionateScreenWidth(18)),
//             // border: InputBorder.none,
//             // focusedBorder: InputBorder.none,
//             // enabledBorder: InputBorder.none,
//             hintText: "Search Medicine",
//             prefixIcon: Icon(Icons.search,)),
//       ),
//     );
//   }
// }

class SearchField extends StatefulWidget {
  SearchField({Key key}) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController controller = new TextEditingController();

  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: controller,

        onChanged: (value) {
          text = value;

          print(text);
          setState(() {

            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder:
                        (BuildContext context) =>
                    new SeeAllSearchScreen()));

          });
        },
        onTap: () {
          setState(() {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder:
                        (BuildContext context) =>
                    new SeeAllSearchScreen()));

          });
        },

        autofocus: false,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20),
                vertical: getProportionateScreenWidth(10)),
            // border: InputBorder.none,
            // focusedBorder: InputBorder.none,
            // enabledBorder: InputBorder.none,
            hintText: AppLocalizations.of(context).translate("Search Medicine"),
            prefixIcon: Icon(
              Icons.search,
            )),
      ),
    );
  }
}
