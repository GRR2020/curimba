import 'package:curimba/enums/sign_in_up_errors.dart';
import 'package:curimba/enums/view_state.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/repositories/user_repository.dart';
import 'package:curimba/view_models/base_view_model.dart';
import 'package:flutter/widgets.dart';

class SignInViewModel extends BaseViewModel {
  @protected
  final UserRepository repository;

  SignInViewModel({this.repository = const UserRepository()});

  Future<int> login(String username, String password) async {
    setViewState(ViewState.Busy);

    final dbUser = await repository.findByUsername(username);
    int loginError = _checkLoginErrors(dbUser, password);
    if (loginError != null) {
      return loginError;
    }

    final user = dbUser.first;

    await locator<SharedPreferencesHelper>().setUserId(user.id);
    setViewState(ViewState.Idle);
    return user.id;
  }

  int _checkLoginErrors(dbUser, password) {
    if (dbUser.isEmpty) {
      return SignInUpErrors.UserNotFound.code;
    }

    if (dbUser.first.password != password) {
      return SignInUpErrors.PasswordMismatch.code;
    }

    return null;
  }
}
