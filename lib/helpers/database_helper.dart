import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = 'database.db';
  static final _databaseVersion = 1;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    return await openDatabase(join(await getDatabasesPath(), _databaseName),
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE cards (id INTEGER PRIMARY KEY, users_id INTEGER KEY, last_numbers TEXT NOT NULL, brand_name TEXT NOT NULL, expiry_date TEXT NOT NULL)');
    await db.execute(
        'CREATE TABLE users (id INTEGER PRIMARY KEY, username TEXT NOT NULL UNIQUE, name TEXT NOT NULL, password TEXT NOT NULL, receive_notifications INT NOT NULL)');
  }
}
