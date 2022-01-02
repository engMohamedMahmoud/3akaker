import 'package:flutter/material.dart';
import 'package:aakaker/screens/home/components/home_services/model.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class ProductImages extends StatefulWidget {
  const ProductImages({
    Key key,
    @required this.product,
  }) : super(key: key);

  final MyProduct product;

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    // var assetsImage = new AssetImage(
    //     'assets/images/def1.png'); //<- Creates an object that fetches an image.
    // var image = new Image(image: assetsImage, fit: BoxFit.fill);
    return Column(
      children: [

        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: Hero(
                tag: widget.product.id.toString(),
                child:
                Image.asset(
                  (widget.product.Type == "Medicine")? "assets/images/Medicon.png" : "assets/images/cos.png",
                  height: 230,
                  width: 100.0,
                  // loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
                  //   if (loadingProgress == null) return child;
                  //   return Center(
                  //     child: CircularProgressIndicator(
                  //       value: loadingProgress.expectedTotalBytes != null ?
                  //       loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
                  //           : null,
                  //     ),
                  //   );
                  // },
                )

            ),
          ),
        ),

        // (widget.product.Type == "Medicine")?
        // SizedBox(
        //   width: getProportionateScreenWidth(238),
        //   child: AspectRatio(
        //     aspectRatio: 1,
        //     child: Hero(
        //         tag: widget.product.id.toString(),
        //         child:
        //         Image.asset(
        //           "assets/images/Medicon.png",
        //           height: 230,
        //           width: 100.0,
        //           // loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
        //           //   if (loadingProgress == null) return child;
        //           //   return Center(
        //           //     child: CircularProgressIndicator(
        //           //       value: loadingProgress.expectedTotalBytes != null ?
        //           //       loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
        //           //           : null,
        //           //     ),
        //           //   );
        //           // },
        //         )
        //
        //     ),
        //   ),
        // ):
        // SizedBox(
        //   width: getProportionateScreenWidth(238),
        //   child: AspectRatio(
        //     aspectRatio: 1,
        //     child: Hero(
        //         tag: widget.product.id.toString(),
        //         child:
        //         Image.asset(
        //           "assets/images/cos.png",
        //           height: 230,
        //           width: 100.0,
        //           // loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
        //           //   if (loadingProgress == null) return child;
        //           //   return Center(
        //           //     child: CircularProgressIndicator(
        //           //       value: loadingProgress.expectedTotalBytes != null ?
        //           //       loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
        //           //           : null,
        //           //     ),
        //           //   );
        //           // },
        //         )
        //
        //     ),
        //   ),
        // ),
////////////////////////////////////////////////////////////////////////////////////////

        // (widget.product.Picture != "" && widget.product.Picture != null)?
        // SizedBox(
        //   width: getProportionateScreenWidth(238),
        //   child: AspectRatio(
        //     aspectRatio: 1,
        //     child: Hero(
        //       tag: widget.product.id.toString(),
        //       child:
        //        Image.network(
        //         widget.product.Picture,
        //         height: 230,
        //         width: 100.0,
        //         loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
        //           if (loadingProgress == null) return child;
        //           return Center(
        //             child: CircularProgressIndicator(
        //               value: loadingProgress.expectedTotalBytes != null ?
        //               loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
        //                   : null,
        //             ),
        //           );
        //         },
        //       )
        //
        //     ),
        //   ),
        // ):
        // SizedBox(
        //   width: getProportionateScreenWidth(238),
        //   child: AspectRatio(
        //     aspectRatio: 1,
        //     child: Hero(
        //         tag: widget.product.id.toString(),
        //         child:
        //         Image.network(
        //           "https://cdn.shopify.com/s/files/1/0272/4714/9155/products/bresol-200ml_2b085b9a-bab3-4009-bb95-5e2f0dbb2438_1024x1024.png?v=1608706534",
        //           height: 330,
        //           width: 100.0,
        //           loadingBuilder: (BuildContext context, Widget child,ImageChunkEvent loadingProgress) {
        //             if (loadingProgress == null) return child;
        //             return Center(
        //               child: CircularProgressIndicator(
        //                 value: loadingProgress.expectedTotalBytes != null ?
        //                 loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes
        //                     : null,
        //               ),
        //             );
        //           },
        //         )
        //
        //     ),
        //   ),
        // ),

        SizedBox(height: getProportionateScreenWidth(20)),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     ...List.generate(widget.product.images.length,
        //         (index) => buildSmallProductPreview(index)),
        //   ],
        // )
      ],
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: defaultDuration,
        margin: EdgeInsets.only(right: 15, top: 15),
        padding: EdgeInsets.all(8),
        height: getProportionateScreenWidth(48),
        width: getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: kPrimaryColor.withOpacity(selectedImage == index ? 1 : 0)),
        ),
        // child: Image.asset(widget.product.images[index]),
      ),
    );
  }
}
