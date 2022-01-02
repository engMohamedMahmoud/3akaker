import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aakaker/components/default_button.dart';
import 'package:aakaker/components/form_error.dart';
import 'package:aakaker/localization/AppLanguage.dart';
import 'package:aakaker/localization/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class AddNotes extends StatefulWidget {
  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  final _formKey = GlobalKey<FormState>();
  String notes;
  bool remember = false;
  final List<String> errors = [];
  var rating = 0.0;

  var textController = TextEditingController();

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
    var appLanguage = Provider.of<AppLanguage>(context);
    return Form(
      key: _formKey,
      child: new GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: new Container(
              color: Colors.white,
              child: new Column(

                children: [
                  Container(
                      // alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 15),

                      alignment: appLanguage.appLocal.languageCode == "en"? Alignment.centerLeft: Alignment.centerRight,
                      child: Text(AppLocalizations.of(context).translate("Rate our service"), style: TextStyle(fontSize: getProportionateScreenWidth(20),
                        fontWeight: FontWeight.bold,
                        color: KTextColor,))),
                  SizedBox(height: getProportionateScreenHeight(20)),



                  SizedBox(height: getProportionateScreenHeight(20)),
                   buildNotesFormField(),
                  FormError(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(40)),
                  DefaultButton(
                    text: AppLocalizations.of(context).translate("Rate our service"),
                    press: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        Navigator.pop(context);
                      }
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                ],
              ))),
    );
  }






  TextFormField buildNotesFormField() {
    return TextFormField(
      onSaved: (newValue) => notes = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: AppLocalizations.of(context).translate("Rate our service"));
        }
        if (value.length >= 499) {
          removeError(error: kMixError);
        }
        return null;
      },

      controller: textController,
      validator: (value) {
        if (value.isEmpty) {
          addError(error: AppLocalizations.of(context).translate("Rate our service"));
          return "";
        }
        return null;
      },
      inputFormatters: [
        new LengthLimitingTextInputFormatter(500),
      ],
      minLines: 2,
      maxLines: 5,
      autofocus: true,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context).translate("Rate our service"),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        // floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.all(20),
        //Change this value to custom as you like
        isDense: true,
      ),
    );
  }
}



//https://stackoverflow.com/questions/53869078/how-to-move-bottomsheet-along-with-keyboard-which-has-textfieldautofocused-is-t