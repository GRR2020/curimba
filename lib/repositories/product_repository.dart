import 'package:curimba/helpers/database_helper.dart';
import 'package:curimba/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

class ProductRepository {
  final table = 'products';

  const ProductRepository();

  Future<List<ProductModel>> getFromUser(int userId) async {
    Database db = await DatabaseHelper.instance.database;
    var productsByUserId = await db.query(
      table,
      where: 'users_id = ?',
      whereArgs: [userId],
    );

    return List.generate(productsByUserId.length, (i) {
      return ProductModel(
        id: productsByUserId[i]['id'],
        usersId: productsByUserId[i]['users_id'],
        name: productsByUserId[i]['name'],
        price: productsByUserId[i]['price'],
        description: productsByUserId[i]['description'],
        month: productsByUserId[i]['month'],
      );
    });
  }

  Future<int> insert(ProductModel product) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(table, product.toMap());
  }
}
