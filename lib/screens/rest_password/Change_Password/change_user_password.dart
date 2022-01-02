import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:aakaker/components/form_error.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/sign_in/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:toast/toast.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChangeUserPasswordForm extends StatefulWidget {
  final String phoneNumber;
  ChangeUserPasswordForm({
    Key key, this.phoneNumber
  }) : super(key: key);
  @override
  _RestPasswordForm createState() => _RestPasswordForm(phoneNumber);
}

class _RestPasswordForm extends State<ChangeUserPasswordForm> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  String password;
  String oldPassword;
  String conform_password;
  final List<String> errors = [];


  String phoneNumber;
  _RestPasswordForm(this.phoneNumber);

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


  createUser() async{
    var appLanguage = Provider.of<AppLanguage>(context);
    final String apiUrl = "$url/User/ResetPassword/";

    final response = await http.post(apiUrl, body: {

      "Password":oldPassword,
      "NewPassword":password,
      "Number": "+$phoneNumber",
      "Language": appLanguage.appLocal.languageCode.toUpperCase()
    });

    var jsonData = json.decode(response.body);

    try{
      if (response.statusCode == 200){
        Toast.show(response.body,context,backgroundColor:Colors.green, textColor: Colors.white,duration: 3,gravity: Toast.TOP);

      } else{

        Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white,duration: 3,gravity: Toast.TOP);


      }
    }catch(err){

    }


  }

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context,listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          Align(
              alignment: appLanguage.appLocal.languageCode == 'en' ? Alignment.topLeft : Alignment.topRight,
              child: Text(AppLocalizations.of(context).translate("Reset Password"),style: headingStyle)
          ),

          SizedBox(height: getProportionateScreenHeight(20)),
          buildOldPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildConformPassFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          ArgonButton(
            height: 50,
            roundLoadingShape: true,
            width: MediaQuery.of(context).size.width * 0.9,
            onTap: (startLoading, stopLoading, btnState) async {

              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();

                stopLoading();
                if (btnState == ButtonState.Idle) {
                  startLoading();
                  final String apiUrl = "$url/User/ResetPassword/";

                  final response = await http.post(apiUrl, body: {

                    "Password":oldPassword,
                    "NewPassword":password,
                    "Number": phoneNumber,
                    "Language": appLanguage.appLocal.languageCode.toUpperCase()
                  },headers: {"authorization":prefs.getString('token')});

                  var jsonData = json.decode(response.body);
                  print(response.statusCode);
                  print("response.body ${response.body}");
                  print(phoneNumber);

                  try{
                    if (response.statusCode == 200){
                      stopLoading();
                      Toast.show(response.body,context,backgroundColor:Colors.green, textColor: Colors.white,duration: 3,gravity: Toast.TOP);

                      // Navigator.pushNamed(context, SignInScreen.routeName);
                    } else{

                      stopLoading();
                      Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white,duration: 3,gravity: Toast.TOP);


                    }
                  }catch(err){

                    startLoading();
                  }


                }
              }


            },
            child: Text(
              AppLocalizations.of(context).translate("Reset Password"),
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

          // DefaultButton(
          //   text: AppLocalizations.of(context).translate("Reset Password"),
          //   press: () {
          //     if (_formKey.currentState.validate()) {
          //       _formKey.currentState.save();
          //
          //
          //       createUser();
          //
          //     }
          //   },
          // ),
        ],
      ),
    );
  }








  String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return AppLocalizations.of(context).translate("New Password is required");
    } else {
      if (!regex.hasMatch(value))
        return AppLocalizations.of(context).translate("Enter valid password");
      else
        return null;
    }
  }

  String validateOldPassword(String value) {
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

  String validateConfirmPassword(String value) {

    if (value.isEmpty) {
      return  AppLocalizations.of(context).translate("Re-enter password is required");
    }else if (value != password ){
      return AppLocalizations.of(context).translate("Passwords don't match");
    }
  }


  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).translate("Re-enter password is required"));
        } else if (password == value) {
          removeError(error: AppLocalizations.of(context).translate("Passwords don't match"));
        }
        conform_password = value;
      },
      maxLength: 30,
      validator: validateConfirmPassword,
      decoration: InputDecoration(
        counterStyle: TextStyle(height: double.minPositive,),
        counterText: "",
        hintText:  AppLocalizations.of(context).translate("Re-enter password"),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          //  when the TextFormField in unfocused
        ) ,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          //  when the TextFormField in focused
        ),
        border: UnderlineInputBorder(
        ),
        contentPadding: EdgeInsets.all(12), //Change this value to custom as you like
        isDense: true,
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).translate("New Password is required"));
        } else if (passwordValidationRexExp.hasMatch(value)) {
          removeError(error:  AppLocalizations.of(context).translate("Enter valid password"));
        }
        password = value;
      },
      maxLength: 30,
      validator: validatePassword,
      decoration: InputDecoration(
        counterStyle: TextStyle(height: double.minPositive,),
        counterText: "",
        errorMaxLines: 3,
        // labelText: "Password",
        hintText: AppLocalizations.of(context).translate("Enter new password"),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
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
        contentPadding: EdgeInsets.all(12), //Change this value to custom as you like
        isDense: true,
      ),

    );
  }

  TextFormField buildOldPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => oldPassword = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).translate("Password is required"));
        } else if (passwordValidationRexExp.hasMatch(value)) {
          removeError(error:  AppLocalizations.of(context).translate("Enter valid password"));
        }
        password = value;
      },
      maxLength: 30,
      validator: validateOldPassword,
      decoration: InputDecoration(
        counterStyle: TextStyle(height: double.minPositive,),
        counterText: "",
        errorMaxLines: 3,
        // labelText: "Password",
        hintText: AppLocalizations.of(context).translate("Enter password"),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
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
        contentPadding: EdgeInsets.all(12), //Change this value to custom as you like
        isDense: true,
      ),

    );
  }







}
