import 'package:flutter/material.dart';
import 'package:aakaker/constants.dart';

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              _count += 1;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
              color: Color.fromRGBO(160, 171, 255, 1.0)
            ),
            
            child: Icon(Icons.add,color: Colors.white,),
          ),
        ),
        SizedBox(width: 15.0),
        Text("$_count",style: TextStyle(color: KTextColor, fontSize: 18, fontWeight: FontWeight.w700),),
        SizedBox(width: 15.0),
        GestureDetector(
          onTap: () {
            setState(() {
              if (_count > 1) {
              _count -= 1;}
            });
          },
          child: Container(
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(),
              color: Color.fromRGBO(223, 227, 255, 1.0)
            ),
            child: Icon(Icons.remove,color: Color.fromRGBO(65, 87, 255, 1.0)),
          ),
        ),
      ],
    );
  }
}
