import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:aakaker/screens/send_prescision_image/send_prescription_image_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:aakaker/screens/Conection/components/body.dart';


class UploadImagePrescsionPage extends StatefulWidget {
  @override
  _UploadImagePrescsionPageState createState() =>
      _UploadImagePrescsionPageState();
}

class _UploadImagePrescsionPageState extends State<UploadImagePrescsionPage>  {
  File _image;


  // Map _source = {ConnectivityResult.none: false};
  // MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _connectivity.initialise();
    // _connectivity.myStream.listen((source) {
    //   setState(() => _source = source);
    // });
  }


  imgFromCamera(BuildContext context) async {
    final navigator = Navigator.of(context);
    File pickedImage = await ImagePicker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {

      print("clicked");
      setState(() {
        _image = pickedImage;
      });




      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder:
                  (BuildContext context) =>
              new SendPrescriptionImageScreen(image: _image,)));

    }
  }
  imgFromGallery(BuildContext context) async {
    final navigator = Navigator.of(context);
    File pickedImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      _image = pickedImage;

      // await navigator.push(
      //   MaterialPageRoute(
      //     builder: (context) =>
      //         SendPrescriptionImageScreen(
      //           image: _image,
      //         ),
      //   ),
      // );

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder:
                  (BuildContext context) =>
              new SendPrescriptionImageScreen(image: _image,)));

    }
  }

  @override
  Widget build(BuildContext context) {

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
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Text(
                        AppLocalizations.of(context).translate("Take image or upload image"),
                        style: TextStyle(color: Colors.black54, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: new Container(
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(
                          color: Colors.white,
                          onPressed: () {
                            imgFromGallery(context);
                          },
                          child: new Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: Image.asset("assets/icons/upload.png",
                                    width: 35),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  AppLocalizations.of(context).translate("Upload Photo"),
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(
                            top: 35,
                            bottom: 35,
                          ),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.black38,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: new Container(
                        margin: EdgeInsets.all(10),
                        child: RaisedButton(

                          color: Colors.white,
                          onPressed: () {
                            // _imgFromCamera();
                            // Navigator.of(context).pop();
                            imgFromCamera(context);



                          },
                          child: new Column(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                child: SvgPicture.asset(
                                  "assets/icons/Camera Icon.svg",
                                  width: 35,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  AppLocalizations.of(context).translate("Take Photo"),
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ),
                            ],
                          ),
                          padding: EdgeInsets.only(
                            top: 35,
                            bottom: 35,
                          ),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.black38,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),



            ],
          ),
        );
      },
    );

  }


}
