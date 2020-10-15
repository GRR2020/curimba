import 'package:curimba/models/card_model.dart';
import 'package:curimba/repositories/card_repository.dart';
import 'package:flutter/widgets.dart';

class CardViewModel extends ChangeNotifier {
  final CardRepository cardRepository = CardRepository();

  List<CardModel> cards;
  List<CardModel> invoiceCards;

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() async {
    cards = await cardRepository.getFromUser();
    invoiceCards = await _getIdealDateCards();
    notifyListeners();
  }

  _getIdealDateCards() async {
    cards = await cardRepository.getFromUser();
    var now = new DateTime.now();
    cards.sort((a, b) => a.invoiceDate.compareTo(b.invoiceDate));
    List<CardModel> invoice = [];
    cards.forEach((element) {
      int invoiceMonth = int.parse(element.invoiceDate.substring(0, 2));
      int invoiceDay = int.parse(element.invoiceDate.substring(3, 5));
      var invoiceDate = new DateTime(now.year, invoiceMonth, invoiceDay);
      var expiryDate = invoiceDate.add(new Duration(days: 7));
      now = new DateTime(now.year, now.month, now.day);
      if ((now.isAtSameMomentAs(invoiceDate) || now.isAfter(invoiceDate)) && now.isBefore(expiryDate)) {
        invoice.add(element);
      }
    });
    invoice.sort((b, a) => a.invoiceDate.compareTo(b.invoiceDate));
    return invoice;
  }

  Future<int> registerCard(CardModel card) async {
    var saved = await cardRepository.insert(card);
    _refreshAllStates();
    notifyListeners();
    return saved;
  }
}