import 'package:curimba/enums/view_state.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/repositories/card_repository.dart';
import 'package:curimba/view_models/base_view_model.dart';
import 'package:flutter/foundation.dart';

import '../utils/locator.dart';

class CreateCardViewModel extends BaseViewModel {
  @protected
  final CardRepository repository;

  CreateCardViewModel({this.repository = const CardRepository()});

  @override
  refreshAllStates() async {
    notifyListeners();
  }

  Future<int> register(CardModel model) async {
    setViewState(ViewState.Busy);

    final userId = await locator<SharedPreferencesHelper>().userId;
    if (userId == null) {
      return -1;
    }

    model.usersId = userId;
    final savedCardId = await repository.insert(model);
    if (savedCardId <= 0) {
      return -1;
    }
    setViewState(ViewState.Idle);
    return savedCardId;
  }
}