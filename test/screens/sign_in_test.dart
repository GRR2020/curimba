// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:curimba/screens/sign_in.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/utils/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mock_navigation_observer.dart';

void main() {
  setUpAll(() {
    setUpLocator();
  });

  group('SignIn Widget', () {
    testWidgets('should correctly render components',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: SignIn()));
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(FlatButton), findsOneWidget);
      expect(find.byType(RaisedButton), findsOneWidget);
    });

    testWidgets('should redirect, on click "Não possui cadastro?"',
        (WidgetTester tester) async {
      final mockNavigatorObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        home: SignIn(),
        navigatorKey: locator<NavigationService>().navigatorKey,
        onGenerateRoute: (routeSettings) =>
            locator<NavigationService>().generateRoute(routeSettings),
        navigatorObservers: [mockNavigatorObserver],
      ));

      await tester.tap(find.byType(FlatButton));
      verify(mockNavigatorObserver.didPush(any, any));
    });

    group('Fields validation', () {
      testWidgets('on empty fields, should return fields error',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: SignIn()));
        final signInButton = find.byType(RaisedButton);
        await tester.tap(signInButton);
        await tester.pump(const Duration(milliseconds: 100));
        expect(
            find.text("Campo deve ter no mínimo 6 caracteres"), findsOneWidget);
        expect(find.text("Complete o campo"), findsOneWidget);
      });
      testWidgets('on empty Username field, should return field error',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: SignIn()));
        final signInButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);
        await tester.enterText(formFields.at(1), "123456");
        await tester.tap(signInButton);
        await tester.pump(const Duration(milliseconds: 100));
        expect(find.text("Complete o campo"), findsOneWidget);
      });

      testWidgets('on empty Password field, should return field error',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: SignIn()));
        final signInButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);
        await tester.enterText(formFields.at(0), "username");
        await tester.tap(signInButton);
        await tester.pump(const Duration(milliseconds: 100));
        expect(
            find.text("Campo deve ter no mínimo 6 caracteres"), findsOneWidget);
      });

      testWidgets('on complete fields, should not return field error',
          (WidgetTester tester) async {
        await tester.pumpWidget(MaterialApp(home: SignIn()));
        final signInButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);
        await tester.enterText(formFields.at(0), "username");
        await tester.enterText(formFields.at(1), "123456");
        await tester.tap(signInButton);
        await tester.pump(const Duration(milliseconds: 100));
        expect(find.text("Campo deve ter no mínimo 6 caracteres"),
            isNot(findsWidgets));
        expect(find.text("Complete o campo"), isNot(findsWidgets));
      });
    });
  });
}
