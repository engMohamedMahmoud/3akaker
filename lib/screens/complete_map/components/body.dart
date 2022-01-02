import 'package:aakaker/screens/cart/components/cart_view_model.dart';
import 'package:aakaker/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/components/default_button.dart';
import 'package:aakaker/components/form_error.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/payment/payment_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:aakaker/screens/Conection/components/body.dart';

class MyHomePage extends StatefulWidget {
  final List<String> details;
  final double lat;
  final double long;
  final String street;
  final String city;
  const MyHomePage({Key key, @required this.details, this.lat, this.long, this.street, this.city}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(details, lat, long, street,city);
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  double lat, long;

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



  _MyHomePageState(this.details, this.lat, this.long, this.street,this.city);

  // Map _source = {ConnectivityResult.none: false};
  // MyConnectivity _connectivity = MyConnectivity.instance;
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

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('_id');
    lat = prefs.getDouble('lat');
    long = prefs.getDouble('long');
  }

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = details[details.length - 1];
    stateController.text = details[details.length - 2];
    cityController.text = details[details.length - 3];
    streetController.text = street;
    super.initState();
    // _connectivity.initialise();
    // _connectivity.myStream.listen((source) {
    //   setState(() => _source = source);
    // });

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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                              country = value.trim();
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
                              state = value.trim();
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
                              city = value.trim();
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
                              street = value.trim();
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
                              buildingName = value.trim();
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
                              floorNumber = value.trim();
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
                              flatNumber = value..trim();
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
                              phone = value.trim();
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


