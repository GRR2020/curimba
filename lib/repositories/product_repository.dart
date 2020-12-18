import 'package:curimba/helpers/database_helper.dart';
import 'package:curimba/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {
  final table = 'products';

  const ProductRepository();

  Future<List<ProductModel>> getFromUser(int userId) async {
    Database db = await DatabaseHelper.instance.database;
    var dbCards = await db.query(
      table,
      where: 'users_id = ?',
      whereArgs: [userId],
    );

    return List.generate(dbCards.length, (i) {
      return ProductModel(
        id: dbCards[i]['id'],
        usersId:  dbCards[i]['users_id'],
        name: dbCards[i]['name'],
        price:  dbCards[i]['price'],
        description:  dbCards[i]['description'],
      );
    });
  }

  Future<int> insert(ProductModel product) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(table, product.toMap());
  }

  Future<int> update(ProductModel product) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.update(
      table,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }
}
