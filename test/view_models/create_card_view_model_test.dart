import 'package:curimba/utils/locator.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/view_models/create_card_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_card_repository.dart';

void main() {
  setUpAll(() {
    setUpLocator();
    SharedPreferences.setMockInitialValues({'userId': 1});
  });

  group('CreateCardViewModel tests', () {
    test('should return card id, when card is successfully registered', () async {
      final mockRepository = MockCardRepository();
      when(mockRepository.insert(any)).thenAnswer((_) => new Future(() => 1));

      final viewModel = CreateCardViewModel(repository: mockRepository);

      final savedUserId = await viewModel.register(CardModel(
        brandName: 'brand',
        expiryDate: '10',
        lastNumbers: '1234',
      ));
      expect(savedUserId, 1);
    });

    test('should return error code, when it fails to register card', () async {
      final mockRepository = MockCardRepository();
      when(mockRepository.insert(any)).thenAnswer((_) => new Future(() => 0));

      final viewModel = CreateCardViewModel(repository: mockRepository);

      final savedUserId = await viewModel.register(CardModel(
        brandName: 'brand',
        expiryDate: '10',
        lastNumbers: '1234',
      ));
      expect(savedUserId, -1);
    });
  });
}
