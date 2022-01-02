import 'dart:convert';
import 'dart:io';
import 'package:toast/toast.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aakaker/components/form_error.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/login_success/login_success_screen.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import '../../../../size_config.dart';


class MyHomePage extends StatefulWidget {
  final List<String> details;
  final File image;
  final double lat;
  final double long;
  const MyHomePage({Key key, @required this.details, this.image, this.lat, this.long}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(details, image, lat, long);
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  double lat, long;
  File image;

  String userId;
  String codeDialogName;
  String name;
  TextEditingController _textFieldController = TextEditingController();

  String codeDialogPhone;
  String phone;
  TextEditingController _textFieldControllerPhone = TextEditingController();

  String codeDialogFlatNumber;
  String flatNumber;
  TextEditingController _textFieldControllerFlatNumber =
  TextEditingController();

  String codeDialogFloorNumber;
  String floorNumber;
  TextEditingController _textFieldControllerFloorNumber =
  TextEditingController();

  String codeDialogBuildingName;
  String buildingName;
  TextEditingController _textFieldControllerBuildingName =
  TextEditingController();

  String city;
  String codeDialogCity;
  TextEditingController cityController = TextEditingController();

  String street;
  String codeDialogStreet;
  TextEditingController streetController = TextEditingController();

  String state;
  String codeDialogState;
  TextEditingController stateController = TextEditingController();

  String country;
  String codeDialogCountry;
  TextEditingController countryController = TextEditingController();

  final List<String> details;

  _MyHomePageState(this.details, this.image, this.lat, this.long);

  final List<String> errors = [];

  String validateStreet(String value) {


    if (value.length == 0) {
      return AppLocalizations.of(context)
          .translate("Start name is required");
    }
    return null;
  }

  String valideFloor(String value) {


    if (value.length == 0) {
      return AppLocalizations.of(context)
          .translate("Floor Name is required");
    }
    return null;
  }

  String valideFlat(String value) {


    if (value.length == 0) {
      return AppLocalizations.of(context)
          .translate("Flat Number is reuired");
    }
    return null;
  }

  String valideBulding(String value) {


    if (value.length == 0) {
      return AppLocalizations.of(context)
          .translate("Building Name is required");
    }
    return null;
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
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('_id');
  }
  @override
  void initState() {
    // TODO: implement initState

    getData();
    countryController.text = details[details.length - 1];
    stateController.text = details[details.length - 2];
    cityController.text = details[details.length - 3];
    streetController.text = details[0];


    super.initState();

  }

  String validateMobile(String value) {
    // let re = /(\+201)[0-9]{9}$/;
    //(201)[0-9]{9}
    String patttern = r'(^(01)[0-9]{9}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return AppLocalizations.of(context)
          .translate("Mobile is required");
    } else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context)
          .translate("Please enter valid mobile number");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
            child: SafeArea(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(25)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: SizeConfig.screenHeight * 0.02),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              country = value;
                            });
                          },
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: countryController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)
                                .translate("Enter Country Name"),
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
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              state = value;
                            });
                          },
                          enabled: false,
                          keyboardType: TextInputType.text,
                          controller: stateController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)
                                .translate("Enter State Name"),
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
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        TextField(
                          onChanged: (value) {
                            setState(() {
                              city = value;
                            });
                          },
                          enabled: false,
                          maxLength: 100,
                          keyboardType: TextInputType.text,
                          controller: cityController,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)
                                .translate("Enter City Name"),
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
                        ),
                        // SizedBox(height: getProportionateScreenHeight(20)),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              street = value;
                            });
                          },
                          validator: validateStreet,
                          maxLength: 100,
                          keyboardType: TextInputType.text,
                          controller: streetController,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: AppLocalizations.of(context)
                                .translate("Enter Street"),
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
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              buildingName = value;
                            });
                          },
                          maxLength: 5,
                          validator: valideBulding,
                          keyboardType: TextInputType.number,
                          controller: _textFieldControllerBuildingName,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: AppLocalizations.of(context)
                                .translate("Enter Building Name"),
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
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              floorNumber = value;
                            });
                          },
                          maxLength: 5,
                          validator: valideFloor,

                          keyboardType: TextInputType.number,
                          controller: _textFieldControllerFloorNumber,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: AppLocalizations.of(context)
                                .translate("Enter Floor Name"),
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
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              flatNumber = value;
                            });
                          },
                          validator: valideFlat,
                          maxLength: 5,
                          keyboardType: TextInputType.text,
                          controller: _textFieldControllerFlatNumber,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: AppLocalizations.of(context)
                                .translate("Enter Flat Number"),
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
                        ),
                        SizedBox(height: getProportionateScreenHeight(20)),
                        TextFormField(
                          onChanged: (value) {
                            setState(() {
                              phone = value;
                            });
                          },
                          validator: validateMobile,
                          maxLength: 11,
                          keyboardType: TextInputType.phone,
                          controller: _textFieldControllerPhone,
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: AppLocalizations.of(context)
                                .translate("Enter your phone number"),
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
                        ),

                        SizedBox(height: 40),



                        ArgonButton(
                          height: 50,
                          roundLoadingShape: true,
                          width: MediaQuery.of(context).size.width * 0.9,
                          onTap:
                              (startLoading, stopLoading, btnState) async {


                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              codeDialogPhone = "+2$phone";
                              codeDialogFlatNumber = flatNumber;
                              codeDialogBuildingName = buildingName;
                              codeDialogFloorNumber = floorNumber;
                              codeDialogCity = city;
                              codeDialogStreet = street;
                              codeDialogCountry = country;
                              codeDialogState = state;

                              if (image != null) {
                                if (btnState == ButtonState.Idle){
                                  startLoading();
                                  Map address = {
                                    "City": cityController.text,
                                    "Street": streetController.text,
                                    "Building": _textFieldControllerBuildingName.text,
                                    "Floor": _textFieldControllerFloorNumber.text,
                                    "FlatNo": _textFieldControllerFlatNumber.text,
                                    "Number": "+2${_textFieldControllerPhone.text}",
                                    "Lat": lat,
                                    "Long": long
                                  };
                                  var add = JsonEncoder().convert(address);

                                  var request = http.MultipartRequest('POST', Uri.parse("$url/Payment/Add/"));
                                  //Header....
                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                  request.headers["authorization"] = prefs.getString('token');
                                  request.fields['DeliveryAddress'] = add;
                                  // request.fields["PaymentType"]= "Cash";
                                  request.fields["UserID"] = userId;
                                  request.fields["Type"] = "Rosheta";
                                  request.fields["Pharmacy"]= prefs.getString('Pharmacy');
                                  request.fields["Language"] =
                                      appLanguage.appLocal.languageCode.toUpperCase();
                                  request.fields['RoshetaPicture'] = image.toString();
                                  request.files
                                      .add(await http.MultipartFile.fromPath('RoshetaPicture', image.path));

                                  print(request.fields["Pharmacy"]);

                                  var response = await request.send();
                                  final res = await http.Response.fromStream(response);

                                  print(response.statusCode);
                                  try {
                                    if (res.statusCode == 200) {
                                      stopLoading();

                                      Navigator.of(context).pushReplacement(
                                          MaterialPageRoute(
                                              builder:
                                                  (BuildContext context) =>
                                              new LoginSuccessScreen()));
                                    } else {
                                      stopLoading();
                                      Toast.show(res.body,context,backgroundColor:Colors.red, textColor: Colors.white);
                                    }
                                  } catch (err) {
                                    stopLoading();
                                  }


                                }
                                // createOrder();
                              }

                            }


                          },
                          child: Text(
                            AppLocalizations.of(context).translate("Pay"),
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
                        //   text: AppLocalizations.of(context).translate("Pay"),
                        //   press: () async {
                        //     if (_formKey.currentState.validate()) {
                        //       _formKey.currentState.save();
                        //       codeDialogPhone = "+2$phone";
                        //       codeDialogFlatNumber = flatNumber;
                        //       codeDialogBuildingName = buildingName;
                        //       codeDialogFloorNumber = floorNumber;
                        //       codeDialogCity = city;
                        //       codeDialogStreet = street;
                        //       codeDialogCountry = country;
                        //       codeDialogState = state;
                        //
                        //       if (image != null) {
                        //         createOrder();
                        //       }
                        //
                        //     }
                        //   },
                        // ),

                        SizedBox(height: getProportionateScreenHeight(20)),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );


  }



  createOrder() async {
    Map address = {
      "City": cityController.text,
      "Street": streetController.text,
      "Building": _textFieldControllerBuildingName.text,
      "Floor": _textFieldControllerFloorNumber.text,
      "FlatNo": _textFieldControllerFlatNumber.text,
      "Number": "+2${_textFieldControllerPhone.text}",
      "Lat": lat,
      "Long": long
    };
    var add = JsonEncoder().convert(address);
    var appLanguage = Provider.of<AppLanguage>(context);
    var request = http.MultipartRequest('POST', Uri.parse("$url/Payment/Add/"));
    //Header....
    request.fields['DeliveryAddress'] = add;
    // request.fields["PaymentType"]= "Cash";
    request.fields["UserID"] = userId;
    request.fields["Type"] = "Rosheta";
    request.fields["Language"] =
        appLanguage.appLocal.languageCode.toUpperCase();
    request.fields['RoshetaPicture'] = image.toString();
    request.files
        .add(await http.MultipartFile.fromPath('RoshetaPicture', image.path));

    var response = await request.send();
    final res = await http.Response.fromStream(response);

    print(response.statusCode);
    try {
      if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder:
                    (BuildContext context) =>
                new LoginSuccessScreen()));
      } else {
        Alert(
          context: context,
          type: AlertType.error,
          title: AppLocalizations.of(context).translate("Take Care"),
          desc: res.body,
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
    } catch (err) {
    }
  }
}
