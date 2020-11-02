import 'package:curimba/models/card_model.dart';
import 'package:curimba/view_models/card_view_model.dart';
import 'package:curimba/view_models/list_cards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../locator.dart';

class ListCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CardViewModel>(
        create: (context) => locator<CardViewModel>() as ListCardsViewModel,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Listar Cartões'),
            ),
            body: Consumer<ListCardsViewModel>(
              builder: (context, model, child) => _buildListCards(model.cards),
            )));
  }

  Widget _buildListCards(List<CardModel> cards) {
    cards.isEmpty
        ? Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Icon(
                  Icons.error,
                  color: Colors.red,
                  size: 60,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text('Não há cartões cadastrados'),
                )
              ]))
        : ListView.builder(
            itemCount: cards.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${cards[index].brandName}'),
                subtitle: Text(
                    '${cards[index].invoiceDate.substring(3, 5)}/${cards[index].invoiceDate.substring(0, 2)}'),
              );
            },
          );

    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${cards[index].brandName}'),
          subtitle: Text(
              '${cards[index].invoiceDate.substring(3, 5)}/${cards[index].invoiceDate.substring(0, 2)}'),
        );
      },
    );
  }
}
