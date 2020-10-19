import 'package:curimba/models/user_model.dart';
import 'package:curimba/repositories/user_repository.dart';
import 'package:curimba/view_models/view_model.dart';
import 'package:flutter/widgets.dart';

class UserViewModel extends ViewModel {
  UserRepository _repository = UserRepository();


  @override
  @protected
  refreshAllStates() async {
    notifyListeners();
  }

  Future<int> register(UserModel model) async {
    var saved = await _repository.insert(model);
    refreshAllStates();
    notifyListeners();
    return saved;
  }
}