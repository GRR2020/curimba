import 'package:curimba/models/card_model.dart';
import 'package:curimba/repositories/card_repository.dart';
import 'package:flutter/widgets.dart';

class CardsListViewModel extends ChangeNotifier {
  final CardRepository cardRepository = CardRepository();

  List<CardModel> cards;

  init() async {
    await getUserCards();
  }

  getUserCards() async {
    cards = await cardRepository.getFromUser();
    notifyListeners();
  }
}