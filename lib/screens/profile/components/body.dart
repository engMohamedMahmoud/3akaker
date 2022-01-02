import 'package:aakaker/screens/home/components/select_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/main.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:aakaker/screens/Orders/Order_List/order_screen.dart';
import 'package:aakaker/screens/Settings/settings_screen.dart';
import 'package:aakaker/screens/rest_password/Change_Password/change_user_password_screen.dart';
import 'package:aakaker/screens/sign_in/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'profile_menu.dart';





class Body extends StatefulWidget {
  Body({Key key}) : super(key: key);

  @override
  _BodysState createState() => _BodysState();
}

class _BodysState extends State<Body> {


  String imagUrl;
  String name;

  @override
  void initState() {
    getUserDetails();
    // TODO: implement initState
    super.initState();



  }

  getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();


    setState(() {

      if(prefs.getString("ProfilePicture") != null){
        imagUrl = "${prefs.getString("ProfilePicture")}";
      }

      if (prefs.getString("FirstName") != "" &&  prefs.getString("LastName") != ""){
        name = "${prefs.getString("FirstName")} ${prefs.getString("LastName")}";
      }
    });

  }

  @override
  Widget build(BuildContext context) {

    return OfflineBuilder(
      connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
          ) {
        if (connectivity == ConnectivityResult.none) {
          return BodyConnection();
        }
        else {
          return child;
        }
      },
      builder: (BuildContext context) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [


              SizedBox(height: 60),


              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  // onTap: () => onProfileClick(context), // choose image on click of profile
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20),

                    child:
                    (imagUrl == null)? const ProfileUserDetailsWidget(): ClipRRect(
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(50),
                      // ),
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        imagUrl,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onTap: (){

                    //// image profile
                    if(imagUrl != null){
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return DetailScreen(


                          obj: imagUrl,
                        );
                      }));
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return DetailScreen1();
                      }));
                    }
                  },



                ),
              ),

              SizedBox(height: 5),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    (name != "")? "$name" : "${AppLocalizations.of(context).translate("Hello Dear User")}",textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  )
              ),
              SizedBox(height: 20),
              ProfileMenu(
                text:  AppLocalizations.of(context).translate("myOrders"),
                icon: "assets/icons/Bell.svg",
                press: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  if (prefs.getString('_id') != "" ){

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder:
                                (BuildContext context) =>
                            new OrdersScreen(id: prefs.getString("_id"))));

                  }
                },
              ),

              ProfileMenu(
                text:  AppLocalizations.of(context).translate("Settings"),
                icon: "assets/icons/Settings.svg",
                press: () async {

                  SharedPreferences prefs = await SharedPreferences.getInstance();

                  if(prefs.getString('Number') != "" && prefs.getString('Email') != "" && prefs.getString("FirstName") != "" &&  prefs.getString("LastName") != ""){
                    // final navigator = Navigator.of(context);
                    // await navigator.push(
                    //   MaterialPageRoute(
                    //     builder: (context) =>
                    //         MySettingsScreen(phoneNumber:  prefs.getString('Number'), email: prefs.getString('Email'), firstName: prefs.getString("FirstName"), lastName: prefs.getString("LastName")),
                    //   ),
                    // );

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder:
                                (BuildContext context) =>
                            new MySettingsScreen(phoneNumber:  prefs.getString('Number'), email: prefs.getString('Email'), firstName: prefs.getString("FirstName"), lastName: prefs.getString("LastName"))));

                  }



                },
              ),
              ProfileMenu(
                text:  AppLocalizations.of(context).translate("Reset Password"),
                icon: "assets/icons/Settings.svg",
                press: () async {

                  SharedPreferences prefs = await SharedPreferences.getInstance();

                  // final navigator = Navigator.of(context);
                  // await navigator.push(
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         RestUserPasswordScreen(phoneNumber:  prefs.getString('Number'),),
                  //   ),
                  // );

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder:
                              (BuildContext context) =>
                          new RestUserPasswordScreen(phoneNumber:  prefs.getString('Number'),
                          )));




                },
              ),
              ProfileMenu(
                text: AppLocalizations.of(context).translate('language'),
                icon: "assets/icons/Question mark.svg",
                press: () {
                  _changeLanguageApp(context);
                },
              ),



              ProfileMenu(
                text: AppLocalizations.of(context).translate("Log Out"),
                icon: "assets/icons/Log out.svg",
                press: () async {


                  setState(() async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('token');
                    prefs.remove('_id');
                    prefs.remove('FirstName');
                    prefs.remove('LastName');
                    prefs.remove('Email');
                    prefs.remove('Number');
                    prefs.remove("ProfilePicture");
                    prefs.remove('Pharmacy');
                    if (prefs.getString('token') == null && prefs.getString("ProfilePicture") == null){
                      Navigator.pushNamed(context, SignInScreen.routeName);
                      print("the pic: ${prefs.getString('token')}");
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder:
                                  (BuildContext context) =>
                              new SignInScreen(
                              )));

                    }

                  });




                },
              ),
              // SettingsLanguagePage(),
            ],
          ),
        );
      },
    );

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [


          SizedBox(height: 60),

          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              // onTap: () => onProfileClick(context), // choose image on click of profile
              child: Container(
                margin: EdgeInsets.only(left: 20, right: 20),

                child: (imagUrl == null)? const ProfileUserDetailsWidget():
                ClipRRect(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(50),
                  // ),
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    imagUrl,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 5),
          Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Text(
                (name != "")? "$name" : "${AppLocalizations.of(context).translate("Hello Dear User")}",textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 16),
              )
          ),
          SizedBox(height: 20),
          ProfileMenu(
            text:  AppLocalizations.of(context).translate("myOrders"),
            icon: "assets/icons/Bell.svg",
            press: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (prefs.getString('_id') != "" ){
                final navigator = Navigator.of(context);
                await navigator.push(
                  MaterialPageRoute(
                    builder: (context) =>
                        OrdersScreen(id: prefs.getString("_id")),
                  ),
                );
              }
            },
          ),

          ProfileMenu(
            text:  AppLocalizations.of(context).translate("Settings"),
            icon: "assets/icons/Settings.svg",
            press: () async {

              SharedPreferences prefs = await SharedPreferences.getInstance();

              if(prefs.getString('Number') != "" && prefs.getString('Email') != "" && prefs.getString("FirstName") != "" &&  prefs.getString("LastName") != ""){
                final navigator = Navigator.of(context);
                await navigator.push(
                  MaterialPageRoute(
                    builder: (context) =>
                        MySettingsScreen(phoneNumber:  prefs.getString('Number'), email: prefs.getString('Email'), firstName: prefs.getString("FirstName"), lastName: prefs.getString("LastName")),
                  ),
                );
              }



            },
          ),
          ProfileMenu(
            text:  AppLocalizations.of(context).translate("Reset Password"),
            icon: "assets/icons/Settings.svg",
            press: () async {

              SharedPreferences prefs = await SharedPreferences.getInstance();

              final navigator = Navigator.of(context);
              await navigator.push(
                MaterialPageRoute(
                  builder: (context) =>
                      RestUserPasswordScreen(phoneNumber:  prefs.getString('Number'),),
                ),
              );




            },
          ),
          ProfileMenu(
            text: AppLocalizations.of(context).translate('language'),
            icon: "assets/icons/Question mark.svg",
            press: () {
              _changeLanguageApp(context);
            },
          ),



          ProfileMenu(
            text: AppLocalizations.of(context).translate("Log Out"),
            icon: "assets/icons/Log out.svg",
            press: () async {


              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('token');
              prefs.remove('_id');
              prefs.remove('FirstName');
              prefs.remove('LastName');
              prefs.remove('Email');
              prefs.remove('Number');
              prefs.remove("ProfilePicture");
              if (prefs.getString('token') == null && prefs.getString("ProfilePicture") == null){
                Navigator.pushNamed(context, SignInScreen.routeName);
                print("the pic: ${prefs.getString('token')}");
              }



              // Alert(
              //   context: context,
              //   type: AlertType.warning,
              //   title: AppLocalizations.of(context).translate("Go out"),
              //   desc: AppLocalizations.of(context).translate("Are you Sure ?"),
              //   buttons: [
              //     DialogButton(
              //       child: Text(
              //         AppLocalizations.of(context).translate("Ok"),
              //         style: TextStyle(color: Colors.white, fontSize: 20),
              //       ),
              //       onPressed: () async {
              //         SharedPreferences prefs = await SharedPreferences.getInstance();
              //         prefs.remove('token');
              //         prefs.remove('_id');
              //         prefs.remove('FirstName');
              //         prefs.remove('LastName');
              //         prefs.remove('Email');
              //         prefs.remove('Number');
              //         prefs.remove("ProfilePicture");
              //
              //         Navigator.pushNamed(context, SignInScreen.routeName);
              //
              //       },
              //       color: Color.fromRGBO(0, 179, 134, 1.0),
              //     ),
              //     DialogButton(
              //       child: Text(
              //         AppLocalizations.of(context).translate("Cancel"),
              //         style: TextStyle(color: Colors.white, fontSize: 20),
              //       ),
              //       onPressed: () => Navigator.pop(context),
              //       color: Colors.red,
              //       // gradient: LinearGradient(colors: [
              //       //   Color.fromRGBO(116, 116, 191, 1.0),
              //       //   Color.fromRGBO(52, 138, 199, 1.0)
              //       // ]),
              //     )
              //   ],
              // ).show();


            },
          ),
          // SettingsLanguagePage(),
        ],
      ),
    );
  }

  void _changeLanguageApp(context) {
    var appLanguage = Provider.of<AppLanguage>(context,listen: false) ;
    var assetsImageAR = new AssetImage('assets/images/arabic.png'); //<- Creates an object that fetches an image.
    var imageARabic = new Image(image: assetsImageAR,height: 50,width: 50,);
    var assetsImageEn = new AssetImage('assets/images/english.png'); //<- Creates an object that fetches an image.
    var imageEnglish = new Image(image: assetsImageEn,width: 50, height:50,);



    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: imageEnglish,
                      title: new Text('English'),
                      onTap: () {
                        appLanguage.changeLanguage(Locale("en"));
                        MyApp(appLanguage: appLanguage,);
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: imageARabic,
                    title: new Text('العربية'),
                    onTap: () {
                      appLanguage.changeLanguage(Locale("ar"));
                      MyApp(appLanguage: appLanguage);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}


class ProfileUserDetailsWidget extends StatelessWidget {
  const ProfileUserDetailsWidget();




  @override
  Widget build(BuildContext context) {
    print('building `BackgroundWidget`');
    return
      ClipRRect(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(50),
        // ),
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(
          "assets/icons/person.png",
          fit: BoxFit.cover,width: 60, height: 60,
        )
      );
  }
}