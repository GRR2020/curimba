// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:curimba/models/card_model.dart';
import 'package:curimba/screens/create_card.dart';
import 'package:curimba/screens/home.dart';
import 'package:curimba/screens/list_cards.dart';
import 'package:curimba/screens/recomended_cards.dart';
import 'package:curimba/view_models/card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

// Mocks

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

class MockCardViewModel extends Mock implements CardViewModel {}

void main() {
  group('ListCards Widget', () {
    testWidgets("on list card should display all registered cards",
            (WidgetTester tester) async {
          final mockObserver = MockNavigatorObserver();
          final mockCardViewModel = MockCardViewModel();
          final registeredCard = [
            CardModel(
              lastNumbers: "1111",
              brandName: "Brand1",
              expiryDate: "11",
              usersId: null,
            ),
            CardModel(
              lastNumbers: "2222",
              brandName: "Brand2",
              expiryDate: "12",
              usersId: null,
            ),
            CardModel(
              lastNumbers: "3333",
              brandName: "Brand3",
              expiryDate: "13",
              usersId: null,
            ),
            CardModel(
              lastNumbers: "4444",
              brandName: "Brand4",
              expiryDate: "14",
              usersId: null,
            )
          ];

          when(mockCardViewModel.cards).thenReturn(registeredCard);

          await tester.pumpWidget(MultiProvider(
              providers: [
                ChangeNotifierProvider<CardViewModel>.value(
                    value: mockCardViewModel),
              ],
              child: MaterialApp(
                home: ListCards(),
                navigatorObservers: [mockObserver],
              )));
          expect(find.text("Brand1"), findsOneWidget);
          expect(find.text("Brand2"), findsOneWidget);
          expect(find.text("Brand3"), findsOneWidget);
          expect(find.text("Brand4"), findsOneWidget);
        });
  });
}