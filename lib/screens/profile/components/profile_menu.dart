import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text, icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: FlatButton(
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 0,left: 0),
        // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15),),
        // color: Color(0xFFF5F6F9),
        shape: Border(
            bottom: BorderSide(
                color:   Colors.black , width: 0.5
            )
        ),

        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              color: KSecondIcon,
              width: 20,
              height: 20,

            ),
            SizedBox(width: 10),
            Expanded(child: Text(text)),
            Icon(Icons.arrow_forward_ios,size: 15,),

          ],
        ),
      ),
    );
  }
}

