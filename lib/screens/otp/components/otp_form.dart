import 'package:flutter/material.dart';
import 'package:aakaker/components/default_button.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/size_config.dart';


class OtpForm extends StatefulWidget {
  const OtpForm({
    Key key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {


  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  TextEditingController _textFieldController3 = TextEditingController();
  TextEditingController _textFieldController4 = TextEditingController();


  FocusNode pin2FocusNode;
  FocusNode pin3FocusNode;
  FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }




  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  autofocus: true,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  controller: _textFieldController1,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      //  when the TextFormField in unfocused
                    ) ,
                    focusedBorder: UnderlineInputBorder(
                      // borderSide: BorderSide(color: Colors.blue),
                      //  when the TextFormField in focused
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
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  style: TextStyle(fontSize: 24),
                  controller: _textFieldController2,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      //  when the TextFormField in unfocused
                    ) ,
                    focusedBorder: UnderlineInputBorder(
                      // borderSide: BorderSide(color: Colors.blue),
                      //  when the TextFormField in focused
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
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  style: TextStyle(fontSize: 24),
                  controller: _textFieldController3,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(

                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      //  when the TextFormField in unfocused
                    ) ,
                    focusedBorder: UnderlineInputBorder(
                      // borderSide: BorderSide(color: Colors.blue),
                      //  when the TextFormField in focused
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
                width: getProportionateScreenWidth(60),
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  controller: _textFieldController4,
                  style: TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(

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
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          DefaultButton(
            text: AppLocalizations.of(context).translate("Continue"),
            press: () {

              if (_textFieldController1.text != '' &&  _textFieldController2.text != "" && _textFieldController3.text != '' && _textFieldController4.text != '') {
                // String code = "${_textFieldController1.text}${_textFieldController2.text}${_textFieldController3.text}${_textFieldController4.text}";
              }

              // Navigator.pushNamed(context, HomeScreen.routeName);
            },
          )
        ],
      ),
    );
  }
}
