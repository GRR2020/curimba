import 'package:curimba/models/card_model.dart';
import 'package:curimba/repositories/card_repository.dart';
import 'package:flutter/widgets.dart';

class CardViewModel extends ChangeNotifier {
  final CardRepository cardRepository = CardRepository();

  List<CardModel> cards;

  init() async {
    await _refreshAllStates();
  }

  _refreshAllStates() async {
    cards = await cardRepository.getFromUser();
    notifyListeners();
  }

  registerCard(CardModel card) async {
    await cardRepository.insert(card);
    _refreshAllStates();
    notifyListeners();
  }
}