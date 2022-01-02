import 'dart:async';
import 'dart:io';

import 'package:aakaker/components/default_button.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:aakaker/screens/home/components/home_services/model.dart';
import 'package:aakaker/screens/send_prescision_image/Roshata_Map/Details/completeMapDetailsRoshata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_pin_picker/map_pin_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import '../../../../size_config.dart';

const String apiKEY = "AIzaSyCtIK7Q4J7IkgUk-EqHaGxjJXg_4tWoM-I";

class MyHomePage extends StatefulWidget {
  final File image;

  const MyHomePage({Key key, @required this.image}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(image);
}

class _MyHomePageState extends State<MyHomePage> {
  Address address;
  var textController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  Completer<GoogleMapController> _controller = Completer();
  MapPickerController mapPickerController = MapPickerController();
  GoogleMapController newGoogleMapController;
  CameraPosition cameraPosition;
  String city;
  String state;
  String street;
  String _result = '---';
  LocationDetails details;
  List<String> add1;
  File image;
  double userLat;
  double userLong;
  Timer timer;
  bool show = false;

  void autoDisplay(){
    timer = new Timer(const Duration(seconds:4),(){
      setState(() {
        show = true;
      });
    });
  }

  _MyHomePageState(this.image);

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
    autoDisplay();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      cameraPosition = CameraPosition(
        target: LatLng(prefs.getDouble('lat'), prefs.getDouble('long')),
        zoom: 14.4746,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (cameraPosition.target == null)
      return Container(
        alignment: Alignment.center,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );

    var appLanguage = Provider.of<AppLanguage>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(true),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        // title: Text(
        //   AppLocalizations.of(context).translate("Map"),
        //   style: TextStyle(color: myColor),
        // ),
        // backgroundColor: kPrimaryColor,
      ),
      body: OfflineBuilder(
          connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child,
              ) {
            if (connectivity == ConnectivityResult.none) {
              return BodyConnection();
            } else {
              return child;
            }
          },
          builder: (BuildContext context) {



      return cameraPosition.target.longitude == null || cameraPosition.target.latitude == null? Container(
        alignment: Alignment.center,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ):Stack(
        children: [
          MapPicker(
            // pass icon widget
            iconWidget: Icon(
              Icons.location_pin,
              color: Colors.red,
              size: 50,
            ),
            //add map picker controller
            mapPickerController: mapPickerController,

            child: GoogleMap(
              zoomControlsEnabled: true,
              zoomGesturesEnabled: true,
              // hide location button
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.normal,
              //  camera position
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                newGoogleMapController = controller;

              },
              onCameraMoveStarted: () {
                // notify map is moving
                mapPickerController.mapMoving();
              },
              onCameraMove: (cameraPosition) {
                this.cameraPosition = cameraPosition;
              },
              onCameraIdle: () async {
                // notify map stopped moving
                mapPickerController.mapFinishedMoving();
                //get address name from camera position
                List<Address> addresses = await Geocoder.local
                    .findAddressesFromCoordinates(Coordinates(
                    cameraPosition.target.latitude,
                    cameraPosition.target.longitude));

                // update the ui with the addressadd

                userLat = addresses.first.coordinates.latitude;
                userLong = addresses.first.coordinates.longitude;
                print("addresses.first?.addressLine ${addresses.first?.addressLine}");


                List<String> add = addresses.first.addressLine.contains('،')?
                addresses.first?.addressLine.split('،'): addresses.first?.addressLine.split(',');


                state = add[add.length - 2];
                add1 = add;

                print("addresses.first?.addressLine.split(',')  $add1");

                textController.text =
                addresses.first.addressLine.contains('،')?
                '${addresses.first?.addressLine.split('،')[0] ?? ''}, ${addresses.first?.addressLine.split('،')[2] ?? ''}':

                '${addresses.first?.addressLine.split(',')[0] ?? ''}, ${addresses.first?.addressLine.split(',')[2] ?? ''}'
                ;
                cityController.text =
                addresses.first.addressLine.contains('،')?
                addresses.first?.addressLine.split('،')[2] ?? '': addresses.first?.addressLine.split(',')[2] ?? '';

                print("textController.text ${textController.text}");

                city = addresses.first.subAdminArea;
                print("cityssss $city");

                if (addresses.first.addressLine.contains('،')) {
                  streetController.text = add1[0] ?? '';
                } else {
                  streetController.text =
                      addresses.first?.addressLine.split(',')[0] ?? '';
                }





                print("ther are ${add1.length}");
              },
            )
          ),
          show == true? Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            height: 170,
            child: Container(
                padding: EdgeInsets.only(bottom: 10, top: 10, right: 30, left: 30),
                color: Colors.white,
                height: 170,
                child: Column(children: [
                  Align(
                      alignment: appLanguage.appLocal.languageCode == 'en'
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: Text(
                          AppLocalizations.of(context)
                              .translate("Delivery Location"),
                          style: TextStyle(color: Colors.blueGrey))),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    controller: textController,
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: getProportionateScreenHeight(10)),
                  DefaultButton(
                    text: AppLocalizations.of(context).translate("Delivery here"),
                    press: () async {
                      if (add1.length != 0) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (BuildContext context) =>
                            new MapDetailsRoshataScreen(
                              addreessDetails: add1,
                              image: image,
                              lat: userLat,
                              long: userLong,
                            )));
                      } else {
                        Toast.show(
                            AppLocalizations.of(context)
                                .translate("Wait, Until Map Load"),
                            context,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            duration: 5);
                      }
                    },
                  )
                ])

