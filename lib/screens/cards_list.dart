import 'package:curimba/models/card_model.dart';
import 'package:curimba/repositories/card_repository.dart';
import 'package:curimba/view_models/cards_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardsListViewModel = Provider.of<CardsListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar Cartões'),
      ),
      body: _buildCardList(cardsListViewModel.cards),
    );
  }

  Widget _buildCardList(List<CardModel> cards) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${cards[index].brandName}'),
        );
      },
    );
  }
}
