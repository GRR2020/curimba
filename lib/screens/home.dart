import 'package:curimba/screens/create_card.dart';
import 'package:flutter/material.dart';

import 'cards_list.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tela inicial'),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                    child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CreateCard()),
                          );
                        },
                        color: Colors.black,
                        textColor: Colors.white,
                        child: Text('Cadastrar cartão'.toUpperCase())))
              ]),
              Row(children: <Widget>[
                Expanded(
                    child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CardsList()),
                          );
                        },
                        color: Colors.black,
                        textColor: Colors.white,
                        child: Text('Listar cartões'.toUpperCase())))
              ]),
            ])));
  }
}
