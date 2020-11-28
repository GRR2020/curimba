import 'package:curimba/enums/sign_in_up_errors.dart';
import 'package:curimba/enums/view_state.dart';
import 'package:curimba/utils/locator.dart';
import 'package:curimba/models/user_model.dart';
import 'package:curimba/repositories/user_repository.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/view_models/base_view_model.dart';
import 'package:flutter/widgets.dart';

class SignUpViewModel extends BaseViewModel {
  @protected
  final UserRepository repository;

  SignUpViewModel({this.repository = const UserRepository()});

  Future<int> register(UserModel model) async {
    setViewState(ViewState.Busy);

    final user = await repository.findByUsername(model.username);
    if (user.isNotEmpty) {
      setViewState(ViewState.Idle);
      return SignInUpErrors.UserFound.code;
    }

    final savedUserId = await repository.insert(model);
    if (savedUserId > 0) {
      await locator<SharedPreferencesHelper>().setUserId(savedUserId);
    }
    setViewState(ViewState.Idle);
    return savedUserId;
  }
}
