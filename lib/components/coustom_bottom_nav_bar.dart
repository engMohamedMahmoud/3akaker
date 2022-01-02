import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:aakaker/screens/Orders/Order_List/order_screen.dart';
import 'package:aakaker/screens/Settings/settings_screen.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import 'package:aakaker/screens/profile/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../enums.dart';



class CustomBottomNavBar extends StatefulWidget {

  final MenuState selectedMenu;
  final bool isActiveButton;
  CustomBottomNavBar({
    Key key, this.selectedMenu, this.isActiveButton,
  }) : super(key: key);

  @override
  _CustomBottomNavBarState createState() => _CustomBottomNavBarState(selectedMenu,isActiveButton);
}


class _CustomBottomNavBarState extends State<CustomBottomNavBar>   {




  MenuState selectedMenu;

  bool isActiveButton;

  _CustomBottomNavBarState(this.selectedMenu,this.isActiveButton);

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/icons/home.svg",
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: (){
                    // Navigator.pushNamed(context, HomeScreen.routeName);
                  setState(() {
                    isActiveButton = true;
                    print("isActiveButton $isActiveButton");
                  });
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder:
                                (BuildContext context) =>
                            new HomeScreen()));
                }
              ),
              // Spacer(),

              IconButton(
                  icon: SvgPicture.asset("assets/icons/Bell.svg",color: inActiveIconColor,height: 20,width: 20,),
                  color:  inActiveIconColor,
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    if (prefs.getString('_id') != "" ){

                      setState(() {
                        isActiveButton = true;
                      });

                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder:
                                  (BuildContext context) =>
                              new OrdersScreen(id: prefs.getString("_id"))));

                      // final navigator = Navigator.of(context);
                      // await navigator.push(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         OrdersScreen(id: prefs.getString("_id")),
                      //   ),
                      // );
                    }
                  }

                // Navigator.pushNamed(context, UserControllersSettingsScreen.routeName),
              ),


              IconButton(
                icon: SvgPicture.asset("assets/icons/Settings.svg", color: inActiveIconColor,),
                color:  inActiveIconColor,

                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();

                  if(prefs.getString('Number') != "" && prefs.getString('Email') != "" && prefs.getString("FirstName") != "" &&  prefs.getString("LastName") != ""){
                    // final navigator = Navigator.of(context);
                    // await navigator.push(
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         MySettingsScreen(phoneNumber:  prefs.getString('Number'), email: prefs.getString('Email'), firstName: prefs.getString("FirstName"), lastName: prefs.getString("LastName")),
                    //   ),
                    // );
                    setState(() {
                      isActiveButton = true;
                    });

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder:
                                (BuildContext context) =>
                            new MySettingsScreen(phoneNumber:  prefs.getString('Number'), email: prefs.getString('Email'), firstName: prefs.getString("FirstName"), lastName: prefs.getString("LastName"))));



                  }
                },
              ),




              IconButton(
                  icon: SvgPicture.asset(
                    "assets/icons/nav user icon.svg",
                    color: MenuState.profile == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor,
                  ),
                  onPressed: isActiveButton == true?
                      () {
                    setState(() {
                      print("kkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                      isActiveButton = false;
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder:
                                  (BuildContext context) =>
                              new ProfileScreen()));
                      print(isActiveButton);
                    });
                  }: (){
                    print("here");
                  },

              )






            ],
          )),
    );
  }
}
