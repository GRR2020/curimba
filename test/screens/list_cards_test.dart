// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/screens/list_cards.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/utils/navigation_service.dart';
import 'package:curimba/view_models/list_cards_view_model.dart';
import 'package:curimba/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_card_repository.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({'userId': 1});
  });

  setUp(() {
    locator.registerLazySingleton(() => NavigationService());
    locator.registerLazySingleton(() => SharedPreferencesHelper());
  });

  tearDown(() async {
    await locator.reset();
  });

  group('ListCards Widget', () {
    testWidgets('should show cards, when there are registered cards', (WidgetTester tester) async {
      final mockRepository = MockCardRepository();
      final expectedCards = [
        CardModel(lastNumbers: '1234', brandName: 'brand', expiryDate: '10')
      ];
      when(mockRepository.getFromUser(any))
          .thenAnswer(((_) => new Future(() => expectedCards)));

      locator.registerFactory(
          () => ListCardsViewModel(repository: mockRepository));

      await tester.pumpWidget(MaterialApp(home: ListCards()));
      await tester.pumpAndSettle();

      expect(find.byType(CardWidget), findsOneWidget);
    });

    testWidgets('should show empty view, when there are no registered cards', (WidgetTester tester) async {
      final mockRepository = MockCardRepository();
      when(mockRepository.getFromUser(any))
          .thenAnswer(((_) => new Future(() => [])));

      locator.registerFactory(
              () => ListCardsViewModel(repository: mockRepository));

      await tester.pumpWidget(MaterialApp(home: ListCards()));
      await tester.pumpAndSettle();

      expect(find.byType(CardWidget), findsNothing);
      expect(find.byType(Icon), findsOneWidget);
      expect(find.text('Não há cartões cadastrados'), findsOneWidget);
    });
  });
}
