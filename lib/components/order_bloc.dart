import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/rendering/proxy_box.dart';



const initialTotal = 15;
class ProductOrderBloc extends ChangeNotifier{

  final notifierTotal = ValueNotifier(initialTotal);
  final notifierFocused = ValueNotifier(false);
  final notifierPizzaBoxAnimation = ValueNotifier(false);
  final notifierImagePizza = ValueNotifier<ProductMetaData>(null);
  final notifierCartIconAnimation = ValueNotifier(0);


  void reset(){
    // notifierPizzaBoxAnimation.value = false;
    notifierImagePizza.value = null;
    notifierTotal.value = initialTotal;
    notifierCartIconAnimation.value++;
  }

  void startPizzaBoxAnimation(){
    notifierPizzaBoxAnimation.value = true;
  }


  Future<void> transformToImage(RenderRepaintBoundary boundary) async{
    final position = boundary.localToGlobal(Offset.zero);
    final size = boundary.size;
    final image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
    notifierImagePizza.value = ProductMetaData(byteData.buffer.asUint8List(), position, size);
    print(size);
    print(image);
  }


}



class ProductMetaData{
  ProductMetaData(this.imageBytes, this.position, this.size);
  final Uint8List imageBytes;
  final Offset position;
  final Size  size;
}