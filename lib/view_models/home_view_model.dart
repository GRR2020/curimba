import 'package:curimba/enums/view_state.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/repositories/user_repository.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/view_models/base_view_model.dart';
import 'package:flutter/widgets.dart';

class HomeViewModel extends BaseViewModel {
  @protected
  final UserRepository repository;
  int receiveNotifications;

  HomeViewModel({this.repository = const UserRepository()});

  Future<void> initNotifications() async {
    receiveNotifications =  await locator<SharedPreferencesHelper>().receiveNotifications;
    return;
  }

  Future<int> updateReceiveNotifications(int userId, int receiveNotifications) async {
    setViewState(ViewState.Busy);

    final user = await repository.findById(userId);
    user[0].receiveNotifications = receiveNotifications;

    final savedUserId = await repository.update(user[0]);
    if (savedUserId > 0) {
      await locator<SharedPreferencesHelper>().setReceiveNotifications(receiveNotifications: receiveNotifications);
    }
    setViewState(ViewState.Idle);
    return receiveNotifications;
  }
}