import 'package:curimba/enums/sign_in_up_errors.dart';
import 'package:curimba/enums/view_state.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/locator.dart';
import 'package:curimba/repositories/user_repository.dart';
import 'package:curimba/view_models/base_view_model.dart';
import 'package:flutter/widgets.dart';

class SignInViewModel extends BaseViewModel {
  @protected
  UserRepository repository = UserRepository();

  SignInViewModel({this.repository});

  @override
  @protected
  refreshAllStates() async {
    notifyListeners();
  }

  Future<int> login(String username, String password) async {
    setViewState(ViewState.Busy);

    final dbUser = await repository.findByUsername(username);
    if (dbUser.isEmpty) {
      setViewState(ViewState.Idle);
      return SignInUpErrors.UserNotFound.code;
    }

    final user = dbUser.first;
    if (user.password != password) {
      setViewState(ViewState.Idle);
      return SignInUpErrors.PasswordMismatch.code;
    }

    await locator<SharedPreferencesHelper>().setUserId(user.id);
    setViewState(ViewState.Idle);
    return user.id;
  }
}
