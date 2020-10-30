import 'package:curimba/screens/home.dart';
import 'package:curimba/screens/sign_in.dart';
import 'package:curimba/view_models/card_view_model.dart';
import 'package:curimba/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
    return FutureBuilder<SharedPreferences>(
        future: _sharedPreferences,
        builder: (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data.getInt('userId') > 0 ? Home() : SignIn();
          }
          else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: CircularProgressIndicator(),
                    width: 60,
                    height: 60,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 16),
                  )
                ],
              ),
            );
          }
        }
    );
  }
}
