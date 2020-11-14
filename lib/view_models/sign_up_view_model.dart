import 'package:curimba/errors_helper.dart';
import 'package:curimba/locator.dart';
import 'package:curimba/models/user_model.dart';
import 'package:curimba/repositories/user_repository.dart';
import 'package:curimba/shared_preferences_helper.dart';
import 'package:curimba/view_models/view_model.dart';
import 'package:flutter/widgets.dart';

import 'card_view_model.dart';

enum ViewState { Idle, Busy }

class SignUpViewModel extends ViewModel {
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

  Future<int> register(UserModel model) async {
    _setViewState(ViewState.Busy);

    final user = await _repository.findByUsername(model.username);
    if (user.isNotEmpty) {
      _setViewState(ViewState.Idle);
      return AuthErrors.UserFound.code;
    }

    final savedUserId = await _repository.insert(model);
    if (savedUserId > 0) {
      await locator<SharedPreferencesHelper>().setUserId(savedUserId);
      await locator<CardViewModel>().init();
    }
    _setViewState(ViewState.Idle);
    return savedUserId;
  }
}
