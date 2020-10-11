import 'package:curimba/models/card_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // now is defined on CardModel class with 23/10/2020
  test('test expiryDate before now should return -7 days and next month', () {
    final cardModel = CardModel(id: 1,
      lastNumbers: '1234',
      brandName: 'brand',
      expiryDate: '12',
      isTesting: true);
    expect(cardModel.invoiceDate, '11/05');
  });

  test('test expiryDate after now should return -7 days', () {
    final cardModel = CardModel(id: 1,
        lastNumbers: '1234',
        brandName: 'brand',
        expiryDate: '30',
        isTesting: true);
    expect(cardModel.invoiceDate, '10/23');
  });
}