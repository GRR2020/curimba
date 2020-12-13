import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/screens/create_card.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/view_models/create_card_view_model.dart';
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
    locator.registerLazySingleton(() => SharedPreferencesHelper());
  });

  tearDown(() async {
    await locator.reset();
  });

  group('CreateCard Widget', () {
    testWidgets("should display fields", (WidgetTester tester) async {
      locator.registerFactory(() => CreateCardViewModel());
      await tester.pumpWidget(MaterialApp(home: CreateCard()));

      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(RaisedButton), findsOneWidget);
    });
    group('Fields validation', () {
      testWidgets(
          "on click 'CADASTRAR CARTÃO' with complete fields, should not return field error",
          (WidgetTester tester) async {
        locator.registerFactory(() => CreateCardViewModel());
        await tester.pumpWidget(MaterialApp(home: CreateCard()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "brand");
        await tester.enterText(formFields.at(1), "1234");
        await tester.enterText(formFields.at(2), "10");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Complete o campo"), findsNothing);
        expect(find.text("Dia inválido"), findsNothing);
        expect(
            find.text("Campo deve ter no mínimo 4 caracteres"), findsNothing);
      });

      testWidgets(
          "on click 'CADASTRAR CARTÃO' with empty Expiry day field, should return field error",
          (WidgetTester tester) async {
        locator.registerFactory(() => CreateCardViewModel());
        await tester.pumpWidget(MaterialApp(home: CreateCard()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "brand");
        await tester.enterText(formFields.at(1), "1234");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Complete o campo"), findsOneWidget);
      });

      testWidgets(
          "on click 'CADASTRAR CARTÃO' with empty Brand name field, should return field error",
          (WidgetTester tester) async {
        locator.registerFactory(() => CreateCardViewModel());
        await tester.pumpWidget(MaterialApp(home: CreateCard()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(1), "1234");
        await tester.enterText(formFields.at(2), "10");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Complete o campo"), findsOneWidget);
      });

      testWidgets(
          "on click 'CADASTRAR CARTÃO' with invalid Last numbers field, should return error",
          (WidgetTester tester) async {
        locator.registerFactory(() => CreateCardViewModel());
        await tester.pumpWidget(MaterialApp(home: CreateCard()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "brand");
        await tester.enterText(formFields.at(1), "12");
        await tester.enterText(formFields.at(2), "10");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(
            find.text("Campo deve ter no mínimo 4 caracteres"), findsOneWidget);
      });
    });
    group('Submit card', () {
      testWidgets("should show register error, when register fails",
          (WidgetTester tester) async {
        final mockRepository = MockCardRepository();
        when(mockRepository.insert(any))
            .thenAnswer(((_) => new Future(() => -1)));

        locator.registerFactory(
            () => CreateCardViewModel(repository: mockRepository));
        await tester.pumpWidget(MaterialApp(home: CreateCard()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "brand");
        await tester.enterText(formFields.at(1), "1234");
        await tester.enterText(formFields.at(2), "10");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Falha no cadastro do cartão"), findsOneWidget);
      });
      testWidgets("should show success message, when successfully register",
          (WidgetTester tester) async {
        final mockRepository = MockCardRepository();
        when(mockRepository.insert(any))
            .thenAnswer(((_) => new Future(() => 1)));

        locator.registerFactory(
            () => CreateCardViewModel(repository: mockRepository));
        await tester.pumpWidget(MaterialApp(home: CreateCard()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "brand");
        await tester.enterText(formFields.at(1), "1234");
        await tester.enterText(formFields.at(2), "10");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Cartão salvo com sucesso"), findsOneWidget);
      });
    });
  });
}
