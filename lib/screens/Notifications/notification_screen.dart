import 'package:flutter/material.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'components/body.dart';

class NotificationsScreen extends StatelessWidget {

  List<String> getDataSource(){
    var titles = List<String>.generate(100, (index) => "Item ${index + 1}");
    return titles;
  }
  static String routeName = "/notifications";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("Notifications"), style:TextStyle(color: KTextColor) ,),
        backgroundColor: Kbg,

        // actions: <Widget>[
        //   FlatButton(
        //     textColor: kPrimaryColor,
        //     onPressed: () {
        //
        //       var titles = getDataSource();
        //       titles.clear();
        //
        //
        //     },
        //     child: Text("Delete All"),
        //     shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
        //   ),
        // ],
      ),
      body: Body(titles: getDataSource(),),
      backgroundColor: KbackgroundColor,
      // floatingActionButton: new FloatingActionButton(
      //   onPressed: (){Navigator.pushNamed(context, PrescriptionScreen.routeName);},
      //   child: SvgPicture.asset("assets/icons/Camera Icon.svg",color: Colors.white,),
      //   elevation: 4.0,
      // ),
      // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.notifications),
    );
  }
}
