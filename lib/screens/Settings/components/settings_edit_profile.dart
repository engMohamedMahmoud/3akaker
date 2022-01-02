import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aakaker/components/default_button.dart';
import 'package:aakaker/components/form_error.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/Conection/components/body.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:aakaker/screens/profile/profile_screen.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class SignUpForm extends StatefulWidget {

  final String phoneNumber;
  final String email;
  final String firstName;
  final String lastName;
  SignUpForm({
    Key key, this.phoneNumber, this.email, this.firstName, this.lastName
  }) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState(phoneNumber, email, firstName, lastName);
}

class _SignUpFormState extends State<SignUpForm> with WidgetsBindingObserver {

  TextEditingController _textFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String imageURl;

  _SignUpFormState(this.phoneNumber, this.email, this.firstName, this.lastName);

  String userId;
  String pic;
  File _image;
  // String cashImage;

  String cashImage, imagUrl;


  @override
  void initState() {
    // TODO: implement initState


    getUserDetails();
    setState(() {
      getUserDetails();
    });
    getData();
    super.initState();
  }

  getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      if(prefs.getString("ProfilePicture") != null){
        imagUrl = "${prefs.getString("ProfilePicture")}";
      }

      if ((imagUrl == null || imagUrl == '') && (_image == null || _image.path.length == 0)) {
        cashImage = "https://img.icons8.com/pastel-glyph/2x/person-male.png";
      }else if (imagUrl != null || imagUrl != '') {
        cashImage = imagUrl;
      }



    });




  }


  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // if(prefs.getString("ProfilePicture") != ""){
    //   pic = "${prefs.getString("ProfilePicture")}";
    // }
    pic = "${prefs.getString("ProfilePicture")}";
    userId = prefs.getString('_id');
    print("pic : ${pic}");

  }

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




  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await  ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
      print("img: ${_image.path}");
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text(AppLocalizations.of(context).translate("Photo Library")),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text(AppLocalizations.of(context).translate("Camera")),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  createUser() async{
    var appLanguage = Provider.of<AppLanguage>(context);
    print("$url/User/Register");
    final String apiUrl = "$url/User/Edit/";

    final response = await http.post(apiUrl, body: {
      "_id":userId,
      'FirstName': firstName,
      "LastName":lastName,
      "Email":email,
      "Language": appLanguage.appLocal.languageCode.toUpperCase()
    });

    var jsonData = json.decode(response.body);

    try{
      if (response.statusCode == 200){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('FirstName', jsonData["FirstName"]);
        prefs.setString('LastName', jsonData["LastName"]);
        prefs.setString('Email', jsonData["Email"]);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder:
                    (BuildContext context) =>
                new ProfileScreen()));
      }

    }catch(err){
      print(err);
    }


  }

  uploadimg() async {

    var appLanguage = Provider.of<AppLanguage>(context);
    var request =  http.MultipartRequest(
        'POST', Uri.parse("$url/User/Edit/")

    );
    //Header....


    request.fields['_id'] = userId;
    request.fields['FirstName'] = firstName;
    request.fields["LastName"]= lastName;
    request.fields["Email"] = email;
    request.fields["Language"]= appLanguage.appLocal.languageCode.toUpperCase();
    request.fields['ProfilePicture'] = (_image != null)?  _image.toString(): pic;
    request.files.add(await http.MultipartFile.fromPath(
        'ProfilePicture',

          (_image != null)?  _image.path: pic
    )
    );

    var response = await request.send();
    final res = await http.Response.fromStream(response);
    print(response.statusCode);
    print(res.body);

    var jsonData = json.decode(res.body);
    try{
      if (response.statusCode == 200){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('_id', jsonData["_id"]);
        prefs.setString('FirstName', jsonData["FirstName"]);
        prefs.setString('LastName', jsonData["LastName"]);
        prefs.setString('Email', jsonData["Email"]);
        prefs.setString('ProfilePicture', jsonData["ProfilePicture"]);
        print(prefs.getString("ProfilePicture"));


        Toast.show(AppLocalizations.of(context).translate("Your Settings has been edit successfully"),context,backgroundColor:Colors.green, textColor: Colors.white);



      } else{
        Toast.show(res.body,context,backgroundColor:Colors.red, textColor: Colors.white);

      }
    }catch(err){
      print(err);
    }
  }


  String validatePassword(String value) {
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return AppLocalizations.of(context).translate("Enter your new password");
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
      return AppLocalizations.of(context).translate("Email is required");
    } else {
      if (!regex.hasMatch(value))
        return AppLocalizations.of(context).translate("Please Enter Valid Email");
      else
        return null;
    }
  }

  String validateLastName(String value) {

    if (value.isEmpty) {
      return  AppLocalizations.of(context).translate("Last name is required");
    } else if (value.length > 30){
      return  AppLocalizations.of(context).translate("Length must be 30 chars or less than 30");
    }
  }

  String validateFirstName(String value) {

    if (value.isEmpty) {
      return  AppLocalizations.of(context).translate("First name is required");
    } else if (value.length > 30){
      return  AppLocalizations.of(context).translate("Length must be 30 chars or less than 30");
    }

  }



  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context,listen: false);
    print(pic);

    return

      OfflineBuilder(
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
              // SizedBox(
              //   height: 115,
              //   width: 115,
              //   child: Stack(
              //     clipBehavior: Clip.none, fit: StackFit.expand,
              //     children: [
              //       // CircleAvatar(
              //       //   backgroundImage: AssetImage("assets/images/Profile Image.png"),
              //       // ),
              //
              //       Center(
              //         child: GestureDetector(
              //           onTap: () {
              //             _showPicker(context);
              //           },
              //           child: Container(
              //               child: _image != null
              //                   ?
              //               ClipRRect(
              //                 borderRadius: BorderRadius.circular(50),
              //                 // decoration: BoxDecoration(
              //                 //   borderRadius: BorderRadius.circular(50),
              //                 // ),
              //                 child: Image.file(
              //                   _image,
              //                   width: 100,
              //                   height: 100,
              //                   fit: BoxFit.cover,
              //                 ),
              //               )
              //                   :
              //               Container(
              //                 decoration: BoxDecoration(
              //                     color: Colors.grey[200],
              //                     borderRadius: BorderRadius.circular(50)),
              //                 width: 100,
              //                 height: 100,
              //                 child:  Image.asset(cashImage),
              //               ),
              //
              //
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         right: -16,
              //         bottom: 0,
              //         child: SizedBox(
              //           height: 46,
              //           width: 46,
              //           child: FlatButton(
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(50),
              //               side: BorderSide(color: Colors.white),
              //             ),
              //             color: Color(0xFFF5F6F9),
              //             onPressed: () {
              //               _showPicker(context);
              //             },
              //             child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              //
              // SizedBox(height: getProportionateScreenHeight(40)),

              SizedBox(height: getProportionateScreenHeight(10)),
              // SizedBox(
              //   height: 115,
              //   width: 115,
              //   child: Stack(
              //     clipBehavior: Clip.none, fit: StackFit.expand,
              //     children: [
              //
              //       Center(
              //         child: GestureDetector(
              //           onTap: () {
              //             _showPicker(context);
              //           },
              //           child: Container(
              //             child: _image != null
              //                 ?
              //             ClipRRect(
              //               borderRadius: BorderRadius.circular(50),
              //               // decoration: BoxDecoration(
              //               //   borderRadius: BorderRadius.circular(50),
              //               // ),
              //               child: Image.file(
              //                 _image,
              //                 width: 100,
              //                 height: 100,
              //                 fit: BoxFit.cover,
              //               ),
              //             )
              //                 :
              //
              //             Container(
              //                 decoration: BoxDecoration(
              //                     color: Colors.grey[200],
              //                     borderRadius: BorderRadius.circular(50)),
              //                 width: 100,
              //                 height: 100,
              //                 child:
              //                 ClipRRect(
              //                   borderRadius: BorderRadius.circular(50),
              //                   // decoration: BoxDecoration(
              //                   //   borderRadius: BorderRadius.circular(50),
              //                   // ),
              //                   child: Image.network(
              //                     "https://img.favpng.com/20/2/6/circle-computer-icons-button-person-icon-png-favpng-6BzqzV9DFYcskZFx5y6vYTcm2.jpg",
              //                     width: 100,
              //                     height: 100,
              //                     fit: BoxFit.cover,
              //                   ),
              //                 )
              //             ),
              //
              //
              //           ),
              //         ),
              //       ),
              //       Positioned(
              //         right: -16,
              //         bottom: 0,
              //         child: SizedBox(
              //           height: 46,
              //           width: 46,
              //           child: FlatButton(
              //             padding: EdgeInsets.all(10),
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(23),
              //               side: BorderSide(color: Colors.white),
              //             ),
              //             color: Color(0xFFF5F6F9),
              //             onPressed: () {
              //               _showPicker(context);
              //             },
              //             child: Icon(Icons.camera_alt_sharp,color: Colors.grey,),
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              SizedBox(
                height: 115,
                width: 115,
                child: Stack(
                  clipBehavior: Clip.none, fit: StackFit.expand,
                  children: [
                    // CircleAvatar(
                    //   backgroundImage: AssetImage("assets/images/Profile Image.png"),
                    // ),

                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: Container(
                          child: _image != null?
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            // decoration: BoxDecoration(
                            //   borderRadius: BorderRadius.circular(50),
                            // ),
                            child: Image.file(
                              _image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                              :

                          Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(50)),
                              width: 100,
                              height: 100,
                              child:
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(50),
                                // ),
                                child: Image.network(
                                  cashImage,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              )
                          ),


                        ),
                      ),
                    ),
                    Positioned(
                      right: -16,
                      bottom: 0,
                      child: SizedBox(
                        height: 46,
                        width: 46,
                        child: FlatButton(
                          padding: EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(23),
                            side: BorderSide(color: Colors.white),
                          ),
                          color: Color(0xFFF5F6F9),
                          onPressed: () {
                            _showPicker(context);
                          },
                          child: Icon(Icons.camera_alt_sharp,color: Colors.grey,),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              buildFirstNameFormField(),
              SizedBox(height: getProportionateScreenHeight(20)),
              buildLastNameFormField(),
              SizedBox(height: getProportionateScreenHeight(20)),
              buildPhoneFormField(),
              SizedBox(height: getProportionateScreenHeight(20)),
              buildEmailFormField(),
              SizedBox(height: getProportionateScreenHeight(20)),

              // FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(30)),
              ArgonButton(
                height: 50,
                roundLoadingShape: true,
                width: MediaQuery.of(context).size.width * 0.9,
                onTap: (startLoading, stopLoading, btnState) async {

                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();
                    if (_image != null ){
                      if (btnState == ButtonState.Idle) {
                        startLoading();

                        var request =  http.MultipartRequest(
                            'POST', Uri.parse("$url/User/Edit/")

                        );
                        //Header....



                        request.headers["authorization"] = prefs.getString('token');
                        request.fields['_id'] = userId;
                        request.fields['FirstName'] = firstName;
                        request.fields["LastName"]= lastName;
                        request.fields["Email"] = email;
                        request.fields["Language"]= appLanguage.appLocal.languageCode.toUpperCase();
                        request.fields['ProfilePicture'] = (_image != null)?  _image.toString(): pic;
                        request.files.add(await http.MultipartFile.fromPath(
                            'ProfilePicture',

                            (_image != null)?  _image.path: pic
                        )
                        );

                        print("id:  ${request.fields['_id']}");
                        print("first name:  ${request.fields['FirstName']}");
                        print("last name:  ${request.fields['LastName']}");
                        print("email:  ${request.fields['Email']}");
                        print("lang:  ${request.fields['Language']}");
                        print("header:  ${request.headers['authorization']}");

                        var response = await request.send();
                        final res = await http.Response.fromStream(response);
                        print(response.statusCode);
                        print(res.body);

                        var jsonData = json.decode(res.body);
                        try{
                          if (response.statusCode == 200){
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('_id', jsonData["_id"]);
                            prefs.setString('FirstName', jsonData["FirstName"]);
                            prefs.setString('LastName', jsonData["LastName"]);
                            prefs.setString('Email', jsonData["Email"]);
                            prefs.setString('ProfilePicture', jsonData["ProfilePicture"]);
                            print(prefs.getString("ProfilePicture"));


                            stopLoading();
                            Toast.show(AppLocalizations.of(context).translate("Your Settings has been edit successfully"),context,backgroundColor:Colors.green, textColor: Colors.white,duration: 3,gravity: Toast.TOP);



                          } else{
                            stopLoading();
                            Toast.show(res.body,context,backgroundColor:Colors.red, textColor: Colors.white,duration: 3,gravity: Toast.TOP);

                          }
                        }catch(err){
                          print(err);
                          stopLoading();
                        }

                      }

                    }else{

                      if (btnState == ButtonState.Idle) {
                        startLoading();
                        print("$url/User/Register");
                        final String apiUrl = "$url/User/Edit/";

                        final response = await http.post(apiUrl, body: {
                          "_id":userId,
                          'FirstName': firstName,
                          "LastName":lastName,
                          "Email":email,
                          "Language": appLanguage.appLocal.languageCode.toUpperCase()
                        },headers: {"authorization":prefs.getString('token')});

                        var jsonData = json.decode(response.body);

                        try{
                          if (response.statusCode == 200){
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('FirstName', jsonData["FirstName"]);
                            prefs.setString('LastName', jsonData["LastName"]);
                            prefs.setString('Email', jsonData["Email"]);

                            stopLoading();
                            Toast.show(AppLocalizations.of(context).translate("Your Settings has been edit successfully"),context,backgroundColor:Colors.green, textColor: Colors.white,gravity: Toast.TOP,duration: 3);


                          }else{
                            stopLoading();
                            Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white,duration: 3,gravity: Toast.TOP);
                          }

                        }catch(err){
                          print(err);
                          stopLoading();
                        }

                      }

                    }
                  }

                },
                child: Text(
                  AppLocalizations.of(context).translate("Edit Profile Details"),
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
            ],
          ),
        );
      },
    );




    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              clipBehavior: Clip.none, fit: StackFit.expand,
              children: [
                // CircleAvatar(
                //   backgroundImage: AssetImage("assets/images/Profile Image.png"),
                // ),

                Center(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: Container(
                      child: _image != null
                          ?
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(50),
                        // ),
                        child: Image.file(
                          _image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      )
                          :
                      ( (pic != null)? ClipRRect(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(50),
                        // ),
                        borderRadius: BorderRadius.circular(50),
                        child: Image.network(
                          pic,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ): const ProfileUserDetailsWidget())


                    ),
                  ),
                ),
                Positioned(
                  right: -16,
                  bottom: 0,
                  child: SizedBox(
                    height: 46,
                    width: 46,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                        side: BorderSide(color: Colors.white),
                      ),
                      color: Color(0xFFF5F6F9),
                      onPressed: () {
                        _showPicker(context);
                      },
                      child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(40)),
          buildFirstNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildLastNameFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          SizedBox(height: SizeConfig.screenHeight * 0.04),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(40)),
          DefaultButton(
            text: AppLocalizations.of(context).translate("Edit Profile Details"),
            press: () async {
              // if (_formKey.currentState.validate()) {
              //   _formKey.currentState.save();
              //   // if all are valid then go to success screen
              // }

              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                if (_image != null ){
                  uploadimg();
                }else{
                  createUser();
                }


              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
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
      return AppLocalizations.of(context).translate("Mobile is required");
    }
    else if (!regExp.hasMatch(value)) {
      return AppLocalizations.of(context).translate("Please enter valid mobile number");
    }
    return null;
  }

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      enabled: false,
      initialValue: phoneNumber.substring(2),
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).translate("Mobile is required"));
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error:  AppLocalizations.of(context).translate("Please enter valid mobile number"));
        }
        return null;
      },
      validator: validateMobile,
      maxLength: 30,
      decoration: InputDecoration(
        counterStyle: TextStyle(height: double.minPositive,),
        counterText: "",
        // labelText: "Email",
        hintText: AppLocalizations.of(context).translate("Enter phone number"),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
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
        contentPadding: EdgeInsets.all(5), //Change this value to custom as you like
        isDense: true,
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      initialValue: email,
      onSaved: (newValue) => email = newValue.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).translate("Email is required"));
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error:  AppLocalizations.of(context).translate("Please Enter Valid Email"));
        }
        return null;
      },
      validator: validateEmail,
      maxLength: 50,
      decoration: InputDecoration(
        counterStyle: TextStyle(height: double.minPositive,),
        counterText: "",
        // labelText: "Email",
        hintText: AppLocalizations.of(context).translate("Enter email"),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        // suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
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
        contentPadding: EdgeInsets.all(5), //Change this value to custom as you like
        isDense: true,
      ),
    );
  }
  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue.trim(),

      initialValue: firstName,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).translate("First name is required"));
        }
        return null;
      },
      validator: validateFirstName,
      maxLength: 30,

      decoration: InputDecoration(
        counterStyle: TextStyle(height: double.minPositive,),
        counterText: "",

        hintText: AppLocalizations.of(context).translate("Enter your First Name"),
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
    );
  }
  TextFormField buildLastNameFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue.trim(),
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).translate("Last name is required"));
        }
        return null;
      },
      validator: validateLastName,
      maxLength: 30,

      initialValue: lastName,
      decoration: InputDecoration(
        counterStyle: TextStyle(height: double.minPositive,),
        counterText: "",
        hintText: AppLocalizations.of(context).translate("Enter your Last Name"),
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
    );
  }




}


class ProfileUserDetailsWidget extends StatelessWidget {
  const ProfileUserDetailsWidget();




  @override
  Widget build(BuildContext context) {
    print('building `BackgroundWidget`');
    return
      ClipRRect(
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(50),
        // ),
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            "https://koshofat.com/wp-content/themes/dmidoctors/assets/koshofat/images/default-thumbnail.png",
            fit: BoxFit.cover,width: 100, height: 100,
          )
      );
  }
}