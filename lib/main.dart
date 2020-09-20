import 'package:curimba/database_helper.dart';
import 'package:curimba/screens/home.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.instance.database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        textTheme: TextTheme(
          button: TextStyle(
            letterSpacing: 1.25
          )
        ),
        fontFamily: 'Rubik',
        primaryColor: Colors.black,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
      ),
      home: Home(),
    );
  }
}
