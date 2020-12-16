import 'package:curimba/models/product_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductModel tests', () {
    test('test toMap, should return mapped model', () {
      final productModel = ProductModel(
        id: 0,
        usersId: 1,
        name: 'Nome',
        description: 'Descrição',
        month: 6,
        price: 10,
      );

      final userMap = productModel.toMap();

      expect(userMap['id'], 0);
      expect(userMap['users_id'], 1);
      expect(userMap['name'], 'Nome');
      expect(userMap['description'], 'Descrição');
      expect(userMap['month'], 6);
      expect(userMap['price'], 10);
    });
  });
}