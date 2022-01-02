import 'package:flutter/cupertino.dart';
import 'package:get/state_manager.dart';
import 'package:aakaker/helper/database_heloper/cart_database_helper.dart';
import 'package:aakaker/helper/database_heloper/cart_model_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartViewModel extends GetxController{

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading =  ValueNotifier(false);

  List<CartProductModel> _cartProductModel = [];
  List<CartProductModel> get cartProductModel => _cartProductModel;

  double get totalPrice => _totalPrice;
  double _totalPrice = 0.0;

  double get orderCost => _orderCost;


  double shippingCost = 0.0;


  double _orderCost = 0.0;

  int numberOfList = 0;

  var dbHelper = CartDataBaseHelper.db;

  CartViewModel() {
    getAllProduct();
  }
  getAllProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    shippingCost = prefs.getDouble("shippingCost");
    print("shippingCost $shippingCost");


    // addDeliveryShipping(shippingCost);


    _loading.value = true;

    _cartProductModel = await dbHelper.getAllProduct();

    print("_cost $shippingCost");


    _loading.value = false;
    getTotalPrice();
    getTotaOrderPrice(shippingCost, 0.0);

    print(numberOfList);


    update();
  }



  getTotalPrice() {
    _totalPrice = 0.0;
    numberOfList = 0;
    for(int i = 0; i < _cartProductModel.length; i++){
      _totalPrice += _cartProductModel[i].price * _cartProductModel[i].count;
      numberOfList += cartProductModel[i].count;

    }
    update();
  }
  getTotaOrderPrice(double delivery, double discount) {

    print("_shippingCost_shippingCost $shippingCost");

    _orderCost = _totalPrice + delivery + discount;
    update();
  }



   addDeliveryShipping(double cost) async{
     shippingCost = cost;
    update();
  }


  addProduct(CartProductModel cartProductModel)  async{


    var dbHelper = CartDataBaseHelper.db;
    await dbHelper.insert(cartProductModel);
    _cartProductModel.add(cartProductModel);
    _totalPrice += cartProductModel.price * cartProductModel.count;
    _orderCost += cartProductModel.price * cartProductModel.count;
    numberOfList = 0;
    for(int index = 0; index < _cartProductModel.length; index++){
      numberOfList += _cartProductModel[index].count;
    }

    update();
  }

  increaseQuantity(int index) async {
    _cartProductModel[index].count++;
    _totalPrice += _cartProductModel[index].price;
    _orderCost += _cartProductModel[index].price;
    numberOfList = 0;
    for(int index = 0; index < _cartProductModel.length; index++){
      numberOfList += _cartProductModel[index].count;
    }
    await dbHelper.updateProduct(_cartProductModel[index]);

    update();
  }

  increaseQuantity1(int index, int count) async {
    _cartProductModel[index].count +=  count;
    _totalPrice += _cartProductModel[index].price * count;
    _orderCost += _cartProductModel[index].price * count;
    numberOfList = 0;
    for(int index = 0; index < _cartProductModel.length; index++){
      numberOfList += _cartProductModel[index].count;
    }
    await dbHelper.updateProduct(_cartProductModel[index]);


    update();
  }

  decreaseQuantity(int index) async {
    _cartProductModel[index].count--;
    _totalPrice -= _cartProductModel[index].price;
    _orderCost -= _cartProductModel[index].price;
    await dbHelper.updateProduct(_cartProductModel[index]);
    numberOfList = 0;
    for(int index = 0; index < _cartProductModel.length; index++){
      numberOfList += _cartProductModel[index].count;
    }
    update();
  }

  increaseQuantityFromDetails(int index, int count) async {
    _cartProductModel[index].count += count;
    _totalPrice += _cartProductModel[index].price;
    await dbHelper.updateProduct(_cartProductModel[index]);
    numberOfList = 0;
    for(int index = 0; index < _cartProductModel.length; index++){
      numberOfList += _cartProductModel[index].count;
    }
    update();
  }

  deleteItem(int index) async{
    _totalPrice -= cartProductModel[index].price * cartProductModel[index].count;
    _orderCost -= cartProductModel[index].price * cartProductModel[index].count;
    numberOfList = 0;
    for(int index = 0; index < _cartProductModel.length; index++){
      numberOfList += _cartProductModel[index].count;
    }
    await dbHelper.deleteProduct(_cartProductModel[index]);
    if(_cartProductModel.length == 0){
      _cartProductModel.clear();
    }else{
      _cartProductModel.removeAt(index);
    }
    // _cartProductModel.removeAt(index);

    update();

  }

  deleteItem1(int index) async{
    _totalPrice -= cartProductModel[index].price * cartProductModel[index].count;
    _orderCost -= cartProductModel[index].price * cartProductModel[index].count;
    numberOfList = 0;
    for(int index = 0; index < _cartProductModel.length; index++){
      numberOfList += _cartProductModel[index].count;
    }
    await dbHelper.deleteProduct(_cartProductModel[index]);
    // _cartProductModel.removeAt(index);

    update();

  }

  clearItems() async {

    // for(int index = 0; index <  _cartProductModel.length; index++){
    //   await dbHelper.deleteProduct(_cartProductModel[index]);
    // }
    _cartProductModel.clear();
    update();

  }

  clearAllProducts() async {

    _cartProductModel = await dbHelper.clearAllRecord();

    update();
  }




}
