import 'package:flutter/cupertino.dart';
import '../../../components/order_bloc.dart';

class PizzaOrderProvider extends InheritedWidget {
  final ProductOrderBloc bloc;
  final Widget child;


  PizzaOrderProvider({this.bloc, @required this.child}) : super(child: child);

  static ProductOrderBloc of(BuildContext context) =>
      context.findAncestorWidgetOfExactType<PizzaOrderProvider>().bloc;

  @override
  bool updateShouldNotify(covariant PizzaOrderProvider oldWidget) => true;
}
