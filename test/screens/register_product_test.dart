import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/screens/register_product.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/view_models/register_product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_product_repository.dart';

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

  group('RegisterProduct Widget', () {
    testWidgets("should display fields", (WidgetTester tester) async {
      locator.registerFactory(() => RegisterProductViewModel());
      await tester.pumpWidget(MaterialApp(home: RegisterProduct()));

      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.byType(RaisedButton), findsOneWidget);
    });
    group('Fields validation', () {
      testWidgets(
          "on click 'REGISTRAR PRODUTO' with complete fields, should not return field error",
          (WidgetTester tester) async {
        locator.registerFactory(() => RegisterProductViewModel());
        await tester.pumpWidget(MaterialApp(home: RegisterProduct()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "product");
        await tester.enterText(formFields.at(1), "description");
        await tester.enterText(formFields.at(2), "10");
        await tester.enterText(formFields.at(3), "10/2020");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Complete o campo"), findsNothing);
      });

      testWidgets(
          "on click 'REGISTRAR PRODUTO' with empty Name field, should return field error",
          (WidgetTester tester) async {
        locator.registerFactory(() => RegisterProductViewModel());
        await tester.pumpWidget(MaterialApp(home: RegisterProduct()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(1), "description");
        await tester.enterText(formFields.at(2), "10");
        await tester.enterText(formFields.at(3), "10/2020");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Complete o campo"), findsOneWidget);
      });

      testWidgets(
          "on click 'REGISTRAR PRODUTO' with empty Brand name field, should return field error",
          (WidgetTester tester) async {
        locator.registerFactory(() => RegisterProductViewModel());
        await tester.pumpWidget(MaterialApp(home: RegisterProduct()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "product");
        await tester.enterText(formFields.at(1), "description");
        await tester.enterText(formFields.at(3), "10/2020");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Complete o campo"), findsOneWidget);
      });

      testWidgets(
          "on click 'REGISTRAR PRODUTO' with empty Month field, should return field error",
          (WidgetTester tester) async {
        locator.registerFactory(() => RegisterProductViewModel());
        await tester.pumpWidget(MaterialApp(home: RegisterProduct()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "product");
        await tester.enterText(formFields.at(1), "description");
        await tester.enterText(formFields.at(2), "10/2020");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Complete o campo"), findsOneWidget);
      });
    });
    group('Submit product', () {
      testWidgets("should show register error, when register fails",
          (WidgetTester tester) async {
        final mockRepository = MockProductRepository();
        when(mockRepository.insert(any))
            .thenAnswer(((_) => new Future(() => -1)));

        locator.registerFactory(
            () => RegisterProductViewModel(repository: mockRepository));

        await tester.pumpWidget(MaterialApp(home: RegisterProduct()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "product");
        await tester.enterText(formFields.at(1), "description");
        await tester.enterText(formFields.at(2), "10");
        await tester.enterText(formFields.at(3), "10/2020");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Falha no cadastro do Produto"), findsOneWidget);
      });
      testWidgets("should show success message, when successfully register",
          (WidgetTester tester) async {
        final mockRepository = MockProductRepository();
        when(mockRepository.insert(any))
            .thenAnswer(((_) => new Future(() => 1)));

        locator.registerFactory(
            () => RegisterProductViewModel(repository: mockRepository));

        await tester.pumpWidget(MaterialApp(home: RegisterProduct()));

        final registerBtn = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "product");
        await tester.enterText(formFields.at(1), "description");
        await tester.enterText(formFields.at(2), "10");
        await tester.enterText(formFields.at(3), "10/2020");

        await tester.tap(registerBtn);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Produto salvo com sucesso"), findsOneWidget);
      });
    });
  });
}
