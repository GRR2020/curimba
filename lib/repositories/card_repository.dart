import 'package:curimba/database_helper.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/repositories/repository.dart';
import 'package:sqflite/sqflite.dart';

class CardRepository implements Repository{
  @override
  String table = 'cards';

  Future<List<CardModel>> getFromUser() async {
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

  Future<int> insert(CardModel card) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(table, card.toMap());
  }

  Future<int> update(CardModel card) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.update(
      table,
      card.toMap(),
      where: 'id = ?',
      whereArgs: [card.id],
    );
  }
}
