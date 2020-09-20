import 'package:curimba/database_helper.dart';
import 'package:curimba/screens/home.dart';
import 'package:curimba/view_models/cards_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.instance.database;

  final cardsListViewModel = CardsListViewModel();
  await cardsListViewModel.init();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<CardsListViewModel>.value(
            value: cardsListViewModel)
      ],
      child: MaterialApp(
        title: 'App',
        theme: ThemeData(
          textTheme: TextTheme(button: TextStyle(letterSpacing: 1.25)),
          fontFamily: 'Rubik',
          primaryColor: Colors.black,
          buttonTheme: ButtonThemeData(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ),
        home: Home(),
      )));
}
