// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/models/user_model.dart';
import 'package:curimba/screens/sign_in.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/utils/navigation_service.dart';
import 'package:curimba/view_models/sign_in_view_model.dart';
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

  group('SignIn Widget', () {
    testWidgets('should correctly render components',
        (WidgetTester tester) async {
      locator.registerFactory(() => SignInViewModel());
      await tester.pumpWidget(MaterialApp(home: SignIn()));
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(FlatButton), findsOneWidget);
      expect(find.byType(RaisedButton), findsOneWidget);
    });

    testWidgets('should redirect, on click "Não possui cadastro?"',
        (WidgetTester tester) async {
      locator.registerFactory(() => SignInViewModel());
      locator.registerLazySingleton(() => NavigationService());
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
        locator.registerFactory(() => SignInViewModel());
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
        locator.registerFactory(() => SignInViewModel());
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
        locator.registerFactory(() => SignInViewModel());
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
        locator.registerFactory(() => SignInViewModel());
        await tester.pumpWidget(MaterialApp(home: SignIn()));
        final signInButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);
        await tester.enterText(formFields.at(0), "username");
        await tester.enterText(formFields.at(1), "123456");
        await tester.tap(signInButton);
        await tester.pump(const Duration(milliseconds: 100));
        expect(
            find.text("Campo deve ter no mínimo 6 caracteres"), findsNothing);
        expect(find.text("Complete o campo"), findsNothing);
      });
    });

    group('Submit login', () {
      testWidgets(
          'should show user not found error, when user not found by username',
          (WidgetTester tester) async {
        final mockRepository = MockUserRepository();
        when(mockRepository.findByUsername(any))
            .thenAnswer(((_) => new Future(() => [])));

        locator
            .registerFactory(() => SignInViewModel(repository: mockRepository));

        await tester.pumpWidget(MaterialApp(home: SignIn()));
        final signUpButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "username");
        await tester.enterText(formFields.at(1), "123456");

        await tester.tap(signUpButton);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Usuário não encontrado"), findsOneWidget);
      });

      testWidgets(
          'should show password mismatch error, when password is incorrect',
          (WidgetTester tester) async {
        final mockRepository = MockUserRepository();
        when(mockRepository.findByUsername(any))
            .thenAnswer(((_) => new Future(() => [
                  UserModel(
                      name: "a", username: "username", password: "123455"),
                ])));
        when(mockRepository.insert(any))
            .thenAnswer(((_) => new Future(() => 1)));

        locator
            .registerFactory(() => SignInViewModel(repository: mockRepository));

        await tester.pumpWidget(MaterialApp(home: SignIn()));
        final signUpButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "username");
        await tester.enterText(formFields.at(1), "123456");

        await tester.tap(signUpButton);
        await tester.pump(const Duration(milliseconds: 100));

        expect(find.text("Senha incorreta"), findsOneWidget);
      });

      testWidgets('should redirect, when successfully login',
          (WidgetTester tester) async {
        locator.registerLazySingleton(() => NavigationService());
        final mockNavigatorObserver = MockNavigatorObserver();
        final mockRepository = MockUserRepository();
        when(mockRepository.findByUsername(any))
            .thenAnswer(((_) => new Future(() => [
                  UserModel(
                      name: "a", username: "username", password: "123456"),
                ])));
        when(mockRepository.insert(any))
            .thenAnswer(((_) => new Future(() => 1)));

        locator
            .registerFactory(() => SignInViewModel(repository: mockRepository));

        await tester.pumpWidget(MaterialApp(
          home: SignIn(),
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: (routeSettings) =>
              locator<NavigationService>().generateRoute(routeSettings),
          navigatorObservers: [mockNavigatorObserver],
        ));
        final signUpButton = find.byType(RaisedButton);
        final formFields = find.byType(TextFormField);

        await tester.enterText(formFields.at(0), "username");
        await tester.enterText(formFields.at(1), "123456");

        await tester.tap(signUpButton);
        await tester.pump(const Duration(milliseconds: 100));

        verify(mockNavigatorObserver.didPush(any, any));
      });
    });
  });
}
