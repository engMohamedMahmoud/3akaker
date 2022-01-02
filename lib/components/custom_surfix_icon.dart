import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../size_config.dart';

class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({
    Key key,
    @required this.svgIcon,
  }) : super(key: key);

  final String svgIcon;

  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        getProportionateScreenWidth(0),
        getProportionateScreenWidth(0),
        getProportionateScreenWidth(20),

      ),
      child: SvgPicture.asset(
        svgIcon,
       alignment: Alignment.topLeft,
       height: getProportionateScreenWidth(10),
          fit: BoxFit.fill

      ),
    );
  }
}
