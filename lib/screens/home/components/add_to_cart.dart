import 'package:flutter/material.dart';

class ProductCartButton extends StatefulWidget {
  final VoidCallback onTap;

  const ProductCartButton({Key key, this.onTap}) : super(key: key);

  @override
  _ProductCartButtonState createState() => _ProductCartButtonState();
}

class _ProductCartButtonState extends State<ProductCartButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 150),
        lowerBound: 0.5,
        upperBound: 1.5,
        reverseDuration: const Duration(milliseconds: 200));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _animateButton() async {
    await _animationController.forward(from: 0.0);
    await _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _animateButton();
      },
      child: AnimatedBuilder(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.red.withOpacity(0.5), Colors.red]),
              boxShadow: [
                BoxShadow(
                  blurRadius: 15.0,
                  color: Colors.black12,
                  offset: Offset(0.0, 4.0),
                  spreadRadius: 10.0,
                )
              ]),
          child: Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
            size: 50,
          ),
        ),
        animation: _animationController,
        builder: (context, child) {
          return Transform.scale(
            scale: 2 - _animationController.value,
            child: child,
          );
        },
      ),
    );
  }
}