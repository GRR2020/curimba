import 'package:curimba/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CardWidget', () {
    testWidgets("should render correctly", (WidgetTester tester) async {
      final expectedBrandName = 'Nome de brand';
      final expectedLastNumbers = '•••• •••• •••• 4444';
      final expectedExpiryDate = '10/10';

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: CardWidget(
            brandName: expectedBrandName,
            lastNumbers: expectedLastNumbers,
            expiryDate: expectedExpiryDate,
          ),
        ),
      ));

      expect(find.byType(Icon), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(3));

      expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is Text && widget.data == expectedBrandName),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is Text && widget.data == expectedLastNumbers),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is Text && widget.data == expectedExpiryDate),
        findsOneWidget,
      );

      expect(
        find.byWidgetPredicate((Widget widget) =>
            widget is Icon && widget.icon == Icons.credit_card_rounded),
        findsOneWidget,
      );
    });
  });
}
