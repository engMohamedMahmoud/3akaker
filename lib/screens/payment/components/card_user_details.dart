import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:intl/intl.dart';
import 'package:aakaker/components/default_button.dart';
import 'package:aakaker/screens/cart/components/cart_view_model.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import 'dart:async';
import '../../../constants.dart';
import '../../../size_config.dart';

class CreditCardForm extends StatefulWidget {

  final String city;
  final String street;
  final String building;
  final String floor;
  final String flatNumber;
  final String phone;
  CreditCardForm({
    Key key,  this.city,this.street, this.building,this.floor,this.flatNumber,this.phone
  }) : super(key: key);

  @override
  _CreditCardFormState createState() => _CreditCardFormState(this.city,this.street, this.building,this.floor,this.flatNumber,this.phone);
}

class _CreditCardFormState extends State<CreditCardForm> {


  String city;
  String street;
  String building;
  String floor;
  String flatNumber;
  String phone;

  _CreditCardFormState(this.city,this.street, this.building,this.floor,this.flatNumber,this.phone);

  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller;
  DateTime selectedDate = DateTime.now();
  String cvvNumber;
  String creditCardNumber;
  String name;
  String formatted;
  int _groupValue = -1;
  final List<String> errors = [];

  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        final DateFormat formatter = DateFormat('yyyy/MM/dd');
        String formatted = formatter.format(selectedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [


          GetBuilder<CartViewModel>(init: Get.find(),builder: (controller) =>Container(
            child: Row(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "${controller.cartProductModel.length} Items in basket",
                    style: TextStyle(color: Colors.black38, fontSize: 16),
                  ),
                ),

                Spacer(),
                FlatButton(
                  // onPressed: () => navigateToLogin(context),
                    onPressed: () {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    },
                    // color: Kbg,

                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Text("Total",
                            style: TextStyle(fontSize: 16, color: Colors.black38)),
                        Text("${controller.orderCost}\$",
                            style: TextStyle(fontSize: 16, color: KTextColor)),
                        // Spacer(),
                      ],
                    )),

              ],
            ),
          )),

          SizedBox(height: getProportionateScreenHeight(20)),
          Align(
              alignment: Alignment.topLeft,
              child: Text("Payment Methods",
                  style: TextStyle(color: KTextColor, fontSize: 18))),
          Container(
            alignment: Alignment.center,
            // padding: const EdgeInsets.all(18.0),
            margin: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1.0),
            ),
            child: Column(
              children: <Widget>[
                Row(children: <Widget>[
                  Expanded(
                    child:
                    _myRadioButton(
                      title: "Credit Card",
                      value: 0,
                      onChanged: (newValue) =>
                          setState(() => _groupValue = newValue),
                    ),
                  ),
                  // Spacer(),
                  Expanded(
                    child: Image.asset("assets/icons/mastercard.png",width: 30,height: 30,),

                  )
                ],
                ),
                Row(children: <Widget>[
                  Expanded(
                    child: _myRadioButton(
                      title: "Cash",
                      value: 1,
                      onChanged: (newValue) =>
                          setState(() => _groupValue = newValue),
                    ),
                  ),
                  // Spacer(),
                  Expanded(
                    child: SvgPicture.asset(
                      "assets/icons/cash-payment.svg",
                      width: 20,

                    ),
                  )
                ],
                ),

              ],
            ),
          ),
          // SizedBox(height: getProportionateScreenHeight(20)),
          // Align(
          //     alignment: Alignment.topLeft,
          //     child: Text("Credit Card Details:",
          //         style: TextStyle(color: KTextColor, fontSize: 18))),
          // SizedBox(height: getProportionateScreenHeight(20)),
          // buildCVVFormField(),
          // SizedBox(height: getProportionateScreenHeight(20)),
          // buildCreditCardNumberFormField(),
          // SizedBox(height: getProportionateScreenHeight(20)),
          // buildCreditCardUserNameFormField(),
          // SizedBox(height: getProportionateScreenHeight(20)),
          // TextFormField(
          //   // controller: _date,
          //   autocorrect: false,
          //   controller: _controller,
          //   focusNode: AlwaysDisabledFocusNode(),
          //   onTap: () {
          //     showDatePicker(
          //         context: context,
          //         initialDate: DateTime.now(),
          //         firstDate: DateTime.now(),
          //         lastDate: DateTime(2100, 12),
          //         builder: (BuildContext context, Widget picker) {
          //           return Theme(
          //             //TODO: change colors
          //             data: ThemeData.dark().copyWith(
          //               colorScheme: ColorScheme.dark(
          //                 primary: Colors.deepPurple,
          //                 onPrimary: Colors.white,
          //                 surface: Colors.green,
          //                 onSurface: Colors.yellow,
          //               ),
          //               dialogBackgroundColor: Colors.black38,
          //             ),
          //             child: picker,
          //           );
          //         }).then((selectedDate) {
          //       if (selectedDate != null) {
          //         // _controller.text = selectedDate.toString();
          //
          //         final DateFormat formatter = DateFormat('yyyy/MM/dd');
          //         formatted = formatter.format(selectedDate);
          //         _controller.text = formatted;
          //       }
          //     });
          //   },
          //   onSaved: (value) {
          //     formatted = value;
          //   },
          //   onChanged: (value) {
          //     if (value.isNotEmpty) {
          //       removeError(error: kExpireDateNullError);
          //     }
          //     // if (value.length < 3 || value.length > 4) {
          //     //   addError(error: KInvalidateCreditNumber);
          //     //   return "";
          //     // }
          //     return null;
          //   },
          //   validator: (value) {
          //     if (value.isEmpty) {
          //       addError(error: kExpireDateNullError);
          //       return "";
          //     }
          //     // if (value.length < 3 || value.length > 4) {
          //     //   addError(error: KInvalidateCreditNumber);
          //     //   return "";
          //     // }
          //     return null;
          //   },
          //   keyboardType: TextInputType.phone,
          //
          //   decoration: InputDecoration(
          //     hintText: "Expiry Date Credit Card",
          //
          //     enabledBorder: UnderlineInputBorder(
          //       borderSide: BorderSide(color: Colors.grey),
          //       //  when the TextFormField in unfocused
          //     ),
          //     focusedBorder: UnderlineInputBorder(
          //       borderSide: BorderSide(color: Colors.blue),
          //       //  when the TextFormField in focused
          //     ),
          //     border: UnderlineInputBorder(),
          //
          //     // If  you are using latest version of flutter then lable text and hint text shown like this
          //     // if you r using flutter less then 1.20.* then maybe this is not working properly
          //     // floatingLabelBehavior: FloatingLabelBehavior.always,
          //     contentPadding: EdgeInsets.all(5),
          //     //Change this value to custom as you like
          //     isDense: true,
          //   ),
          // ),
          // SizedBox(height: getProportionateScreenHeight(20)),
          // FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(60)),
          DefaultButton(
            text: "Pay Now",
            press: () {


            },
          ),
        ],
      ),
    );
  }

  Widget _myRadioButton({String title, int value, Function onChanged}) {
    return RadioListTile(

      value: value,

      onChanged: onChanged,
      title: Text(title,
          style: TextStyle(color: KTextColor, fontWeight: FontWeight.bold)),
      groupValue: _groupValue,
    );
  }

  TextFormField buildCVVFormField() {
    return TextFormField(
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(4),
      ],
      keyboardType: TextInputType.number,
      onSaved: (newValue) {
        cvvNumber = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCVVError);
        }
        // if (value.length < 3 || value.length > 4) {
        //   addError(error: KInvalidateCreditNumber);
        //   return "";
        // }

        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kCVVError);
          return "";
        }
        // if (value.length < 3 || value.length > 4) {
        //   addError(error: KInvalidateCreditNumber);
        //   return "";
        // }
        return null;
      },
      decoration: InputDecoration(
        hintText: "CVV Number",

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          //  when the TextFormField in unfocused
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          //  when the TextFormField in focused
        ),
        border: UnderlineInputBorder(),

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(5),
        //Change this value to custom as you like
        isDense: true,
      ),
    );
  }

  TextFormField buildCreditCardNumberFormField() {
    return TextFormField(
      inputFormatters: [
        WhitelistingTextInputFormatter.digitsOnly,
        new LengthLimitingTextInputFormatter(19),
        new CardNumberInputFormatter()
      ],
      keyboardType: TextInputType.number,
      onSaved: (newValue) => creditCardNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCreditCardNumberNullError);
        }

        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kCreditCardNumberNullError);
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: "Credit Card Number",

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          //  when the TextFormField in unfocused
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          //  when the TextFormField in focused
        ),
        border: UnderlineInputBorder(),

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(5),
        //Change this value to custom as you like
        isDense: true,
      ),
    );
  }

  TextFormField buildCreditCardUserNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kCreditCardNameNullError);
        }

        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kCreditCardNameNullError);
          return "";
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: "Credit Card Name",

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
          //  when the TextFormField in unfocused
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
          //  when the TextFormField in focused
        ),
        border: UnderlineInputBorder(),

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(5),
        //Change this value to custom as you like
        isDense: true,
      ),
    );
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
