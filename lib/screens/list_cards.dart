import 'package:curimba/models/card_model.dart';
import 'package:curimba/repositories/card_repository.dart';
import 'package:flutter/material.dart';

class ListCards extends StatefulWidget {
  @override
  _ListCardsState createState() => _ListCardsState();
}

class _ListCardsState extends State<ListCards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar Cartões'),
      ),
      body: _buildCards(),
    );
  }

  Widget _buildCards() {
    return FutureBuilder<List<CardModel>>(
        future: CardRepository.getAll(),
        builder: (context, AsyncSnapshot<List<CardModel>> snapshot) {
          if (snapshot.hasData) {
            return _buildRows(snapshot.data);
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Widget _buildRows(List<CardModel> cards) {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          return Text(cards[i].brandName + ' ' + cards[i].lastNumbers + ' ' + cards[i].expiryDate);
        });
  }
}
