import 'package:curimba/locator.dart';
import 'package:curimba/repositories/user_repository.dart';
import 'package:curimba/shared_preferences_helper.dart';
import 'package:curimba/view_models/view_model.dart';
import 'package:flutter/widgets.dart';

import '../errors_helper.dart';
import 'card_view_model.dart';

enum ViewState { Idle, Busy }

class SignInViewModel extends ViewModel {
  UserRepository _repository = UserRepository();
  ViewState _viewState = ViewState.Idle;

  ViewState get viewState => _viewState;

  @override
  @protected
  refreshAllStates() async {
    notifyListeners();
  }

  _setViewState(ViewState state) {
    _viewState = state;
    notifyListeners();
  }

  Future<int> login(String username, String password) async {
    _setViewState(ViewState.Busy);

    final dbUser = await _repository.findByUsername(username);
    if (dbUser.isEmpty) {
      _setViewState(ViewState.Idle);
      return AuthErrors.UserNotFound.code;
    }

    final user = dbUser.first;
    if (user.password != password) {
      _setViewState(ViewState.Idle);
      return AuthErrors.PasswordMismatch.code;
    }

    await locator<SharedPreferencesHelper>().setUserId(user.id);
    await locator<CardViewModel>().init();
    _setViewState(ViewState.Idle);
    return user.id;
  }
}
