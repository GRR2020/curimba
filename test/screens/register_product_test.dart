import 'package:curimba/screens/create_card.dart';
import 'package:curimba/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    setUpLocator();
  });

  group('RegisterProduct Widget', () {
    testWidgets("should display fields", (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CreateCard()));

      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(RaisedButton), findsOneWidget);
    });
    group('Fields validation', () {
      testWidgets(
          "on click 'REGISTRAR PRODUTO' with complete fields, should not return field error",
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: CreateCard()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "product");
        await tester.enterText(formFields.at(1), "description");
        await tester.enterText(formFields.at(2), "10");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Complete o campo"), findsNothing);
      });

      testWidgets(
          "on click 'REGISTRAR PRODUTO' with empty Name field, should return field error",
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: CreateCard()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(1), "description");
        await tester.enterText(formFields.at(2), "10");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Complete o campo"), findsOneWidget);
      });

      testWidgets(
          "on click 'REGISTRAR PRODUTO' with empty Brand name field, should return field error",
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: CreateCard()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "product");
        await tester.enterText(formFields.at(1), "description");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Complete o campo"), findsOneWidget);
      });
    });
  });
}
