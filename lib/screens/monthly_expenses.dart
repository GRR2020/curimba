import 'package:charts_flutter/flutter.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/view_models/monthly_expenses_view_model.dart';
import 'package:flutter/material.dart';

import '../utils/locator.dart';
import 'base_view.dart';

class MonthlyExpenses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<MonthlyExpensesViewModel>(
        viewModel: locator<MonthlyExpensesViewModel>(),
        onModelLoaded: (model) async {
          await model.initialize();
        },
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Text('Gastos mensais'),
              ),
              body: Container(
                padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                child: AspectRatio(
                  aspectRatio: 1.66,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6)),
                    color: Colors.white,
                    child: Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: BarChart(
                          model.monthlyExpenses,
                          animate: false,
                          barRendererDecorator: BarLabelDecorator<String>(),
                          domainAxis: OrdinalAxisSpec(),
                        )),
                  ),
                ),
              ),
            ));
  }
}
