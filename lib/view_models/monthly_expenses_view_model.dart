import 'package:charts_flutter/flutter.dart';
import 'package:clock/clock.dart';
import 'package:curimba/enums/view_state.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/models/month_expenses_model.dart';
import 'package:curimba/models/product_model.dart';
import 'package:curimba/repositories/product_repository.dart';
import 'package:curimba/view_models/base_view_model.dart';
import 'package:flutter/foundation.dart';

import '../utils/locator.dart';

class MonthlyExpensesViewModel extends BaseViewModel {
  @protected
  final ProductRepository repository;

  final Clock clock;

  List<Series<MonthExpensesModel, String>> _monthlyExpenses = [];

  List<Series<MonthExpensesModel, String>> get monthlyExpenses =>
      _monthlyExpenses;

  MonthlyExpensesViewModel(
      {this.repository = const ProductRepository(),
      this.clock = const Clock()});

  @override
  Future<void> initialize() async {
    _monthlyExpenses = await _getExpenses();
    notifyListeners();
  }

  Future<List<Series<MonthExpensesModel, String>>> _getExpenses() async {
    setViewState(ViewState.Busy);

    final year = clock.now().year;
    final userId = await locator<SharedPreferencesHelper>().userId;
    final products = await repository.getFromUserByYear(userId, year);
    final monthlyExpenses = _mapProductsPriceByMonth(products);

    setViewState(ViewState.Idle);

    return monthlyExpenses;
  }

  List<Series<MonthExpensesModel, String>> _mapProductsPriceByMonth(
      List<ProductModel> products) {
    final monthlyExpenses = _mapProductsToMonthlyExpenses(products);

    return [
      Series<MonthExpensesModel, String>(
        id: 'Expenses',
        domainFn: (MonthExpensesModel monthExpenses, _) =>
            monthExpenses.formattedMonth,
        measureFn: (MonthExpensesModel monthExpenses, _) =>
            monthExpenses.expenses,
        data: monthlyExpenses,
        labelAccessorFn: (MonthExpensesModel monthExpenses, _) =>
            'R\$${monthExpenses.expenses.toStringAsFixed(2)}',
        outsideLabelStyleAccessorFn: (MonthExpensesModel monthExpenses, _) =>
            TextStyleSpec(fontSize: 5),
      ),
    ];
  }

  List<MonthExpensesModel> _mapProductsToMonthlyExpenses(
      List<ProductModel> products) {
    final monthlyExpenses = <MonthExpensesModel>[];
    final months = List<int>.generate(12, (i) => i + 1);

    for (var month in months) {
      final productsByMonth =
          products.where((product) => product.purchaseMonth == month);
      final expenses = productsByMonth
          .map((product) => product.price)
          .fold(0.0, (a, b) => a + b);
      monthlyExpenses.add(MonthExpensesModel(month: month, expenses: expenses));
    }
    return monthlyExpenses;
  }
}
