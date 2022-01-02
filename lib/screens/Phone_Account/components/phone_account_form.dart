import 'dart:convert';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/components/form_error.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/otp/otp_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:toast/toast.dart';


class PhoneAccountForm extends StatefulWidget {
  @override
  _PhoneAccountFormState createState() => _PhoneAccountFormState();
}

class _PhoneAccountFormState extends State<PhoneAccountForm> with WidgetsBindingObserver{
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




  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context,listen: false);
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

                if (btnState == ButtonState.Idle) {
                  startLoading();
                  var response = await http.get("$url/User/OTP/$phoneNumber/SignUp/${appLanguage.appLocal.languageCode.toUpperCase()}",headers: {"authorization":prefs.getString('token')});
                  print("$url/User/OTP/$phoneNumber/SignUp/${appLanguage.appLocal.languageCode.toUpperCase()}");
                  var jsonData = json.decode(response.body);

                  print("Status code : ${response.statusCode}");




                  if (response.statusCode == 200){
                    print(response.body);
                    if (response.body.length == 4){

                      otp = response.body;

                      stopLoading();


                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder:
                                  (BuildContext context) =>
                              new OtpScreen(otp:response.body,phoneNumber: phoneNumber,)));

                    }else{
                      Container(
                        child: Center(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    }
                  }
                  else{
                    stopLoading();
                    Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white,gravity: Toast.TOP,duration: 3);
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
            borderRadius: 10.0,
            color: kPrimaryColor,
          ),



          SizedBox(height: getProportionateScreenHeight(20)),
          // (display == true)?
          // Visibility (child: CircularProgressIndicator(), visible: true,): Visibility (child: CircularProgressIndicator(), visible: false,)


          // HaveAccountText(),
        ],
      ),
    );
  }




  String validateMobile(String value) {
    // let re = /(\+201)[0-9]{9}$/;
    //(201)[0-9]{9}
    String patttern = r'(^(01)[0-9]{9}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return AppLocalizations.of(context).translate("Please enter mobile number");
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

      decoration: InputDecoration(
        counterStyle: TextStyle(height: double.minPositive,),
        counterText: "",
        // labelText: "Phone Number",
        hintText:  AppLocalizations.of(context).translate("Enter your phone number"),
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
