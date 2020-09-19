import 'package:curimba/screens/create_card.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tela inicial', style: TextStyle(fontFamily: 'Rubik')),
        ),
        body: Center(
            child: Column(children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateCard()),
                  );
                },
                color: Colors.black,
                textColor: Colors.white,
                child: Text('Cadastrar cartão'.toUpperCase(),
                    style: TextStyle(fontFamily: 'Rubik')),
              ),
              RaisedButton(
                onPressed: () {
                  // MaterialPageRoute(builder: (context) => ListCard());
                },
                color: Colors.black,
                textColor: Colors.white,
                child: Text('Listar cartões'.toUpperCase(),
                    style: TextStyle(fontFamily: 'Rubik')),
              )
            ])));
  }
}
