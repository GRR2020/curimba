// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:curimba/locator.dart';
import 'package:curimba/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignUp Widget', () {
    setUpAll(() {
      setUpLocator();
    });

    testWidgets('should correctly render components',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignUp()));
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(FlatButton), findsOneWidget);
      expect(find.byType(RaisedButton), findsOneWidget);
    });
    group('Fields validation', () {
      testWidgets('on empty fields, should return fields error',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: SignUp()));
        final signUpButton = find.byType(RaisedButton);
        await tester.tap(signUpButton);
        await tester.pump(const Duration(milliseconds: 100));
        expect(
            find.text("Campo deve ter no mínimo 6 caracteres"), findsOneWidget);
        expect(find.text("Complete o campo"), findsNWidgets(2));
      });

      testWidgets('on empty Name field, should return field error',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: SignUp()));
        final signUpButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);
        await tester.enterText(formFields.at(1), "username");
        await tester.enterText(formFields.at(2), "123456");
        await tester.tap(signUpButton);
        await tester.pump(const Duration(milliseconds: 100));
        expect(find.text("Complete o campo"), findsOneWidget);
      });

      testWidgets('on empty Username field, should return field error',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: SignUp()));
        final signUpButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);
        await tester.enterText(formFields.at(0), "nome");
        await tester.enterText(formFields.at(2), "123456");
        await tester.tap(signUpButton);
        await tester.pump(const Duration(milliseconds: 100));
        expect(find.text("Complete o campo"), findsOneWidget);
      });

      testWidgets('on empty Password field, should return field error',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: SignUp()));
        final signUpButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);
        await tester.enterText(formFields.at(0), "nome");
        await tester.enterText(formFields.at(1), "username");
        await tester.tap(signUpButton);
        await tester.pump(const Duration(milliseconds: 100));
        expect(
            find.text("Campo deve ter no mínimo 6 caracteres"), findsOneWidget);
      });

      testWidgets('on complete fields, should not return field error',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: SignUp()));
        final signUpButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);
        await tester.enterText(formFields.at(0), "name");
        await tester.enterText(formFields.at(1), "username");
        await tester.enterText(formFields.at(2), "123456");
        await tester.tap(signUpButton);
        await tester.pump(const Duration(milliseconds: 100));
        expect(find.text("Campo deve ter no mínimo 6 caracteres"),
            isNot(findsWidgets));
        expect(find.text("Complete o campo"), isNot(findsWidgets));
      });
    });
  });
}
