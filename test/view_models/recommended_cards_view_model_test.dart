import 'package:clock/clock.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/view_models/recommended_cards_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_card_repository.dart';

void main() {
  setUpAll(() {
    setUpLocator();
    SharedPreferences.setMockInitialValues({});
  });

  group('RecommendedCardsViewModel tests', () {
    group('initialize', () {
      test('should return cards, when cards no are registered', () async {
        final mockRepository = MockCardRepository();
        final viewModel = RecommendedCardsViewModel(repository: mockRepository);
        when(mockRepository.getFromUser(any))
            .thenAnswer(((_) => new Future(() => [])));

        await viewModel.initialize();
        expect(viewModel.cards.isEmpty, true);
        expect(viewModel.cards, []);
      });
      test('should return cards, when cards are registered', () async {
        final mockRepository = MockCardRepository();
        final mockClock = Clock.fixed(DateTime(2020, 11, 14));
        List<CardModel> cards = [CardModel(lastNumbers: '1234', brandName: 'brand', expiryDate: '21', clock: mockClock), CardModel(lastNumbers: '4321', brandName: 'dnarb', expiryDate: '12', clock: mockClock)];
        final viewModel = RecommendedCardsViewModel(repository: mockRepository, clock: mockClock);
        when(mockRepository.getFromUser(any))
            .thenAnswer(((_) => new Future(() => cards)));

        await viewModel.initialize();
        expect(viewModel.cards.isEmpty, false);
        expect(viewModel.cards, [cards[0]]);
      });
    });
  });
}
