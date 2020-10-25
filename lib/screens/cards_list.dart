import 'package:curimba/models/card_model.dart';
import 'package:curimba/view_models/card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardViewModel = Provider.of<CardViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar Cartões'),
      ),
      body: _buildCardList(cardViewModel.cards),
    );
  }

  Widget _buildCardList(List<CardModel> cards) {
    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${cards[index].brandName}', key: Key('card title'),),
          subtitle: Text('${cards[index].invoiceDate.substring(3, 5)}/${cards[index].invoiceDate.substring(0, 2)}', key: Key('card subtitle'),),
        );
      },
    );
  }
}
