import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:flutter/material.dart';

import '../utils/locator.dart';
import '../utils/navigation_service.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tela inicial'),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: ListView(children: <Widget>[
              SizedBox(height: 10),
              RaisedButton(
                  onPressed: () =>
                      locator<NavigationService>().navigateTo('/register-card'),
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('Cadastrar cartão'.toUpperCase())),
              RaisedButton(
                  onPressed: () =>
                      locator<NavigationService>().navigateTo('/list-cards'),
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('Listar cartões'.toUpperCase())),
              RaisedButton(
                  onPressed: () => locator<NavigationService>()
                      .navigateTo('/recommended-cards'),
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('Cartões recomendados'.toUpperCase())),
              RaisedButton(
                  onPressed: () => locator<NavigationService>()
                      .navigateTo('/register-product'),
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('Registrar produto'.toUpperCase())),
              RaisedButton(
                  onPressed: () {
                    locator<SharedPreferencesHelper>().deleteUserId();
                    locator<NavigationService>().navigateToAndReplace('/');
                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('Sair'.toUpperCase()))
            ])));
  }
}
