import 'package:curimba/database_helper.dart';
import 'package:curimba/models/card_model.dart';
import 'package:sqflite/sqflite.dart';

class CardRepository {
  final table = '';

  insert(CardModel card) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(table, card.toMap());
  }

  update(CardModel card) async {
    Database db = await DatabaseHelper.instance.database;
    await db.update(
      table,
      card.toMap(),
      where: 'id = ?',
      whereArgs: [card.id],
    );
  }
}