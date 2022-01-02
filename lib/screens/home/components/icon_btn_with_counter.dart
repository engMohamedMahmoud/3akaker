import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../constants.dart';
import '../../../size_config.dart';
import 'package:aakaker/constants.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key key,
    @required this.svgSrc,
    this.numOfitem = 0,
    @required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none, children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            height: numOfitem > 99? getProportionateScreenWidth(55):getProportionateScreenWidth(46),
            width: numOfitem > 99? getProportionateScreenWidth(55):getProportionateScreenWidth(46),
            decoration: BoxDecoration(
              color: kSecondaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(svgSrc),
          ),
          if (numOfitem != 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: numOfitem > 99?getProportionateScreenWidth(30) : getProportionateScreenWidth(25),
                width: numOfitem > 99? getProportionateScreenWidth(30): getProportionateScreenWidth(25),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}


class IconBtnWithCounter0 extends StatelessWidget {
  const IconBtnWithCounter0({
    Key key,
    @required this.svgSrc,
    this.numOfitem = 0,
    @required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none, children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(getProportionateScreenWidth(5)),
          height: numOfitem > 99? getProportionateScreenWidth(40):getProportionateScreenWidth(35),
          width: numOfitem > 99? getProportionateScreenWidth(40):getProportionateScreenWidth(35),
          decoration: BoxDecoration(
            color: Colors.indigo,
            shape: BoxShape.circle,
          ),
          child: Container(
            margin: EdgeInsets.all(5),
            child: SvgPicture.asset(svgSrc,height: 10,width: 10,),
          )
        ),
        if (numOfitem != 0)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: numOfitem > 99?getProportionateScreenWidth(30) : getProportionateScreenWidth(25),
              width: numOfitem > 99? getProportionateScreenWidth(30): getProportionateScreenWidth(25),
              decoration: BoxDecoration(
                color: Color(0xFFFF4848),
                shape: BoxShape.circle,
                border: Border.all(width: 1.5, color: Colors.white),
              ),
              child: Center(
                child: Text(
                  "$numOfitem",
                  style: TextStyle(
                    fontSize: getProportionateScreenWidth(15),
                    height: 1,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
      ],
      ),
    );
  }
}

class IconBtnWithCounter2 extends StatelessWidget {
  const IconBtnWithCounter2({
    Key key,
    @required this.svgSrc,
    this.numOfitem = 0,
    @required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none, children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            height: numOfitem > 99? getProportionateScreenWidth(55):getProportionateScreenWidth(46),
            width: numOfitem > 99? getProportionateScreenWidth(55):getProportionateScreenWidth(46),
            decoration: BoxDecoration(
              color: Colors.indigo,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(svgSrc),
          ),
          if (numOfitem != 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: numOfitem > 99?getProportionateScreenWidth(30) : getProportionateScreenWidth(25),
                width: numOfitem > 99? getProportionateScreenWidth(30): getProportionateScreenWidth(25),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}


class IconBtnWithCounter1 extends StatelessWidget {
  const IconBtnWithCounter1({
    Key key,
    @required this.svgSrc,
    this.numOfitem = 0,
    @required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none, children: [
          Container(
            padding: EdgeInsets.all(getProportionateScreenWidth(12)),
            height: getProportionateScreenWidth(46),
            width: getProportionateScreenWidth(46),
            decoration: BoxDecoration(
              color: Colors.indigo,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(svgSrc,color: Colors.white,),
          ),
          if (numOfitem != 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: getProportionateScreenWidth(25),
                width: getProportionateScreenWidth(25),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(15),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
