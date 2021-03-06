import 'package:curimba/enums/view_state.dart';
import 'package:curimba/extensions/list_extensions.dart';
import 'package:curimba/extensions/view_state_extensions.dart';
import 'package:curimba/models/card_model.dart';
import 'package:curimba/view_models/list_cards_view_model.dart';
import 'package:flutter/material.dart';

import '../utils/locator.dart';
import '../widgets/card_widget.dart';
import 'base_view.dart';

class ListCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ListCardsViewModel>(
      viewModel: locator<ListCardsViewModel>(),
      onModelLoaded: (model) async {
        await model.initialize();
      },
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text('Listar Cartões'),
        ),
        body: _bodyWidget(model.viewState, model.cards)
      ),
    );
  }

  Widget get _emptyView => Center(
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
          ],
        ),
      );

  Widget get _loading => Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[CircularProgressIndicator()]));

  Widget _bodyWidget(ViewState viewState, List<CardModel> cards) {
    if (viewState.isIdle) {
      if (cards.isNullOrEmpty) {
        return _emptyView;
      } else {
        return _buildListCards(cards);
      }
    } else {
      return _loading;
    }
  }

  Widget _buildListCards(List<CardModel> cards) {
    return ListView.separated(
      separatorBuilder: (context, index) =>
          Divider(color: Colors.grey, height: 1),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return CardWidget(
          brandName: cards[index].brandName,
          expiryDate: cards[index].invoiceDate,
          lastNumbers: cards[index].formattedLastNumbers,
        );
      },
    );
  }
}
