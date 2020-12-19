import 'package:curimba/helpers/database_helper.dart';
import 'package:curimba/models/card_model.dart';
import 'package:sqflite/sqflite.dart';

class CardRepository {
  final table = 'cards';

  const CardRepository();

  Future<List<CardModel>> getFromUser(int userId) async {
    Database db = await DatabaseHelper.instance.database;
    var cardsByUserId = await db.query(
      table,
      where: 'users_id = ?',
      whereArgs: [userId],
    );

    return List.generate(cardsByUserId.length, (i) {
      return CardModel(
        id: cardsByUserId[i]['id'],
        lastNumbers: cardsByUserId[i]['last_numbers'],
        brandName: cardsByUserId[i]['brand_name'],
        expiryDate: cardsByUserId[i]['expiry_date'],
        usersId: cardsByUserId[i]['users_id'],
      );
    });
  }

  Future<int> insert(CardModel card) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert(table, card.toMap());
  }
}
