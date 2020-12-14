import 'package:curimba/screens/home.dart';
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

  group('Home Widget', () {
    testWidgets('should correctly render components',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Home(),
      ));

      expect(find.text('CADASTRAR CARTÃO'), findsOneWidget);
      expect(find.text('LISTAR CARTÕES'), findsOneWidget);
      expect(find.text('CARTÕES RECOMENDADOS'), findsOneWidget);
      expect(find.text('SAIR'), findsOneWidget);
    });

    group('Redirect to', () {
      testWidgets('should redirect to create card, on click "CADASTRAR CARTÃO"',
          (WidgetTester tester) async {
        final mockNavigatorObserver = MockNavigatorObserver();
        await tester.pumpWidget(MaterialApp(
          home: Home(),
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: (routeSettings) =>
              locator<NavigationService>().generateRoute(routeSettings),
          navigatorObservers: [mockNavigatorObserver],
        ));

        await tester.tap(find.text('CADASTRAR CARTÃO'));
        verify(mockNavigatorObserver.didPush(any, any));
      });

      testWidgets('should redirect to list cards on click "LISTAR CARTÕES"',
          (WidgetTester tester) async {
        final mockNavigatorObserver = MockNavigatorObserver();

        await tester.pumpWidget(MaterialApp(
          home: Home(),
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: (routeSettings) =>
              locator<NavigationService>().generateRoute(routeSettings),
          navigatorObservers: [mockNavigatorObserver],
        ));

        await tester.tap(find.text('LISTAR CARTÕES'));
        verify(mockNavigatorObserver.didPush(any, any));
      });

      testWidgets('should redirect to recommended cards on click "CARTÕES RECOMENDADOS"',
          (WidgetTester tester) async {
        final mockNavigatorObserver = MockNavigatorObserver();
        await tester.pumpWidget(MaterialApp(
          home: Home(),
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: (routeSettings) =>
              locator<NavigationService>().generateRoute(routeSettings),
          navigatorObservers: [mockNavigatorObserver],
        ));

        await tester.tap(find.text('CARTÕES RECOMENDADOS'));
        verify(mockNavigatorObserver.didPush(any, any));
      });

      testWidgets('should redirect to register product on click "REGISTRAR PRODUTO"',
              (WidgetTester tester) async {
            final mockNavigatorObserver = MockNavigatorObserver();
            await tester.pumpWidget(MaterialApp(
              home: Home(),
              navigatorKey: locator<NavigationService>().navigatorKey,
              onGenerateRoute: (routeSettings) =>
                  locator<NavigationService>().generateRoute(routeSettings),
              navigatorObservers: [mockNavigatorObserver],
            ));

            await tester.tap(find.text('REGISTRAR PRODUTO'));
            verify(mockNavigatorObserver.didPush(any, any));
          });

      testWidgets('should redirect to on click "SAIR"',
          (WidgetTester tester) async {
        final mockNavigatorObserver = MockNavigatorObserver();
        await tester.pumpWidget(MaterialApp(
          home: Home(),
          navigatorKey: locator<NavigationService>().navigatorKey,
          onGenerateRoute: (routeSettings) =>
              locator<NavigationService>().generateRoute(routeSettings),
          navigatorObservers: [mockNavigatorObserver],
        ));

        await tester.tap(find.text('SAIR'));
        verify(mockNavigatorObserver.didPush(any, any));
      });
    });
  });
}
