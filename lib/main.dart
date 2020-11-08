import 'package:curimba/helpers/database_helper.dart';
import 'package:curimba/view_models/card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'locator.dart';
import 'navigation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.instance.database;
  setUpLocator();

  final cardViewModel = locator<CardViewModel>();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<CardViewModel>.value(value: cardViewModel),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      navigatorKey: locator<NavigationService>().navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (routeSettings) =>
          locator<NavigationService>().generateRoute(routeSettings),
      theme: ThemeData(
        textTheme: TextTheme(button: TextStyle(letterSpacing: 1.25)),
        fontFamily: 'Rubik',
        primaryColor: Colors.black,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
    );
  }
}
