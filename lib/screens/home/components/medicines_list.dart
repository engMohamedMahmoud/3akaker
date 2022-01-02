import 'package:flutter/material.dart';


class SelectCard extends StatelessWidget {
  const SelectCard({
    Key key,
    @required this.product,
  }) : super(key: key);

  final Type product;


  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.orange,

    );
  }
}