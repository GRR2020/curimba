import 'package:curimba/enums/view_state.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/view_models/list_cards_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_card_repository.dart';

void main() {
  setUpAll(() {
    setUpLocator();
    SharedPreferences.setMockInitialValues({});
  });

  group('ListCardsViewModel tests', () {
    group('initialize', () {
      test('should return cards, when cards are registered', () async {
        final mockRepository = MockCardRepository();
        final viewModel = ListCardsViewModel(repository: mockRepository);
        when(mockRepository.getFromUser(any))
            .thenAnswer(((_) => new Future(() => [])));

        await viewModel.initialize();
        expect(viewModel.cards.isEmpty, true);
        expect(viewModel.cards, []);
      });

      test('should return empty list, when there are no cards registered',
          () async {
        final mockRepository = MockCardRepository();
        final viewModel = ListCardsViewModel(repository: mockRepository);

        final expectedCards = [
          CardModel(lastNumbers: '1234', brandName: 'brand', expiryDate: '10')
        ];
        when(mockRepository.getFromUser(any))
            .thenAnswer(((_) => new Future(() => expectedCards)));

        await viewModel.initialize();
        expect(viewModel.cards.isEmpty, false);
        expect(viewModel.cards, expectedCards);
      });
    });
  });
}
