import 'package:clock/clock.dart';
import 'package:curimba/enums/time_definitions.dart';
import 'package:curimba/enums/view_state.dart';
import 'package:curimba/extensions/time_values.dart';
import 'package:curimba/helpers/shared_preferences_helper.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/repositories/card_repository.dart';
import 'package:curimba/view_models/base_view_model.dart';
import 'package:flutter/foundation.dart';

import '../utils/locator.dart';

class RecommendedCardsViewModel extends BaseViewModel {
  @protected
  final CardRepository repository;
  Clock clock;

  List<CardModel> _cards;

  List<CardModel> get cards => _cards;

  RecommendedCardsViewModel({this.repository = const CardRepository(), this.clock = const Clock()});

  @override
  Future<void> initialize() async {
    _cards = await _getUserRecommendedCards();
    notifyListeners();
  }

  Future<CardModel> getFirstCard() async {
    if (_cards == null) {
      await initialize();
    }

    if (_cards.isEmpty) {
      return null;
    }

    return _cards[0];
  }

  Future<List<CardModel>> _getUserRecommendedCards() async {
    setViewState(ViewState.Busy);

    final userId = await locator<SharedPreferencesHelper>().userId;
    final cards = await repository.getFromUser(userId);
    final recommendedCards = _sortCardsByInvoiceDate(cards);

    setViewState(ViewState.Idle);
    return recommendedCards;
  }

  List<CardModel> _sortCardsByInvoiceDate(List<CardModel> cards) {
    final dateTimeNow = new DateTime.now();
    final sortedCards = List<CardModel>();

    var now = clock.now();
    cards.sort((a, b) => a.invoiceDate.compareTo(b.invoiceDate));
    cards.forEach((element) {
      final parsedInvoiceDate = _parseInvoiceDate(element.invoiceDate);
      final invoiceMonth = parsedInvoiceDate['month'];
      final invoiceDay = parsedInvoiceDate['day'];
      final invoiceDate = DateTime(dateTimeNow.year, invoiceMonth, invoiceDay);
      final expiryDate =
          invoiceDate.add(Duration(days: TimeDefinitions.Week.days));
      if ((dateTimeNow.isAtSameMomentAs(invoiceDate) ||
              dateTimeNow.isAfter(invoiceDate)) &&
          dateTimeNow.isBefore(expiryDate)) {
        sortedCards.add(element);
      }
    });
    sortedCards.sort((b, a) => a.invoiceDate.compareTo(b.invoiceDate));
    return sortedCards;
  }

  Map<String, int> _parseInvoiceDate(invoiceDate) {
    return {
      'month': int.parse(invoiceDate.substring(0, 2)),
      'day': int.parse(invoiceDate.substring(3, 5)),
    };
  }
}
