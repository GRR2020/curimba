import 'package:curimba/models/month_expenses_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MonthExpensesModel tests', () {
    test('should make set properties correctly', () {
      final monthExpenses = MonthExpensesModel(month: 1, expenses: 10.0);

      expect(monthExpenses.expenses, 10.0);
      expect(monthExpenses.month, 1);
      expect(monthExpenses.formattedMonth, 'Jan');
    });
    test('test formattedMonth, should return correct month simplified string',
        () {
      final monthExpenses = MonthExpensesModel(month: 1, expenses: 0.0);
      expect(monthExpenses.formattedMonth, 'Jan');

      monthExpenses.month = 2;
      expect(monthExpenses.formattedMonth, 'Fev');

      monthExpenses.month = 3;
      expect(monthExpenses.formattedMonth, 'Mar');

      monthExpenses.month = 4;
      expect(monthExpenses.formattedMonth, 'Abr');

      monthExpenses.month = 5;
      expect(monthExpenses.formattedMonth, 'Mai');

      monthExpenses.month = 6;
      expect(monthExpenses.formattedMonth, 'Jun');

      monthExpenses.month = 7;
      expect(monthExpenses.formattedMonth, 'Jul');

      monthExpenses.month = 8;
      expect(monthExpenses.formattedMonth, 'Ago');

      monthExpenses.month = 9;
      expect(monthExpenses.formattedMonth, 'Set');

      monthExpenses.month = 10;
      expect(monthExpenses.formattedMonth, 'Out');

      monthExpenses.month = 11;
      expect(monthExpenses.formattedMonth, 'Nov');

      monthExpenses.month = 12;
      expect(monthExpenses.formattedMonth, 'Dez');
    });
  });
}
