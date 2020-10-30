import 'package:curimba/models/user_model.dart';
import 'package:curimba/repositories/user_repository.dart';
import 'package:curimba/view_models/view_model.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var savedUserId = await _repository.insert(model);
    if (savedUserId > 0) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('userId', savedUserId);
    }
    _setViewState(ViewState.Idle);
    return savedUserId;
  }
}
