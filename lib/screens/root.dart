import 'package:curimba/utils/locator.dart';
import 'package:curimba/screens/home.dart';
import 'package:curimba/screens/sign_up.dart';
import 'package:flutter/material.dart';

import '../helpers/shared_preferences_helper.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  Future<int> _userId = locator<SharedPreferencesHelper>().userId;

  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder<int>(
            future: _userId,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              if (!snapshot.hasData) return _showLoading();
              if (snapshot.data > 0) return Home();
              return SignUp();
            }));
  }

  Widget _showLoading() {
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
