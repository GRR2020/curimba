import 'package:curimba/models/user_model.dart';
import 'package:curimba/repositories/user_repository.dart';
import 'package:curimba/view_models/view_model.dart';
import 'package:flutter/widgets.dart';

enum ViewState { Idle, Busy }

class UserViewModel extends ViewModel {
  UserRepository _repository = UserRepository();
  ViewState _viewState = ViewState.Idle;
  UserModel loggedUser;
  
  @override
  @protected
  refreshAllStates() async {
    notifyListeners();
  }

  Future<int> register(UserModel model) async {
    _viewState = ViewState.Busy;
    var saved = await _repository.insert(model);
    loggedUser = model;
    refreshAllStates();
    _viewState = ViewState.Busy;
    return saved;
  }
}
