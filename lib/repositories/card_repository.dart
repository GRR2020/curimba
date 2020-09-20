import 'package:curimba/database_helper.dart';
import 'package:curimba/models/card_model.dart';
import 'package:sqflite/sqflite.dart';

class CardRepository {
  static final table = 'cards';

  static Future<int> insert(CardModel card) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(table, card.toMap());
  }

  static Future<List<CardModel>> getAll() async {
    Database db = await DatabaseHelper.instance.database;
    var dbCards = await db.query(table);

    return List.generate(dbCards.length, (i) {
      return CardModel(
        id: dbCards[i]['id'],
        lastNumbers: dbCards[i]['last_numbers'],
        brandName: dbCards[i]['brand_name'],
        expiryDate: dbCards[i]['expiry_date'],
      );
    });
  }

  static update(CardModel card) async {
    Database db = await DatabaseHelper.instance.database;
    await db.update(
      table,
      card.toMap(),
      where: 'id = ?',
      whereArgs: [card.id],
    );
  }
}
