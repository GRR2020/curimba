import 'package:curimba/models/card_model.dart';
import 'package:curimba/view_models/card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RecomendedCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cardViewModel = Provider.of<CardViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cartões recomendados'),
      ),
      body: _buildCardList(cardViewModel.invoiceCards),
    );
  }

  Widget _buildCardList(List<CardModel> invoiceCards) {
    return ListView.builder(
      itemCount: invoiceCards.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${invoiceCards[index].brandName}'),
          subtitle: Text('${invoiceCards[index].invoiceDate.substring(3, 5)}/${invoiceCards[index].invoiceDate.substring(0, 2)}'),
        );
      },
    );
  }
}
