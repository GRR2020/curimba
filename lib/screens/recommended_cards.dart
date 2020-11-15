import 'package:curimba/enums/view_state.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/view_models/recommended_cards_view_model.dart';
import 'package:flutter/material.dart';

import '../utils/locator.dart';
import 'base_view.dart';

class RecommendedCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<RecommendedCardsViewModel>(
      viewModel: locator<RecommendedCardsViewModel>(),
      onModelLoaded: (model) async {
        await model.refreshAllStates();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Cartões recomendados'),
        ),
        body: model.viewState == ViewState.Idle
            ? _buildListCards(model.cards)
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _buildListCards(List<CardModel> cards) {
    return cards.isEmpty
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
                  child: Text('Nenhum cartão ideal encontrado'),
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
  }
}
