import 'package:curimba/helpers/database_helper.dart';
import 'package:curimba/models/user_model.dart';
import 'package:sqflite/sqflite.dart';

class UserRepository {
  final table = 'users';

  const UserRepository();

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

  Future<List<UserModel>> findByUsername(String username) async {
    Database db = await DatabaseHelper.instance.database;

    var dbUsers = await db.query(
      table,
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );

    return List.generate(dbUsers.length, (i) {
      return UserModel(
        id: dbUsers[i]['id'],
        name: dbUsers[i]['name'],
        username: dbUsers[i]['username'],
        password: dbUsers[i]['password'],
      );
    });
  }
}
