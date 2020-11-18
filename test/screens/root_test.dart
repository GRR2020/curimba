import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/screens/home.dart';
import 'package:curimba/screens/root.dart';
import 'package:curimba/screens/sign_up.dart';
import 'package:curimba/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() {
    setUpLocator();
    SharedPreferences.setMockInitialValues({});
  });

  group('Root Widget', () {
    testWidgets('should go to home screen, if userId is not null',
        (WidgetTester tester) async {
      await locator<SharedPreferencesHelper>().setUserId(1);
      await tester.pumpWidget(MaterialApp(
        home: Root(),
      ));

      await tester.pumpAndSettle();
      expect(find.byType(Home), findsOneWidget);
    });

    testWidgets('should go to sign up screen, if userId is null',
        (WidgetTester tester) async {
      await locator<SharedPreferencesHelper>().deleteUserId();
      await tester.pumpWidget(MaterialApp(
        home: Root(),
      ));

      await tester.runAsync(() async {
        await tester.pumpAndSettle();
        expect(find.byType(SignUp), findsOneWidget);
      });
    });
  });
}
