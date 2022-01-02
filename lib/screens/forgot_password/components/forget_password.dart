import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:aakaker/components/form_error.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/forgot_password/Otp_forgetPassword/otp_forget_password_home.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:toast/toast.dart';

class ForgetPasswordFormStep1 extends StatefulWidget {
  @override
  _ForgetPasswordFormStep1 createState() => _ForgetPasswordFormStep1();
}

class _ForgetPasswordFormStep1 extends State<ForgetPasswordFormStep1> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _textFieldController = TextEditingController();

  String phoneNumber;
  String otp;


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


  fetchOrders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var appLanguage = Provider.of<AppLanguage>(context,listen: false);
    var response = await http.get("$url/User/OTP/$phoneNumber/ForgetPassword/${appLanguage.appLocal.languageCode.toUpperCase()}", headers: {"authorization":prefs.getString('token')});
    var jsonData = json.decode(response.body);

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200){
      if (response.body.length == 4){


        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder:
                    (BuildContext context) =>
                new OtpForgetPasswordScreen(otp:otp,phoneNumber: phoneNumber,
                )));


      }else{
        Container(
          child: Center(
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      }
    }
    else{
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
            onPressed: () { Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }


  }

  @override
  Widget build(BuildContext context) {
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
        return Form(
          key: _formKey,
          child: Column(
            children: [
              // Align(
              //     alignment: appLanguage.appLocal.languageCode == 'en' ? Alignment.topLeft : Alignment.topRight,
              //     child: Text(AppLocalizations.of(context).translate("Create New Account"),style: headingStyle)
              // ),
              // SizedBox(height: getProportionateScreenHeight(20)),
              buildPhoneNumberFormField(),
              SizedBox(height: 40),
              ArgonButton(
                height: 50,
                roundLoadingShape: true,
                width: MediaQuery.of(context).size.width * 0.9,
                onTap: (startLoading, stopLoading, btnState) async {



                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();


                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var response = await http.get("$url/User/OTP/$phoneNumber/ForgetPassword/${appLanguage.appLocal.languageCode.toUpperCase()}",headers: {"authorization":prefs.getString('token')});
                    var jsonData = json.decode(response.body);
                    print("$url/User/OTP/$phoneNumber/ForgetPassword/${appLanguage.appLocal.languageCode.toUpperCase()}");
                    print(response.statusCode);
                    print(response.body);



                    if (response.statusCode == 200){
                      if (response.body.length == 4){


                        stopLoading();

                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder:
                                    (BuildContext context) =>
                                new OtpForgetPasswordScreen(otp:response.body,phoneNumber: phoneNumber,
                                )));


                      }else{
                        stopLoading();
                        Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white,duration: 3,gravity: Toast.TOP);
                      }
                    }
                    else{
                      stopLoading();
                      Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white,duration: 3,gravity: Toast.TOP);

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
              SizedBox(height: getProportionateScreenHeight(20)),
              // (display == true)?
              // Visibility (child: CircularProgressIndicator(), visible: true,): Visibility (child: CircularProgressIndicator(), visible: false,)


              // HaveAccountText(),
            ],
          ),
        );
      },
    );


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

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      maxLength: 11,
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
      focusNode: FocusNode(canRequestFocus: false),

      decoration: InputDecoration(
        // labelText: "Phone Number",
        hintText:  AppLocalizations.of(context).translate("Enter phone number"),
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
        contentPadding: EdgeInsets.symmetric(vertical: 10), //Change this value to custom as you like
        isDense: true,
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

}
