// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.
import 'package:charts_flutter/flutter.dart';
import 'package:clock/clock.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/models/product_model.dart';
import 'package:curimba/screens/monthly_expenses.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/view_models/monthly_expenses_view_model.dart';
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

  group('MonthlyExpenses Widget', () {
    testWidgets('should render graph', (WidgetTester tester) async {
      final mockRepository = MockProductRepository();
      final mockClock = Clock.fixed(DateTime(2020, 10, 23));

      when(mockRepository.getFromUserByYear(any, any)).thenAnswer(
        (_) => new Future(
          () => [
            ProductModel(
                name: "", price: 5, purchaseMonth: 2, purchaseYear: 2020),
            ProductModel(
                name: "", price: 10, purchaseMonth: 3, purchaseYear: 2020),
            ProductModel(
                name: "", price: 15, purchaseMonth: 4, purchaseYear: 2020),
            ProductModel(
                name: "", price: 20, purchaseMonth: 5, purchaseYear: 2020),
            ProductModel(
                name: "", price: 25, purchaseMonth: 6, purchaseYear: 2020),
            ProductModel(
                name: "", price: 30, purchaseMonth: 7, purchaseYear: 2020),
            ProductModel(
                name: "", price: 35, purchaseMonth: 8, purchaseYear: 2020),
            ProductModel(
                name: "", price: 40, purchaseMonth: 9, purchaseYear: 2020),
            ProductModel(
                name: "", price: 45, purchaseMonth: 10, purchaseYear: 2020),
            ProductModel(
                name: "", price: 50, purchaseMonth: 11, purchaseYear: 2020),
            ProductModel(
                name: "", price: 55, purchaseMonth: 12, purchaseYear: 2020),
          ],
        ),
      );

      locator.registerFactory(() => MonthlyExpensesViewModel(
            repository: mockRepository,
            clock: mockClock,
          ));

      await tester.pumpWidget(MaterialApp(home: MonthlyExpenses()));
      await tester.pumpAndSettle();

      final barChart = tester.widget(find.byType(BarChart)) as BarChart;
      final barChartData = barChart.seriesList[0].data;

      expect(find.byType(BarChart), findsOneWidget);
      expect(barChartData.length, 12);
    });
  });
}
