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

  Future<List<UserModel>> findByUsername(String username) async {
    Database db = await DatabaseHelper.instance.database;

    var usersByUsername = await db.query(
      table,
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );

    return List.generate(usersByUsername.length, (i) {
      return UserModel(
        id: usersByUsername[i]['id'],
        name: usersByUsername[i]['name'],
        username: usersByUsername[i]['username'],
        password: usersByUsername[i]['password'],
      );
    });
  }
}
