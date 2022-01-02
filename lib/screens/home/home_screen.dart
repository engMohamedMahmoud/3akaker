import 'package:flutter/material.dart';
import 'package:aakaker/components/coustom_bottom_nav_bar.dart';
import 'package:aakaker/enums.dart';
import 'package:aakaker/constants.dart';
import '../../size_config.dart';
import 'components/select_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aakaker/screens/Prescription/prescription.dart';




class HomeScreen extends StatelessWidget {
  static String routeName = "/home";


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return

      WillPopScope(
        onWillPop: () => Future.value(false),
    child:
      Scaffold(
      // appBar:
      // PreferredSize(
      //   //Here is the preferred height.
      //   preferredSize: Size.fromHeight(210.0),
      //   child:
      //       Column(
      //         children: [
      //           Container(
      //             decoration: BoxDecoration(
      //                 image: DecorationImage(
      //                     image: AssetImage("assets/images/bg1.jpg"), fit: BoxFit.cover),
      //                 borderRadius: BorderRadius.only(
      //                   bottomRight: Radius.circular(20.0),
      //                   bottomLeft: Radius.circular(20.0),
      //                 )),
      //             padding: EdgeInsets.only(bottom: getProportionateScreenWidth(15),top:getProportionateScreenWidth(40)),
      //             child: Stack(
      //               overflow: Overflow.visible,
      //               alignment: Alignment.center,
      //               children: [
      //                 // Image.asset(
      //                 //   "assets/images/bg1.jpg",
      //                 //   fit: BoxFit.cover,
      //                 //   width: double.infinity,
      //                 //
      //                 //
      //                 //   height: getProportionateScreenHeight(160.0),
      //                 // ),
      //
      //                 Column(
      //                   children: [
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Container(
      //                           width: 40,
      //                           height: 40,
      //                           margin: EdgeInsets.only(left: 20, right: 20),
      //                           decoration: BoxDecoration(
      //                             // color: const Color(0xff7c94b6),
      //                             borderRadius: BorderRadius.all(const Radius.circular(20)),
      //                             image: DecorationImage(
      //                               image: ExactAssetImage('assets/images/Profile Image.png'),
      //                               fit: BoxFit.cover,
      //                             ),
      //
      //                             border: Border.all(
      //                               color: Colors.white,
      //                               width: 1.0,
      //                             ),
      //                           ),
      //                         ),
      //                         Spacer(),
      //                         IconBtnWithCounter(
      //                           svgSrc: "assets/icons/white notification icon.svg",
      //                           numOfitem: 3,
      //                           press: () {
      //                             Navigator.pushNamed(context, NotificationsScreen.routeName);
      //                           },
      //                         ),
      //                         IconBtnWithCounter(
      //                           svgSrc: "assets/icons/white cart icon.svg",
      //                           press: () => Navigator.pushNamed(context, CartScreen.routeName),
      //                         ),
      //                       ],
      //                     ),
      //                     SizedBox(height: getProportionateScreenWidth(5)),
      //                     Container(alignment: Alignment.topLeft, padding: EdgeInsets.only(left: 20),child: Text(
      //                       "Hello Sara",
      //                       style: TextStyle(
      //                           color: Color.fromRGBO(255, 255, 255, 0.0), fontWeight: FontWeight.bold, fontSize: 18),
      //                     ),),
      //                     Container(alignment: Alignment.topLeft, padding: EdgeInsets.only(left: 20),child: Text(
      //                       "dd",
      //                       style: TextStyle(
      //                           color: Colors.transparent, fontWeight: FontWeight.bold, fontSize: 18),
      //                     ),),
      //
      //
      //                   ],
      //                 ),
      //                 Positioned(
      //                   bottom: getProportionateScreenWidth(-35),
      //                   child: SearchField(),
      //                 ),
      //
      //
      //
      //               ],
      //             ),
      //           ),
      //           // SizedBox(height: getProportionateScreenWidth(40)),
      //           // Example()
      //         ],
      //       ),
      //
      // ),


      body: TabButtons(),
      floatingActionButton: new FloatingActionButton(
        heroTag: "Mohamed",
        onPressed: (){Navigator.pushNamed(context, PrescriptionScreen.routeName);},
        child: SvgPicture.asset("assets/icons/Camera Icon.svg",color: Colors.white,),
        elevation: 4.0,
      ),


      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home,isActiveButton: true,),
      backgroundColor: Kbg,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    ));
  }
}








