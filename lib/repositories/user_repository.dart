import 'package:curimba/database_helper.dart';
import 'package:curimba/models/user_model.dart';
import 'package:curimba/repositories/repository.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository extends Repository {
  @override
  String table = "user";

  Future<int> insert(UserModel model) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(table, model.toMap());
  }

  Future<int> update(UserModel model) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.update(
      table,
      model.toMap(),
      where: 'id = ?',
      whereArgs: [model.id],
    );
  }

  Future<List<Map<String, dynamic>>> findByUsername(String username) async {
    Database db = await DatabaseHelper.instance.database;
    return db.query(
      table,
      where: 'username = ?',
      whereArgs: [username],
    );
  }
}
