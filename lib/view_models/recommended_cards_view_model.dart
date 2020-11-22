import 'package:curimba/enums/view_state.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/repositories/card_repository.dart';
import 'package:curimba/view_models/base_view_model.dart';
import 'package:flutter/foundation.dart';

import '../utils/locator.dart';

class RecommendedCardsViewModel extends BaseViewModel {
  @protected
  final CardRepository repository;

  List<CardModel> _cards;

  List<CardModel> get cards => _cards;

  RecommendedCardsViewModel({this.repository = const CardRepository()});

  @override
  Future<void> initialize() async {
    _cards = await _getCards();
    notifyListeners();
  }

  Future<CardModel> getFirstCard() async {
    if (cards == null) {
      await initialize();
    }

    return cards[0];
  }

  Future<List<CardModel>> _getCards() async {
    setViewState(ViewState.Busy);

    List<CardModel> recommendedCards = [];
    final userId = await locator<SharedPreferencesHelper>().userId;
    final cards = await repository.getFromUser(userId);

    var now = new DateTime.now();
    cards.sort((a, b) => a.invoiceDate.compareTo(b.invoiceDate));
    cards.forEach((element) {
      int invoiceMonth = int.parse(element.invoiceDate.substring(0, 2));
      int invoiceDay = int.parse(element.invoiceDate.substring(3, 5));
      var invoiceDate = new DateTime(now.year, invoiceMonth, invoiceDay);
      var expiryDate = invoiceDate.add(new Duration(days: 7));
      now = new DateTime(now.year, now.month, now.day);
      if ((now.isAtSameMomentAs(invoiceDate) || now.isAfter(invoiceDate)) &&
          now.isBefore(expiryDate)) {
        recommendedCards.add(element);
      }
    });
    recommendedCards.sort((b, a) => a.invoiceDate.compareTo(b.invoiceDate));
    setViewState(ViewState.Idle);
    return recommendedCards;
  }
}
