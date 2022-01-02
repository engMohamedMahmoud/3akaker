import 'dart:convert';

import 'package:flutter_offline/flutter_offline.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:aakaker/screens/sign_up/sign_up_screen.dart';
import 'package:aakaker/size_config.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class Body extends StatefulWidget {
   final String otp;
   final String phoneNumber;
  Body({
    Key key,  this.otp,this.phoneNumber
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState(otp,phoneNumber);
}

class _BodyState extends State<Body> with TickerProviderStateMixin {



  final _formKey = GlobalKey<FormState>();
  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  TextEditingController _textFieldController3 = TextEditingController();
  TextEditingController _textFieldController4 = TextEditingController();

  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;
  AnimationController controller;


  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }


  String userOtp;
  String phoneNumber;
  _BodyState(this.userOtp,this.phoneNumber);





  bool display =  false;

  fetchOrders() async {
    setState(() {
      display = true;
    });
    //https://alsaydaly.herokuapp.com/User/OTP/+201099143706/SignUp/EN
    var appLanguage = Provider.of<AppLanguage>(context);
    var response = await http.get("$url/User/OTP/$phoneNumber/SignUp/${appLanguage.appLocal.languageCode.toUpperCase()}");
    // var jsonData = json.decode(response.body);

    if (response.statusCode == 200){
      display = false;
      if (response.body.length == 4){
        // Navigator.pushNamed(context, OtpScreen.routeName,arguments:response.body);
        userOtp = response.body;
      }else{
        Container(
          child: Center(
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      }
    }else{
      display = false;
      Alert(
        context: context,
        type: AlertType.error,
        title: AppLocalizations.of(context).translate("Take Care"),
        desc: response.body,
        buttons: [
          DialogButton(
            child: Text(
              AppLocalizations.of(context).translate("Ok"),
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }


  }

  @override
  void initState() {
    super.initState();

    print("here");

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 300),
    );

    if (controller.isAnimating) {
      controller.stop(canceled: true);
    } else {
      controller.reverse(
          from: controller.value == 0.0
              ? 1.0
              : controller.value);
    }

    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();

  }


  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    controller.dispose();
    super.dispose();
  }


  /// Validation OTP for first testified
  String validateOtp1(String value) {

    print("value $value");
    bool status0 = false;
    bool status1 = false;
    bool status2 = false;
    bool status3 = false;

    print(((value != userOtp[0]) && (value != userOtp[1]) && (value != userOtp[2]) && (value != userOtp[3] )));

    if (value != userOtp[0]) {
      status0 = true;
    }
    if (value != userOtp[1]) {
      status1 = true;
    }
    if (value != userOtp[2]) {
      status2 = true;
    }
    if (value != userOtp[3]) {
      status3 = true;
    }

    print("stt ${status0 != false &&  status1 != false && status2 != false && status0 != false}");

    if (value.length == 0) {
      return "";
    }else if(status0 != false &&  status1 != false && status2 != false && status0 != false){
      return "";
    }
    return null;
  }

  /// Validation OTP for second testified
  String validateOtp2(String value) {

    if (value != userOtp[1]) {
      return "";
    }
    return null;
  }

  /// Validation OTP for third testified
  String validateOtp3(String value) {

    if ( value != userOtp[2]) {
      return "";
    }
    return null;
  }

  /// Validation OTP for third testified
  String validateOtp4(String value) {

    if (value != userOtp[3]) {
      return "";
    }
    return null;
  }


  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }



  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    var appLanguage = Provider.of<AppLanguage>(context,listen: false);

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
        return SizedBox(
          width: double.infinity,
          child:


          Padding(
            padding:

            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.02),
                  Align(
                      alignment: appLanguage.appLocal.languageCode == 'en'? Alignment.topLeft: Alignment.topRight,
                      child: Text(AppLocalizations.of(context).translate("OTP Verification"),style: headingStyle,)
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.01),
                  Align(
                      alignment: appLanguage.appLocal.languageCode == 'en'? Alignment.topLeft: Alignment.topRight,
                      child: Text(AppLocalizations.of(context).translate("OTP Verification has been sent"),)
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Directionality(
                          textDirection:  appLanguage.appLocal.languageCode == "en"? TextDirection.ltr:TextDirection.rtl,
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                width: (30),
                                child: TextFormField(
                                  maxLength: 1,
                                  autofocus: true,

                                  //
                                  style: TextStyle(fontSize: 24),
                                  keyboardType: TextInputType.number,
                                  controller: _textFieldController1,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(

                                    focusColor: Colors.blue,

                                    counterStyle: TextStyle(color: Colors.transparent),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: mainFont,width: 1.0),
                                      //  when the TextFormField in unfocused
                                    ) ,
                                    focusedBorder: UnderlineInputBorder(
                                      //  when the TextFormField in focused
                                      borderSide: BorderSide(color: Colors.blue,width: 3.5),
                                    ) ,
                                    errorBorder: UnderlineInputBorder(
                                      //  when the TextFormField in focused
                                      borderSide: BorderSide(color: Colors.red,width: 3.5),
                                    ) ,
                                    border: UnderlineInputBorder(
                                    ),


                                    // If  you are using latest version of flutter then lable text and hint text shown like this
                                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.all(5), //Change this value to custom as you like
                                    isDense: true,
                                  ),
                                  onChanged: (value) {
                                    nextField(value, pin2FocusNode);
                                  },
                                ),
                              ),
                              SizedBox(
                                width: (30),
                                child: TextFormField(
                                  maxLength: 1,
                                  focusNode: pin2FocusNode,
                                  style: TextStyle(fontSize: 24),
                                  controller: _textFieldController2,
                                  keyboardType: TextInputType.number,

                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(


                                    focusColor: Colors.blue,
                                    counterStyle: TextStyle(color: Colors.transparent),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: mainFont,width: 1.0),
                                      //  when the TextFormField in unfocused
                                    ) ,
                                    focusedBorder: UnderlineInputBorder(
                                      //  when the TextFormField in focused
                                      borderSide: BorderSide(color: Colors.blue,width: 3.5),
                                    ) ,
                                    errorBorder: UnderlineInputBorder(
                                      //  when the TextFormField in focused
                                      borderSide: BorderSide(color: Colors.red,width: 3.5),
                                    ) ,
                                    border: UnderlineInputBorder(
                                    ),

                                    // If  you are using latest version of flutter then lable text and hint text shown like this
                                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.all(5), //Change this value to custom as you like
                                    isDense: true,
                                  ),
                                  onChanged: (value) => nextField(value, pin3FocusNode),
                                ),
                              ),
                              SizedBox(
                                width: (30),
                                child: TextFormField(
                                  maxLength: 1,
                                  focusNode: pin3FocusNode,
                                  style: TextStyle(fontSize: 24),
                                  controller: _textFieldController3,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,

                                  decoration: InputDecoration(

                                    focusColor: Colors.blue,
                                    counterStyle: TextStyle(color: Colors.transparent),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: mainFont,width: 1.0),
                                      //  when the TextFormField in unfocused
                                    ) ,
                                    focusedBorder: UnderlineInputBorder(
                                      //  when the TextFormField in focused
                                      borderSide: BorderSide(color: Colors.blue,width: 3.5),
                                    ) ,
                                    errorBorder: UnderlineInputBorder(
                                      //  when the TextFormField in focused
                                      borderSide: BorderSide(color: Colors.red,width: 3.5),
                                    ) ,

                                    border: UnderlineInputBorder(
                                    ),

                                    // If  you are using latest version of flutter then lable text and hint text shown like this
                                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.all(5), //Change this value to custom as you like
                                    isDense: true,
                                  ),
                                  onChanged: (value) => nextField(value, pin4FocusNode),
                                ),
                              ),
                              SizedBox(
                                width: (30),
                                child: TextFormField(
                                  maxLength: 1,
                                  focusNode: pin4FocusNode,
                                  controller: _textFieldController4,
                                  style: TextStyle(fontSize: 24),
                                  keyboardType: TextInputType.number,

                                  textAlign: TextAlign.center,

                                  decoration: InputDecoration(

                                    focusColor: Colors.blue,
                                    counterStyle: TextStyle(color: Colors.transparent),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: mainFont,width: 1.0),
                                      //  when the TextFormField in unfocused
                                    ) ,
                                    focusedBorder: UnderlineInputBorder(
                                      //  when the TextFormField in focused
                                      borderSide: BorderSide(color: Colors.blue,width: 3.5),
                                    ) ,
                                    errorBorder: UnderlineInputBorder(
                                      //  when the TextFormField in focused
                                      borderSide: BorderSide(color: Colors.red,width: 3.5),
                                    ) ,
                                    border: UnderlineInputBorder(
                                    ),

                                    // If  you are using latest version of flutter then lable text and hint text shown like this
                                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                                    // floatingLabelBehavior: FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.all(5), //Change this value to custom as you like
                                    isDense: true,
                                  ),
                                  onChanged: (value) {
                                    if (value.length == 1) {
                                      pin4FocusNode.unfocus();
                                      // Then you need to check is the code is correct or not
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: SizeConfig.screenHeight * 0.03),

                        (_textFieldController1.text != '' &&  _textFieldController2.text != "" && _textFieldController3.text != '' && _textFieldController4.text != '')?
                        ArgonButton(
                          height: 50,
                          roundLoadingShape: true,
                          width: MediaQuery.of(context).size.width * 0.9,
                          onTap: (startLoading, stopLoading, btnState) async {

                            // if (btnState == ButtonState.Idle) {
                            //   startLoading();
                            //   if (_textFieldController1.text != '' &&  _textFieldController2.text != "" && _textFieldController3.text != '' && _textFieldController4.text != '') {
                            //     String code = "${_textFieldController1.text}${_textFieldController2.text}${_textFieldController3.text}${_textFieldController4.text}";
                            //
                            //     if (userOtp == code){
                            //
                            //       final navigator = Navigator.of(context);
                            //       await navigator.push(
                            //         MaterialPageRoute(
                            //           builder: (context) =>
                            //               SignUpScreen(phoneNumber: phoneNumber,),
                            //         ),
                            //       );
                            //
                            //     }else{
                            //       stopLoading();
                            //     }
                            //
                            //   }
                            // }


                            if (btnState == ButtonState.Idle) {
                              startLoading();
                              if (_textFieldController1.text.length != 0 &&  _textFieldController2.text.length != 0 && _textFieldController3.text.length != 0 && _textFieldController4.text.length != 0) {
                                String code = "${_textFieldController1.text}${_textFieldController2.text}${_textFieldController3.text}${_textFieldController4.text}";
                                print("code $code");

                                if (userOtp == code){
                                  stopLoading();


                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder:
                                              (BuildContext context) =>
                                          new SignUpScreen(phoneNumber: phoneNumber,
                                          )));

                                }
                                else{
                                  stopLoading();
                                  Toast.show(AppLocalizations.of(context).translate("OTP code isn't correct"),context,backgroundColor:Colors.red,gravity: Toast.TOP, textColor: Colors.white,duration: 3);
                                }

                              }
                            }




                          },
                          child: Text(
                            AppLocalizations.of(context).translate("Continue"),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w700),
                          ),
                          loader: Container(
                            padding: EdgeInsets.all(10),
                            child: SpinKitRotatingCircle(
                              color: Colors.white,
                              // size: loaderWidth ,
                            ),
                          ),
                          borderRadius: 5.0,
                          color: kPrimaryColor,
                        ):
                        Container(
                          decoration: BoxDecoration(
                              color: Kbg,
                              borderRadius: BorderRadius.circular(50)),
                          margin: EdgeInsets.all(5),
                          alignment: Alignment.center,

                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Text(
                            AppLocalizations.of(context).translate("Continue"),
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),


                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Align(
                          alignment: appLanguage.appLocal.languageCode == 'en'? Alignment.topLeft: Alignment.topRight,
                          child: Text("${AppLocalizations.of(context).translate("Resend OTP Code")} ",style: TextStyle(fontSize: 18), )
                      ),
                      AnimatedBuilder(
                          animation: controller,
                          builder: (BuildContext context, Widget child) {
                            return Text(
                              timerString,
                              style: TextStyle(color: kPrimaryColor,fontSize: 18),
                            );
                          }),

                    ],
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  // GestureDetector(
                  //   child: AnimatedBuilder(
                  //     animation: controller,
                  //     builder: (BuildContext context, Widget child) {
                  //       return Text(
                  //         "${AppLocalizations.of(context).translate("Resend OTP Code")} ",
                  //         style: TextStyle(decoration: TextDecoration.underline),
                  //       );
                  //
                  //
                  //     },
                  //   ),
                  //   onTap: () {
                  //
                  //     // fetchOrders();
                  //     controller.reverse(
                  //         from: controller.value == 0.0
                  //             ? 1.0
                  //             : controller.value);
                  //
                  //
                  //   },
                  // ),

                  GestureDetector(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context,
                          Widget child) {
                        return Text(
                          "${AppLocalizations.of(context).translate("Resend OTP Code")} ",
                          style: TextStyle(
                              color: kTextColor,
                              fontWeight:
                              FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 18),
                        );
                      },
                    ),
                    onTap: () async {



                      // fetchOrders();

                      if(controller.value == 0.0){
                        _textFieldController1.clear();
                        _textFieldController2.clear();
                        _textFieldController3.clear();
                        _textFieldController4.clear();

                        controller.reverse(
                            from: controller.value == 0.0
                                ? 1.0
                                : controller.value);



                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var apiUrl = Uri.parse("$url/User/OTP/$phoneNumber/SignUp/${appLanguage.appLocal.languageCode.toUpperCase()}");
                        var response = await http.get(apiUrl, headers: {"authorization":prefs.getString('token')});
                        var jsonData = json.decode(response.body);

                        print(response.statusCode);
                        print(response.body);


                        try{
                          if (response.statusCode == 200){

                            setState(() {


                              userOtp = response.body;
                              print(userOtp);
                              Toast.show(AppLocalizations.of(context).translate("OTP Verification has been sent"),context,backgroundColor:Colors.green, textColor: Colors.white, duration: 3,gravity: Toast.TOP);

                            });



                          } else{


                            if(jsonData["message"] != null){
                              Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white, duration: 3,gravity: Toast.TOP);

                            }else{
                              Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white, duration: 3,gravity: Toast.TOP);

                            }

                          }
                        }catch(err){
                          print(err);
                          Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white, duration: 3,gravity: Toast.TOP);
                        }



                      }
                      else{

                        Toast.show("${AppLocalizations.of(context).translate("Wait")}....", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.TOP,textColor: Colors.white,backgroundColor: Colors.red);
                      }








                    },
                  ),

                  SizedBox(height: SizeConfig.screenHeight * 0.02),


                ],
              ),
            ),
          ),
        );
      },
    );

  }




}







