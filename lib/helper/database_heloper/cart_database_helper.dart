import 'package:path/path.dart';
import 'package:aakaker/constants.dart';
import 'package:aakaker/helper/database_heloper/cart_model_product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';


import 'dart:async';


class CartDataBaseHelper {

  CartDataBaseHelper._();
  static final CartDataBaseHelper db = CartDataBaseHelper._();
  static Database _database;



  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }



  initDb() async {
    String path = join(await getDatabasesPath(), 'CartProduct.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version)async {
      await db.execute('''
      CREATE TABLE $tableCartProduct(
      $columnProductId TEXT NOT NULL PRIMARY KEY,
      $columnProductImage TEXT NOT NULL,
      $columnProductTitle TEXT NOT NULL,
      $columnProductTitleAr TEXT NOT NULL,
      $columnProductType TEXT NOT NULL,
      $columnProductPrice INTEGER NOT NULL,
      $columnProductCount INTEGER NOT NULL)
       ''');
    });
  }

  Future<List<CartProductModel>>getAllProduct()async {
    var dbClient = await database;
    List<Map> maps = await dbClient.query(tableCartProduct);
    List<CartProductModel> list = (maps.isNotEmpty)? maps.map((product) => CartProductModel.fromJson(product)).toList()
        : [];
    return list;
  }



  insert(CartProductModel model)async {
    var dbClient = await database;



    await dbClient.insert(tableCartProduct, model.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  updateProduct(CartProductModel model)async{

    var dbClient = await database;
    return await dbClient.update(tableCartProduct, model.toJson(),
    where: '$columnProductId = ?', whereArgs: [model.id]);
  }

  deleteProduct(CartProductModel model)async{

    var dbClient = await database;

    return await dbClient.delete(tableCartProduct,
        where: '$columnProductId = ?', whereArgs: [model.id]);
  }

  clearAllRecord() async {

    var dbClient = await database;
    return await dbClient.execute("delete from "+ tableCartProduct);
  }







}