              // icon: Icon(Icons.directions_boat),
            ),
          ):Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            height: 0,

          )
        ],
      );
          }
      )
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.transparent,
      //   elevation: 0,
      //   child: Container(
      //       padding: EdgeInsets.only(bottom: 10, top: 10, right: 30, left: 30),
      //       color: Colors.white,
      //       height: 170,
      //       child: Column(children: [
      //         Align(
      //             alignment: appLanguage.appLocal.languageCode == 'en'
      //                 ? Alignment.topLeft
      //                 : Alignment.topRight,
      //             child: Text(
      //                 AppLocalizations.of(context)
      //                     .translate("Delivery Location"),
      //                 style: TextStyle(color: Colors.blueGrey))),
      //         SizedBox(height: getProportionateScreenHeight(10)),
      //         TextFormField(
      //           readOnly: true,
      //           decoration: InputDecoration(
      //             contentPadding: EdgeInsets.zero,
      //             border: InputBorder.none,
      //             focusedBorder: InputBorder.none,
      //             enabledBorder: InputBorder.none,
      //             errorBorder: InputBorder.none,
      //             disabledBorder: InputBorder.none,
      //           ),
      //           controller: textController,
      //           style: TextStyle(
      //               fontSize: 14,
      //               fontWeight: FontWeight.bold,
      //               color: Colors.black),
      //         ),
      //         SizedBox(height: getProportionateScreenHeight(10)),
      //         DefaultButton(
      //           text: AppLocalizations.of(context).translate("Delivery here"),
      //           press: () async {
      //             if (add1.length != 0) {
      //               Navigator.of(context).pushReplacement(MaterialPageRoute(
      //                   builder: (BuildContext context) =>
      //                       new MapDetailsRoshataScreen(
      //                         addreessDetails: add1,
      //                         image: image,
      //                         lat: userLat,
      //                         long: userLong,
      //                       )));
      //             } else {
      //               Toast.show(
      //                   AppLocalizations.of(context)
      //                       .translate("Wait, Until Map Load"),
      //                   context,
      //                   backgroundColor: Colors.red,
      //                   textColor: Colors.white,
      //                   duration: 5);
      //             }
      //           },
      //         )
      //       ])
      //
      //       // icon: Icon(Icons.directions_boat),
      //       ),
      // ),
    );
  }

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

  String codeDialogBuildingName;
  String buildingName;
  TextEditingController _textFieldControllerBuildingName =
      TextEditingController();

  String codeDialogCity;
  String codeDialogStreet;

  Future<void> _displayTextInputDialog1(BuildContext context) async {
    var appLanguage = Provider.of<AppLanguage>(context);
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          // elevation: 16,
          child: Container(
            height: 500.0,
            // margin: EdgeInsets.all(50),
            child: ListView(
              children: <Widget>[
                // SizedBox(height: 20),
                Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Text(
                        AppLocalizations.of(context)
                            .translate("Address Details"),
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold))),
                SizedBox(height: getProportionateScreenHeight(20)),
                Column(children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          city = value;
                        });
                      },
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      controller: streetController,
                      decoration: InputDecoration(
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          buildingName = value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      controller: _textFieldControllerBuildingName,
                      decoration: InputDecoration(
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          flatNumber = value;
                        });
                      },
                      keyboardType: TextInputType.number,
                      controller: _textFieldControllerFlatNumber,
                      decoration: InputDecoration(
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      keyboardType: TextInputType.text,
                      controller: _textFieldController,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)
                            .translate("Enter your user Name"),
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
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                      keyboardType: TextInputType.phone,
                      controller: _textFieldControllerPhone,
                      decoration: InputDecoration(
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
                  ),
                  SizedBox(height: getProportionateScreenHeight(40)),
                  Container(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: RaisedButton(
                          padding: EdgeInsets.all(15),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                              AppLocalizations.of(context).translate("Cancel")),
                          color: Colors.blue,
                          textColor: Colors.white,
                        )),
                        Expanded(
                            child: RaisedButton(
                          padding: EdgeInsets.all(15),
                          onPressed: () {
                            setState(() {
                              codeDialogName = name;
                              codeDialogPhone = phone;
                              codeDialogFlatNumber = flatNumber;
                              codeDialogBuildingName = buildingName;
                              codeDialogCity = city;
                              codeDialogStreet = street;
                              Navigator.pop(context);
                            });
                          },
                          child: Text(
                              AppLocalizations.of(context).translate("Ok")),
                          color: Colors.blue,
                          textColor: Colors.white,
                        )),
                      ],
                    ),
                  )
                ]),
              ],
            ),
          ),
        );
      },
    );
  }
}
