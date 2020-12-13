// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/models/user_model.dart';
import 'package:curimba/screens/sign_up.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/utils/navigation_service.dart';
import 'package:curimba/view_models/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/mock_navigation_observer.dart';
import '../mocks/mock_user_repository.dart';

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({});
  });

  setUp(() {
    locator.registerLazySingleton(() => SharedPreferencesHelper());
  });

  tearDown(() async {
    await locator.reset();
  });

  group('SignUp Widget', () {
    testWidgets('should correctly render components',
        (WidgetTester tester) async {
      locator.registerFactory(() => SignUpViewModel());
      await tester.pumpWidget(MaterialApp(home: SignUp()));
      expect(find.byType(TextFormField), findsNWidgets(3));
      expect(find.byType(FlatButton), findsOneWidget);
      expect(find.byType(RaisedButton), findsOneWidget);
    });
    testWidgets('should redirect, on click "Já possui cadastro?"',
        (WidgetTester tester) async {
      locator.registerLazySingleton(() => NavigationService());
      locator.registerFactory(() => SignUpViewModel());
      final mockNavigatorObserver = MockNavigatorObserver();
      await tester.pumpWidget(MaterialApp(
        home: SignUp(),
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
        locator.registerFactory(() => SignUpViewModel());
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
        locator.registerFactory(() => SignUpViewModel());
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
        locator.registerFactory(() => SignUpViewModel());
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
        locator.registerFactory(() => SignUpViewModel());
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
        locator.registerFactory(() => SignUpViewModel());
        await tester.pumpWidget(MaterialApp(home: SignUp()));
        final signUpButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);
        await tester.enterText(formFields.at(0), "name");
        await tester.enterText(formFields.at(1), "username");
        await tester.enterText(formFields.at(2), "123456");
        await tester.tap(signUpButton);
        await tester.pump(const Duration(milliseconds: 100));
        expect(find.text("Campo deve ter no mínimo 6 caracteres"),
            findsNothing);
        expect(find.text("Complete o campo"), findsNothing);
      });
    });
    group('Submit user', () {
      testWidgets('should show register error, when register fails',
          (WidgetTester tester) async {
        final mockRepository = MockUserRepository();
        when(mockRepository.findByUsername(any))
            .thenAnswer(((_) => new Future(() => [])));
        when(mockRepository.insert(any))
            .thenAnswer(((_) => new Future(() => -1)));

        locator
            .registerFactory(() => SignUpViewModel(repository: mockRepository));

        await tester.pumpWidget(MaterialApp(home: SignUp()));
        final signUpButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "name");
        await tester.enterText(formFields.at(1), "username");
        await tester.enterText(formFields.at(2), "123456");

        await tester.tap(signUpButton);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Falha no cadastro"), findsOneWidget);
      });

      testWidgets('should show duplicate error, when user already exists',
          (WidgetTester tester) async {
        final mockRepository = MockUserRepository();
        when(mockRepository.findByUsername(any))
            .thenAnswer(((_) => new Future(() => [
                  UserModel(
                      name: "a", username: "username", password: "123456"),
                ])));
        when(mockRepository.insert(any))
            .thenAnswer(((_) => new Future(() => 1)));

        locator
            .registerFactory(() => SignUpViewModel(repository: mockRepository));

        await tester.pumpWidget(MaterialApp(home: SignUp()));
        final signUpButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "name");
        await tester.enterText(formFields.at(1), "username");
        await tester.enterText(formFields.at(2), "123456");

        await tester.tap(signUpButton);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Username já cadastrado"), findsOneWidget);
      });

      testWidgets('should redirect, when successfully register',
          (WidgetTester tester) async {
        locator.registerLazySingleton(() => NavigationService());
        final mockNavigatorObserver = MockNavigatorObserver();
        final mockRepository = MockUserRepository();
        when(mockRepository.findByUsername(any))
            .thenAnswer(((_) => new Future(() => [])));
        when(mockRepository.insert(any))
            .thenAnswer(((_) => new Future(() => 1)));

        locator
            .registerFactory(() => SignUpViewModel(repository: mockRepository));

        await tester.pumpWidget(MaterialApp(
          home: SignUp(),
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: (routeSettings) =>
              locator<NavigationService>().generateRoute(routeSettings),
          navigatorObservers: [mockNavigatorObserver],
        ));
        final signUpButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "name");
        await tester.enterText(formFields.at(1), "username");
        await tester.enterText(formFields.at(2), "123456");

        await tester.tap(signUpButton);
        await tester.pump(const Duration(milliseconds: 100));

        verify(mockNavigatorObserver.didPush(any, any));
      });
    });
  });
}
