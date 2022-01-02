import 'dart:convert';
import 'package:aakaker/screens/PhramysNames/HomeNames.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/components/form_error.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/forgot_password/forgot_password_screen.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> with WidgetsBindingObserver  {
  TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String phoneNumber;
  String password;
  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  //+201111111111
  createUser() async{

    // showAlertDialog(context);
    // var appLanguage = Provider.of<AppLanguage>(context);
    final String apiUrl = "$url/User/Login";

    final response = await http.post(apiUrl, body: {
      "Password":password,
      "Number": phoneNumber,
      "Language": "EN"
    });
    var jsonData = json.decode(response.body);


    try{
      if (response.statusCode == 200){

        if (jsonData["data"]["ProfilePicture"] != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', jsonData["token"]);
          prefs.setString('_id', jsonData["data"]["_id"]);
          prefs.setString('FirstName', jsonData["data"]["FirstName"]);
          prefs.setString('LastName', jsonData["data"]["LastName"]);
          prefs.setString('Email', jsonData["data"]["Email"]);
          prefs.setString('Number', jsonData["data"]["Number"]);
          prefs.setString('ProfilePicture', jsonData["data"]["ProfilePicture"]);


          print( jsonData["token"]);

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder:
                      (BuildContext context) =>
                  new HomeScreen()));

      }else{

          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', jsonData["token"]);
          prefs.setString('_id', jsonData["data"]["_id"]);
          prefs.setString('FirstName', jsonData["data"]["FirstName"]);
          prefs.setString('LastName', jsonData["data"]["LastName"]);
          prefs.setString('Email', jsonData["data"]["Email"]);
          prefs.setString('Number', jsonData["data"]["Number"]);
          // prefs.setString('ProfilePicture', jsonData["data"]["ProfilePicture"]);


          print(jsonData["token"]);

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder:
                      (BuildContext context) =>
                  new HomeScreen()));
        }





      } else{

        Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white,gravity: Toast.TOP,duration: 3);

        // Visibility(child: showAlertDialog(context), visible: false,);
      }
    }catch(err){

    }


  }




  double deliverCost = 0.00;
  Future getDeliveryCost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse("https://alsaydaly.herokuapp.com/User/Shipping"),headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${prefs.getString("token")}"
    });


    if (response.statusCode == 200) {
      setState(() {

        var data = json.decode(response.body);
        double jsonResponse = double.parse(data);
        deliverCost = jsonResponse.toDouble();
        prefs.setDouble("shippingCost", deliverCost);


        print("max value : ${response.body}");

      });

    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {


    setState(() {
      getDeliveryCost();
    });


    super.initState();


  }


  String validateMobile(String value) {
    // let re = /(\+201)[0-9]{9}$/;
    //(201)[0-9]{9}
    String patttern = r'(^(01)[0-9]{9}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return AppLocalizations.of(context).translate("Mobile is required");
    }
    else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context).translate("Please enter valid mobile number");
    }
    return null;
  }


  String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return AppLocalizations.of(context).translate("Password is required");
    } else {
      if (!regex.hasMatch(value))
        return AppLocalizations.of(context).translate("Enter valid password");
      else
        return null;
    }
  }
  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return AppLocalizations.of(context).translate("Enter your email");
    } else {
      if (!regex.hasMatch(value))
        return AppLocalizations.of(context).translate("Please Enter Valid Email");
      else
        return null;
    }
  }


  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context,listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Align(
              alignment: appLanguage.appLocal.languageCode == 'en' ? Alignment.topLeft : Alignment.topRight,
              child: Text(AppLocalizations.of(context).translate("Login"),style: headingStyle)
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          GestureDetector(
            onTap: () =>

                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder:
                            (BuildContext context) =>
                        new ForgotPasswordScreen())),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 50,
              color: Colors.transparent,

              child: Text(
                AppLocalizations.of(context).translate("Forgot Password"),
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ),



          SizedBox(height: getProportionateScreenHeight(8)),
          ArgonButton(
            height: 50,
            roundLoadingShape: true,
            width: MediaQuery.of(context).size.width * 0.9,
            onTap: (startLoading, stopLoading, btnState) async {

              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();

                      if (btnState == ButtonState.Idle) {
                        startLoading();
                        final String apiUrl = "$url/User/Login";

                        final response = await http.post(apiUrl, body: {
                          "Password":password,
                          "Number": phoneNumber,
                          "Language": appLanguage.appLocal.languageCode.toUpperCase()
                        },headers: {"authorization":prefs.getString('token')});
                        print("response.body ${response.body}");
                        print("response.body ${response.statusCode}");
                        var jsonData = json.decode(response.body);



                        try{
                          if (response.statusCode == 200){


                            if (jsonData["data"]["ProfilePicture"] != null) {

                              prefs.setString('token', jsonData["token"]);
                              prefs.setString('_id', jsonData["data"]["_id"]);
                              prefs.setString('FirstName', jsonData["data"]["FirstName"]);
                              prefs.setString('LastName', jsonData["data"]["LastName"]);
                              prefs.setString('Email', jsonData["data"]["Email"]);
                              prefs.setString('Number', jsonData["data"]["Number"]);
                              prefs.setString('ProfilePicture', jsonData["data"]["ProfilePicture"]);




                              stopLoading();

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder:
                                          (BuildContext context) =>
                                      new NamesScreen(name: "${jsonData["data"]["FirstName"]} ${jsonData["data"]["LastName"]}",imageUrl: jsonData["data"]["ProfilePicture"],)));

                            }else{

                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              prefs.setString('token', jsonData["token"]);
                              prefs.setString('_id', jsonData["data"]["_id"]);
                              prefs.setString('FirstName', jsonData["data"]["FirstName"]);
                              prefs.setString('LastName', jsonData["data"]["LastName"]);
                              prefs.setString('Email', jsonData["data"]["Email"]);
                              prefs.setString('Number', jsonData["data"]["Number"]);
                              // prefs.setString('ProfilePicture', jsonData["data"]["ProfilePicture"]);



                              stopLoading();
                              // Navigator.of(context).pushReplacement(
                              //     MaterialPageRoute(
                              //         builder:
                              //             (BuildContext context) =>
                              //         new HomeScreen()));



                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder:
                                          (BuildContext context) =>
                                      new NamesScreen(name: "${jsonData["data"]["FirstName"]} ${jsonData["data"]["LastName"]}",
                                        imageUrl: "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png")));


                            }





                          } else{

                            stopLoading();
                            Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white,duration: 3,gravity: Toast.TOP);

                            // Visibility(child: showAlertDialog(context), visible: false,);
                          }
                        }catch(err){
                          stopLoading();
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
          ),

        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).translate("Password is required"));
        } else if (passwordValidationRexExp.hasMatch(value)) {
          removeError(error:  AppLocalizations.of(context).translate("Enter valid password"));
        }
        password = value.trim();
      },
      maxLength: 30,
      validator: validatePassword,
      decoration: InputDecoration(
        errorMaxLines: 3,
        counterStyle: TextStyle(height: double.minPositive,),
        counterText: "",
        hintText:  AppLocalizations.of(context).translate("Enter password"),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          //  when the TextFormField in unfocused
        ) ,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          //  when the TextFormField in focused
        ) ,
        border: UnderlineInputBorder(
        ),
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 0, right: 15,),

          child: Image.asset(
            'assets/images/lock.png',
            // height: getProportionateScreenWidth(5),
            width: 2,
            height: 2,
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      controller: _textFieldController,
      onSaved: (newValue) {
        phoneNumber = "+2${_textFieldController.text}";

      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }


        return null;
      },
      validator: validateMobile,
      // maxLines: 11,
      maxLength: 11,
      decoration: InputDecoration(
        counterStyle: TextStyle(height: double.minPositive,),
        counterText: "",
        hintText:  AppLocalizations.of(context).translate("Enter phone number"),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ) ,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          //  when the TextFormField in focused
        ) ,
        border: UnderlineInputBorder(
        ),
        isDense: true,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 0, right: 15,),

          child: Image.asset(
            'assets/images/user.png',
            // height: getProportionateScreenWidth(5),
            width: 2,
            height: 2,
          ),
        ),
      ),
    );
  }
}
