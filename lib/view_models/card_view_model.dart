import 'package:curimba/models/card_model.dart';
import 'package:curimba/repositories/card_repository.dart';
import 'package:curimba/shared_preferences_helper.dart';
import 'package:curimba/view_models/view_model.dart';
import 'package:flutter/widgets.dart';

import '../locator.dart';

class CardViewModel extends ViewModel {
  List<CardModel> cards;
  List<CardModel> invoiceCards;

  CardRepository _repository = CardRepository();

  @override
  @protected
  refreshAllStates() async {
    final usersId = await locator<SharedPreferencesHelper>().userId;
    if (usersId < 0) {
      return List();
    }

    cards = (usersId < 0) ? List() : await _repository.getFromUser(usersId);
    invoiceCards = await _getIdealDateCards();
    notifyListeners();
  }

  Future<List<CardModel>> _getIdealDateCards() async {
    final usersId = await locator<SharedPreferencesHelper>().userId;
    if (usersId < 0) {
      return List();
    }
    cards = await _repository.getFromUser(usersId);
    var now = new DateTime.now();
    cards.sort((a, b) => a.invoiceDate.compareTo(b.invoiceDate));
    List<CardModel> invoice = [];
    cards.forEach((element) {
      int invoiceMonth = int.parse(element.invoiceDate.substring(0, 2));
      int invoiceDay = int.parse(element.invoiceDate.substring(3, 5));
      var invoiceDate = new DateTime(now.year, invoiceMonth, invoiceDay);
      var expiryDate = invoiceDate.add(new Duration(days: 7));
      now = new DateTime(now.year, now.month, now.day);
      if ((now.isAtSameMomentAs(invoiceDate) || now.isAfter(invoiceDate)) &&
          now.isBefore(expiryDate)) {
        invoice.add(element);
      }
    });
    invoice.sort((b, a) => a.invoiceDate.compareTo(b.invoiceDate));
    return invoice;
  }

  Future<int> register(CardModel card) async {
    var saved = await _repository.insert(card);
    refreshAllStates();
    return saved;
  }
}
