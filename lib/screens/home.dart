import 'package:curimba/enums/view_state.dart';
import 'package:curimba/helpers/notifications_helper.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/locator.dart';
import '../utils/navigation_service.dart';
import 'base_view.dart';

class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: locator<HomeViewModel>(),
      onModelLoaded: (model) async {
        model.initialize();
      },
      builder: (context, model, child) => Scaffold(
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
                    locator<SharedPreferencesHelper>().deleteReceiveNotifications();
                    locator<NavigationService>().navigateToAndReplace('/');
                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('Sair'.toUpperCase())),
              SizedBox(height: 50),
            ])
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.handleNotifications();
          },
          tooltip: 'notifications',
          child: model.receiveNotifications == 0 ? Icon(Icons.notifications_none) : Icon(Icons.notifications_active),
        ),
      )
    );
  }
}
