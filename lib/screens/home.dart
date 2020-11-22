import 'package:curimba/enums/view_state.dart';
import 'package:curimba/helpers/notifications_helper.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/view_models/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/locator.dart';
import '../utils/navigation_service.dart';
import 'base_view.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int receiveNotifications;
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(
      viewModel: locator<HomeViewModel>(),
      onModelLoaded: (model) async {
        await model.initNotifications();
        receiveNotifications = model.receiveNotifications;
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
                  onPressed: () {
                    locator<SharedPreferencesHelper>().deleteUserId();
                    locator<NavigationService>().navigateToAndReplace('/');
                  },
                  color: Colors.black,
                  textColor: Colors.white,
                  child: Text('Sair'.toUpperCase())),
              SizedBox(height: 50),
              FloatingActionButton(
                  onPressed: () {
                    handleNotifications(context, receiveNotifications);
                    setState(() {
                      receiveNotifications = receiveNotifications == 0 ? 1 : 0;
                    });
                  },
                  tooltip: 'notifications',
                  child: receiveNotifications == 0 ? Icon(Icons.notifications_none) : Icon(Icons.notifications_active),
              )
            ])
        ),
      )
    );
  }

  Future<void> handleNotifications(context, receiveNotifications) async {
    final userId = await locator<SharedPreferencesHelper>().userId;
    int updatedReceiveNotifications = receiveNotifications == 0 ? 1 : 0;
    locator<HomeViewModel>().updateReceiveNotifications(userId, updatedReceiveNotifications);
    if (updatedReceiveNotifications == 1) {
      locator<NotificationsHelper>().init();
      locator<NotificationsHelper>().initScheduleRecommendCards();
    } else {
      locator<NotificationsHelper>().cancelAllNotifications();
    }
    return;
  }
}
