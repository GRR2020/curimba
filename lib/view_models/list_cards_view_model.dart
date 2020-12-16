import 'package:curimba/enums/view_state.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/repositories/card_repository.dart';
import 'package:curimba/view_models/base_view_model.dart';
import 'package:flutter/foundation.dart';

import '../utils/locator.dart';

class ListCardsViewModel extends BaseViewModel {
  @protected
  final CardRepository repository;

  List<CardModel> _cards;

  List<CardModel> get cards => _cards;

  ListCardsViewModel({this.repository = const CardRepository()});

  @override
  Future<void> initialize() async {
    _cards = await _getUserCards();
    notifyListeners();
  }

  Future<List<CardModel>> _getUserCards() async {
    setViewState(ViewState.Busy);
    final userId = await locator<SharedPreferencesHelper>().userId;
    final cards = await repository.getFromUser(userId);
    setViewState(ViewState.Idle);
    return cards;
  }
}
