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

  Future<List<CardModel>> _getCards() async {
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

    cards.sort((a, b) => a.invoiceDate.compareTo(b.invoiceDate));
    cards.forEach((element) {
      final invoiceMonth = int.parse(element.invoiceDate.substring(0, 2));
      final invoiceDay = int.parse(element.invoiceDate.substring(3, 5));
      final invoiceDate = DateTime(dateTimeNow.year, invoiceMonth, invoiceDay);
      final expiryDate = invoiceDate.add(Duration(days: 7));
      if ((dateTimeNow.isAtSameMomentAs(invoiceDate) || dateTimeNow.isAfter(invoiceDate)) &&
          dateTimeNow.isBefore(expiryDate)) {
        sortedCards.add(element);
      }
    });
    sortedCards.sort((b, a) => a.invoiceDate.compareTo(b.invoiceDate));
    return sortedCards;
  }
}
