import 'package:flutter/material.dart';
import 'package:aakaker/size_config.dart';



const String url = "https://alsaydaly.herokuapp.com";

const myColor = Color.fromARGB(255, 66, 89, 255);
const kPrimaryColor = Color.fromRGBO(66, 89, 255, 1.0);
const kPrimaryLightColor = Color(0xFFFFECDF);
// const kPrimaryGradientColor = LinearGradient(
//   begin: Alignment.topLeft,
//   end: Alignment.bottomRight,
//   colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
// );




// data base
final String tableCartProduct = 'cartProduct';
final String columnProductId = 'id';
final String columnProductImage = 'image';
final String columnProductTitle = 'title';
final String columnProductTitleAr = 'titleAr';
final String columnProductPrice = 'price';
final String columnProductCount = 'count';
final String columnProductType = 'type';



////
const mainFont = Color.fromRGBO(0, 0, 0, 1.0);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);
const KSecondLightButton = Colors.white12;
const KSecondIcon = Colors.blueGrey;
const KbackgroundColor = Color(0xFFF5F6F9);
const Kbg = Color.fromRGBO(233, 237, 241, 1.0);
const kAnimationDuration = Duration(milliseconds: 200);
const KTextColor = Color.fromRGBO(9, 15, 71, 1.0);

const kTextColor1 = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPaddin = 20.0;

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(20),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  // height: 1,

);
final headingStyle1 = TextStyle(
  fontSize: getProportionateScreenWidth(20),
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,

  // height: 1,

);



const defaultDuration = Duration(milliseconds: 150);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
final RegExp passwordValidationRexExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kCVVError = "Please Enter CVV Number";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String KInvalidateCreditNumber = "CVV is invalid";
const String kMixError = "Limit only 500 characters";
const String kPhoneNumberNullError = "Please Enter your phone number";

const String kCreditCardNameNullError = "Please Enter Credit Card name";
const String kExpireDateNullError = "Please select expire date";
const String kCreditCardNumberNullError = "Please Enter your Credit Card Number";
const String kAddressNullError = "Please Enter your address";
//
final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  // focusedBorder: outlineInputBorder(),
  // enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}
