import 'package:curimba/enums/view_state.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/repositories/user_repository.dart';
import 'package:curimba/helpers/notifications_helper.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeViewModel extends BaseViewModel {
  @protected
  final UserRepository repository;
  bool sendNotifications;
  int _receiveNotifications;

  HomeViewModel({this.repository = const UserRepository(), this.sendNotifications = true});

  Future <void> initialize() async {
    _receiveNotifications = await locator<SharedPreferencesHelper>().receiveNotifications;
    notifyListeners();
  }

  int get receiveNotifications => _receiveNotifications;

  Future<void> updateReceiveNotifications(int receiveNotifications) async {
    setViewState(ViewState.Busy);

    final userId = await locator<SharedPreferencesHelper>().userId;
    final user = await repository.findById(userId);
    user[0].receiveNotifications = receiveNotifications;

    final savedUserId = await repository.update(user[0]);
    if (savedUserId > 0) {
      await locator<SharedPreferencesHelper>().setReceiveNotifications(receiveNotifications: receiveNotifications);
      _receiveNotifications = receiveNotifications;
    }
    setViewState(ViewState.Idle);
    return;
  }

  Future<void> handleNotifications() async {
    int updatedReceiveNotifications = _receiveNotifications == 0 ? 1 : 0;
    await updateReceiveNotifications(updatedReceiveNotifications);
    if (sendNotifications) {
      if (updatedReceiveNotifications == 1) {
        locator<NotificationsHelper>().init();
        locator<NotificationsHelper>().initScheduleRecommendCards();
      } else {
        locator<NotificationsHelper>().cancelAllNotifications();
      }
    }
    return;
  }
}