import 'dart:io';

import 'package:aakaker/screens/PhramysNames/HomeNames.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:aakaker/components/form_error.dart';
import 'package:aakaker/components/have_account_text.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:aakaker/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:toast/toast.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SignUpForm extends StatefulWidget {

  final String phoneNumber;
  SignUpForm({
    Key key, this.phoneNumber
  }) : super(key: key);
  @override
  _SignUpFormState createState() => _SignUpFormState(phoneNumber);
}

class _SignUpFormState extends State<SignUpForm> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String password;
  String conform_password;

  _SignUpFormState(this.phoneNumber);


  bool remember = false;
  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }


  double deliverCost = 0.00;
  Future getDeliveryCost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse("https://alsaydaly.herokuapp.com/User/Shipping"),headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${prefs.getString("token")}"
    });


    if (response.statusCode == 200) {
      setState(() {

        var data = json.decode(response.body);
        double jsonResponse = double.parse(data);
        deliverCost = jsonResponse.toDouble();
        prefs.setDouble("shippingCost", deliverCost);


        print("max value : ${response.body}");

      });

    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  @override
  void initState() {


    setState(() {
      getDeliveryCost();
    });


    super.initState();


  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }


  File _image;

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
     var appLanguage = Provider.of<AppLanguage>(context,listen: false);
     print("$url/User/Register");
    final String apiUrl = "$url/User/Register/";

    final response = await http.post(apiUrl, body: {
      'FirstName': firstName,
      "LastName":lastName, "Password":password,
      "Email":email,
      "Number": phoneNumber,
      "Language": appLanguage.appLocal.languageCode.toUpperCase()
    });

    var jsonData = json.decode(response.body);

    try{
      if (response.statusCode == 200){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', jsonData["token"]);
        prefs.setString('_id', jsonData["data"]["_id"]);
        prefs.setString('FirstName', jsonData["data"]["FirstName"]);
        prefs.setString('LastName', jsonData["data"]["LastName"]);
        prefs.setString('Email', jsonData["data"]["Email"]);
        prefs.setString('Number', jsonData["data"]["Number"]);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder:
                    (BuildContext context) =>
                new NamesScreen(name: "${jsonData["data"]["FirstName"]} ${jsonData["data"]["LastName"]}",
                    imageUrl: "data:image/jpeg;base64,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")));
      } else{

        Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white,gravity: Toast.TOP);

      }
    }catch(err){
      print(err);
    }


  }

  uploadimg() async {

    var appLanguage = Provider.of<AppLanguage>(context);
    var request =  http.MultipartRequest(
        'POST', Uri.parse("$url/User/Register/")

    );
    //Header....

    request.fields['FirstName'] = firstName;
    request.fields["LastName"]= lastName;
    request.fields["Password"] = password;
    request.fields["Email"] = email;
    request.fields["Number"]= phoneNumber;
    request.fields["Language"]= appLanguage.appLocal.languageCode.toUpperCase();
    request.fields['ProfilePicture '] = _image.toString();
    request.files.add(await http.MultipartFile.fromPath(
        'ProfilePicture',
        _image.path
    )
    );
    var response = await request.send();
    final res = await http.Response.fromStream(response);
    print(res.body);

    var jsonData = json.decode(res.body);
    try{
      if (response.statusCode == 200){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token',jsonData["token"]);
        prefs.setString('_id', jsonData["data"]["_id"]);
        prefs.setString('FirstName', jsonData["data"]["FirstName"]);
        prefs.setString('LastName', jsonData["data"]["LastName"]);
        prefs.setString('Email', jsonData["data"]["Email"]);
        prefs.setString('Number', jsonData["data"]["Number"]);
        prefs.setString('ProfilePicture', jsonData["data"]["ProfilePicture"]);

        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder:
                    (BuildContext context) =>
                new NamesScreen(name: "${jsonData["data"]["FirstName"]} ${jsonData["data"]["LastName"]}",imageUrl: jsonData["data"]["ProfilePicture"],)));
      } else{

        Toast.show(res.body,context,backgroundColor:Colors.red, textColor: Colors.white,gravity: Toast.TOP);


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
      return AppLocalizations.of(context).translate("Password is required");
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

  String validateConfirmPassword(String value) {

    if (value.isEmpty) {
      return  AppLocalizations.of(context,).translate("Re-enter password is required");
    }else if (value != password ){
      return AppLocalizations.of(context).translate("Passwords don't match");
    }
  }




  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context,listen: false);
    return Form(
      key: _formKey,
      child: Column(
        children: [

          Align(
              alignment: appLanguage.appLocal.languageCode == 'en' ? Alignment.topLeft : Alignment.topRight,
              child: Text(AppLocalizations.of(context).translate("Create New Account"),style: headingStyle)
          ),

          SizedBox(height: getProportionateScreenHeight(30)),

          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              clipBehavior: Clip.none, fit: StackFit.expand,
              children: [
                // CircleAvatar(
                //   backgroundImage: AssetImage("assets/images/Profile Image.png"),
                // ),
                CircleAvatar(
                  radius: 55,
                  backgroundColor: KSecondLightButton,

                  child: _image != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.file(
                      _image,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  )
                      : Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(50)), width: 100, height: 100, child: Icon(Icons.camera_alt,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: kPrimaryColor,
                      child: _image != null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          _image,
                          width: 100,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                      )
                          : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(50)),
                        width: 100,
                        height: 100,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
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
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(20)),
          buildConformPassFormField(),
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
                if (_image != null){
                  if (btnState == ButtonState.Idle) {
                    startLoading();
                    // uploadimg();
                    var request =  http.MultipartRequest(
                        'POST', Uri.parse("$url/User/Register/"),

                    );
                    //Header....

                    request.headers["authorization"] = prefs.getString('token');

                    request.fields['FirstName'] = firstName;
                    request.fields["LastName"]= lastName;
                    request.fields["Password"] = password;
                    request.fields["Email"] = email;
                    request.fields["Number"]= phoneNumber;
                    request.fields["Language"]= appLanguage.appLocal.languageCode.toUpperCase();
                    request.fields['ProfilePicture '] = _image.toString();
                    request.files.add(await http.MultipartFile.fromPath(
                        'ProfilePicture',
                        _image.path
                    )
                    );
                    var response = await request.send();
                    final res = await http.Response.fromStream(response);
                    print(res.body);

                    var jsonData = json.decode(res.body);
                    try{
                      if (response.statusCode == 200){
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.setString('token',jsonData["token"]);
                        prefs.setString('_id', jsonData["data"]["_id"]);
                        prefs.setString('FirstName', jsonData["data"]["FirstName"]);
                        prefs.setString('LastName', jsonData["data"]["LastName"]);
                        prefs.setString('Email', jsonData["data"]["Email"]);
                        prefs.setString('Number', jsonData["data"]["Number"]);
                        prefs.setString('ProfilePicture', jsonData["data"]["ProfilePicture"]);

                        startLoading();
                        Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder:
                                          (BuildContext context) =>
                                      new NamesScreen(name: "${jsonData["data"]["FirstName"]} ${jsonData["data"]["LastName"]}",imageUrl: jsonData["data"]["ProfilePicture"],)));
                      } else{

                        startLoading();
                        Toast.show(res.body,context,backgroundColor:Colors.red, textColor: Colors.white, duration: 5,gravity: Toast.TOP);

                      }
                    }catch(err){
                      stopLoading();
                      print(err);
                    }

                  }


                }else{

                  if (btnState == ButtonState.Idle) {
                    startLoading();
                    // createUser();
                    print("$url/User/Register");
                    final String apiUrl = "$url/User/Register/";

                    final response = await http.post(apiUrl, body: {
                      'FirstName': firstName,
                      "LastName":lastName, "Password":password,
                      "Email":email,
                      "Number": phoneNumber,
                      "Language": appLanguage.appLocal.languageCode.toUpperCase()
                    },headers: {"authorization":prefs.getString('token')});

                    var jsonData = json.decode(response.body);

                    try{
                      if (response.statusCode == 200){

                        prefs.setString('token', jsonData["token"]);
                        prefs.setString('_id', jsonData["data"]["_id"]);
                        prefs.setString('FirstName', jsonData["data"]["FirstName"]);
                        prefs.setString('LastName', jsonData["data"]["LastName"]);
                        prefs.setString('Email', jsonData["data"]["Email"]);
                        prefs.setString('Number', jsonData["data"]["Number"]);

                        stopLoading();
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder:
                                    (BuildContext context) =>
                                new NamesScreen(name: "${jsonData["data"]["FirstName"]} ${jsonData["data"]["LastName"]}",
                                    imageUrl: "https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png")));
                      } else{

                        stopLoading();
                        Toast.show(response.body,context,backgroundColor:Colors.red, textColor: Colors.white,duration: 5,gravity: Toast.TOP);


                      }
                    }catch(err){
                      stopLoading();
                      print(err);
                    }
                  }

                }

              }






            },
            child: Text(
              AppLocalizations.of(context).translate("Register"),
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
          //   text: AppLocalizations.of(context).translate("Register"),
          //   press: () {
          //
          //
          //     if (_formKey.currentState.validate()) {
          //       _formKey.currentState.save();
          //       print("firstname : $firstName");
          //       print("lastname : $lastName");
          //       print("email: $email");
          //       print("pass : $password");
          //       print("phone : $phoneNumber");
          //       if (_image != null){
          //         uploadimg();
          //       }else{
          //
          //         createUser();
          //       }
          //
          //
          //
          //     }
          //
          //
          //   },
          // ),
          SizedBox(height: getProportionateScreenHeight(20)),
          HaveAccountText(),
        ],
      ),
    );
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
        conform_password = value.trim();
      },
      validator: validateConfirmPassword,
      decoration: InputDecoration(
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
      decoration: InputDecoration(
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

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).translate("Password is required"));
        } else if (passwordValidationRexExp.hasMatch(value)) {
          removeError(error:  AppLocalizations.of(context).translate("Enter valid password"));
        }
        password = value.trim();
      },
      validator: validatePassword,

      decoration: InputDecoration(
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
        contentPadding: EdgeInsets.all(5), //Change this value to custom as you like
        isDense: true,
      ),

    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue.trim(),
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
          removeError(error: AppLocalizations.of(context).translate("Enter your Last Name"));
        }
        return null;
      },
      validator: validateLastName,
      maxLength: 30,

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