                        GetBuilder<CartViewModel>(
                            init: Get.find(),
                            builder: (controller) =>

                                DefaultButton(
                                  text: AppLocalizations.of(context).translate("Pay"),
                                  press: () async {
                                    // String orderCost = (controller.orderCost).round().toInt().toStringAsFixed(2);
                                    //


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


                                      final navigator = Navigator.of(context);

                                      await navigator.push(
                                        MaterialPageRoute(
                                          builder: (context) => PaymentScreen(
                                            city: cityController.text,
                                            street: streetController.text,
                                            building:
                                            _textFieldControllerBuildingName.text,
                                            floor: _textFieldControllerFloorNumber.text,
                                            flatNumber:
                                            _textFieldControllerFlatNumber.text,
                                            phone:
                                            "+2${_textFieldControllerPhone.text}",
                                            lat:  lat,
                                            long: long,
                                            lengthItems: "${controller.cartProductModel.length}",
                                            totalCost: (controller.orderCost).round().toInt().toStringAsFixed(2),
                                          ),
                                        ),
                                      );

                                      // Navigator.of(context).pushReplacement(
                                      //     MaterialPageRoute(
                                      //         builder:
                                      //             (BuildContext context) =>
                                      //         new PaymentScreen(
                                      //             city: cityController.text,
                                      //             street: streetController.text,
                                      //             building:
                                      //             _textFieldControllerBuildingName.text,
                                      //             floor: _textFieldControllerFloorNumber.text,
                                      //             flatNumber:
                                      //             _textFieldControllerFlatNumber.text,
                                      //             phone:
                                      //             "+2${_textFieldControllerPhone.text}",
                                      //             lat:  lat,
                                      //             long: long
                                      //         )));


                                    }
                                  },
                                ),
                        ),



                        SizedBox(height: getProportionateScreenHeight(20)),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      },
    );



    // switch (_source.keys.toList()[0]) {
    //   case ConnectivityResult.none:
    //     return BodyConnection();
    //     break;
    //
    //   default:
    // return Form(
    //     key: _formKey,
    //     child: SafeArea(
    //       child: SizedBox(
    //         width: double.infinity,
    //         child: Padding(
    //           padding: EdgeInsets.symmetric(
    //               horizontal: getProportionateScreenWidth(25)),
    //           child: SingleChildScrollView(
    //             child: Column(
    //               children: [
    //                 SizedBox(height: SizeConfig.screenHeight * 0.02),
    //                 TextField(
    //                   onChanged: (value) {
    //                     setState(() {
    //                       country = value;
    //                     });
    //                   },
    //                   enabled: false,
    //                   keyboardType: TextInputType.text,
    //                   controller: countryController,
    //                   decoration: InputDecoration(
    //                     hintText: AppLocalizations.of(context)
    //                         .translate("Enter Country Name"),
    //                     enabledBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.grey),
    //                       //  when the TextFormField in unfocused
    //                     ),
    //                     focusedBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.blue),
    //                       //  when the TextFormField in focused
    //                     ),
    //                     border: UnderlineInputBorder(),
    //
    //                     // If  you are using latest version of flutter then lable text and hint text shown like this
    //                     // if you r using flutter less then 1.20.* then maybe this is not working properly
    //                     // floatingLabelBehavior: FloatingLabelBehavior.always,
    //                     contentPadding: EdgeInsets.all(5),
    //                     //Change this value to custom as you like
    //                     isDense: true,
    //                   ),
    //                 ),
    //                 SizedBox(height: getProportionateScreenHeight(20)),
    //                 TextFormField(
    //                   onChanged: (value) {
    //                     setState(() {
    //                       state = value;
    //                     });
    //                   },
    //                   enabled: false,
    //
    //                   keyboardType: TextInputType.text,
    //                   controller: stateController,
    //                   decoration: InputDecoration(
    //                     hintText: AppLocalizations.of(context)
    //                         .translate("Enter State Name"),
    //                     enabledBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.grey),
    //                       //  when the TextFormField in unfocused
    //                     ),
    //                     focusedBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.blue),
    //                       //  when the TextFormField in focused
    //                     ),
    //                     border: UnderlineInputBorder(),
    //
    //                     // If  you are using latest version of flutter then lable text and hint text shown like this
    //                     // if you r using flutter less then 1.20.* then maybe this is not working properly
    //                     // floatingLabelBehavior: FloatingLabelBehavior.always,
    //                     contentPadding: EdgeInsets.all(5),
    //                     //Change this value to custom as you like
    //                     isDense: true,
    //                   ),
    //                 ),
    //                 SizedBox(height: getProportionateScreenHeight(20)),
    //                 TextFormField(
    //                   onChanged: (value) {
    //                     setState(() {
    //                       city = value;
    //                     });
    //                   },
    //                   enabled: false,
    //                   maxLength: 100,
    //                   keyboardType: TextInputType.text,
    //                   controller: cityController,
    //                   decoration: InputDecoration(
    //                     hintText: AppLocalizations.of(context)
    //                         .translate("Enter City Name"),
    //                     enabledBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.grey),
    //                       //  when the TextFormField in unfocused
    //                     ),
    //                     focusedBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.blue),
    //                       //  when the TextFormField in focused
    //                     ),
    //                     border: UnderlineInputBorder(),
    //
    //                     // If  you are using latest version of flutter then lable text and hint text shown like this
    //                     // if you r using flutter less then 1.20.* then maybe this is not working properly
    //                     // floatingLabelBehavior: FloatingLabelBehavior.always,
    //                     contentPadding: EdgeInsets.all(5),
    //                     //Change this value to custom as you like
    //                     isDense: true,
    //                   ),
    //                 ),
    //                 // SizedBox(height: getProportionateScreenHeight(20)),
    //                 TextFormField(
    //                   onChanged: (value) {
    //                     setState(() {
    //
    //                       street = value;
    //                     });
    //                   },
    //                   validator: validateStreet,
    //                   maxLength: 100,
    //                   keyboardType: TextInputType.text,
    //                   controller: streetController,
    //                   decoration: InputDecoration(
    //                     hintText: AppLocalizations.of(context)
    //                         .translate("Enter Street"),
    //                     enabledBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.grey),
    //                       //  when the TextFormField in unfocused
    //                     ),
    //                     focusedBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.blue),
    //                       //  when the TextFormField in focused
    //                     ),
    //                     border: UnderlineInputBorder(),
    //
    //                     // If  you are using latest version of flutter then lable text and hint text shown like this
    //                     // if you r using flutter less then 1.20.* then maybe this is not working properly
    //                     // floatingLabelBehavior: FloatingLabelBehavior.always,
    //                     contentPadding: EdgeInsets.all(5),
    //                     //Change this value to custom as you like
    //                     isDense: true,
    //                   ),
    //                 ),
    //                 // SizedBox(height: getProportionateScreenHeight(20)),
    //                 TextFormField(
    //                   onChanged: (value) {
    //                     setState(() {
    //                       buildingName = value;
    //                     });
    //                   },
    //                   maxLength: 5,
    //                   validator: valideBulding,
    //                   keyboardType: TextInputType.number,
    //                   controller: _textFieldControllerBuildingName,
    //                   decoration: InputDecoration(
    //                     hintText: AppLocalizations.of(context)
    //                         .translate("Enter Building Name"),
    //                     enabledBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.grey),
    //                       //  when the TextFormField in unfocused
    //                     ),
    //                     focusedBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.blue),
    //                       //  when the TextFormField in focused
    //                     ),
    //                     border: UnderlineInputBorder(),
    //
    //                     // If  you are using latest version of flutter then lable text and hint text shown like this
    //                     // if you r using flutter less then 1.20.* then maybe this is not working properly
    //                     // floatingLabelBehavior: FloatingLabelBehavior.always,
    //                     contentPadding: EdgeInsets.all(5),
    //                     //Change this value to custom as you like
    //                     isDense: true,
    //                   ),
    //                 ),
    //                 // SizedBox(height: getProportionateScreenHeight(20)),
    //                 TextFormField(
    //                   onChanged: (value) {
    //                     setState(() {
    //                       floorNumber = value;
    //                     });
    //                   },
    //                   maxLength: 5,
    //                   keyboardType: TextInputType.number,
    //                   controller: _textFieldControllerFloorNumber,
    //                   validator: valideFloor,
    //                   decoration: InputDecoration(
    //                     hintText: AppLocalizations.of(context)
    //                         .translate("Enter Floor Name"),
    //                     enabledBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.grey),
    //                       //  when the TextFormField in unfocused
    //                     ),
    //                     focusedBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.blue),
    //                       //  when the TextFormField in focused
    //                     ),
    //                     border: UnderlineInputBorder(),
    //
    //                     // If  you are using latest version of flutter then lable text and hint text shown like this
    //                     // if you r using flutter less then 1.20.* then maybe this is not working properly
    //                     // floatingLabelBehavior: FloatingLabelBehavior.always,
    //                     contentPadding: EdgeInsets.all(5),
    //                     //Change this value to custom as you like
    //                     isDense: true,
    //                   ),
    //                 ),
    //                 // SizedBox(height: getProportionateScreenHeight(20)),
    //                 TextFormField(
    //                   onChanged: (value) {
    //                     setState(() {
    //                       flatNumber = value;
    //                     });
    //                   },
    //                   maxLength: 5,
    //                   validator: valideFlat,
    //                   keyboardType: TextInputType.text,
    //                   controller: _textFieldControllerFlatNumber,
    //                   decoration: InputDecoration(
    //                     hintText: AppLocalizations.of(context)
    //                         .translate("Enter Flat Number"),
    //                     enabledBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.grey),
    //                       //  when the TextFormField in unfocused
    //                     ),
    //                     focusedBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.blue),
    //                       //  when the TextFormField in focused
    //                     ),
    //                     border: UnderlineInputBorder(),
    //
    //                     // If  you are using latest version of flutter then lable text and hint text shown like this
    //                     // if you r using flutter less then 1.20.* then maybe this is not working properly
    //                     // floatingLabelBehavior: FloatingLabelBehavior.always,
    //                     contentPadding: EdgeInsets.all(5),
    //                     //Change this value to custom as you like
    //                     isDense: true,
    //                   ),
    //                 ),
    //                 // SizedBox(height: getProportionateScreenHeight(20)),
    //                 TextFormField(
    //                   onChanged: (value) {
    //                     setState(() {
    //                       phone = value;
    //                     });
    //                   },
    //                   validator: validateMobile,
    //                   maxLength: 11,
    //                   keyboardType: TextInputType.phone,
    //                   controller: _textFieldControllerPhone,
    //                   decoration: InputDecoration(
    //                     hintText: AppLocalizations.of(context)
    //                         .translate("Enter your phone number"),
    //                     enabledBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.grey),
    //                       //  when the TextFormField in unfocused
    //                     ),
    //                     focusedBorder: UnderlineInputBorder(
    //                       borderSide: BorderSide(color: Colors.blue),
    //                       //  when the TextFormField in focused
    //                     ),
    //                     border: UnderlineInputBorder(),
    //
    //                     // If  you are using latest version of flutter then lable text and hint text shown like this
    //                     // if you r using flutter less then 1.20.* then maybe this is not working properly
    //                     // floatingLabelBehavior: FloatingLabelBehavior.always,
    //                     contentPadding: EdgeInsets.all(5),
    //                     //Change this value to custom as you like
    //                     isDense: true,
    //                   ),
    //                 ),
    //
    //                 SizedBox(height: SizeConfig.screenHeight * 0.08),
    //                 FormError(errors: errors),
    //                 SizedBox(height: SizeConfig.screenHeight * 0.08),
    //
    //                 DefaultButton(
    //                   text: AppLocalizations.of(context).translate("Pay"),
    //                   press: () async {
    //                     if (_formKey.currentState.validate()) {
    //                       _formKey.currentState.save();
    //                       codeDialogPhone = "+2$phone";
    //                       codeDialogFlatNumber = flatNumber;
    //                       codeDialogBuildingName = buildingName;
    //                       codeDialogFloorNumber = floorNumber;
    //                       codeDialogCity = city;
    //                       codeDialogStreet = street;
    //                       codeDialogCountry = country;
    //                       codeDialogState = state;
    //
    //
    //                         final navigator = Navigator.of(context);
    //
    //                         await navigator.push(
    //                           MaterialPageRoute(
    //                             builder: (context) => PaymentScreen(
    //                                 city: cityController.text,
    //                                 street: streetController.text,
    //                                 building:
    //                                     _textFieldControllerBuildingName.text,
    //                                 floor: _textFieldControllerFloorNumber.text,
    //                                 flatNumber:
    //                                     _textFieldControllerFlatNumber.text,
    //                                 phone:
    //                                     "+2${_textFieldControllerPhone.text}",
    //                               lat:  lat,
    //                               long: long),
    //                           ),
    //                         );
    //
    //                     }
    //                   },
    //                 ),
    //
    //                 SizedBox(height: getProportionateScreenHeight(20)),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     ));
    // break;
    // }
  }

}
