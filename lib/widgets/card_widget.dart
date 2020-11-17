import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CardWidget extends StatelessWidget {
  final String brandName;
  final String lastNumbers;
  final String expiryDate;

  CardWidget({
    @required this.brandName,
    @required this.lastNumbers,
    @required this.expiryDate,
  });

  @override
  Widget build(BuildContext context) {
    final _color = Colors.grey;

    return Container(
      color: Colors.white70,
      padding: EdgeInsets.all(10),
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: Icon(
              Icons.credit_card_rounded,
              color: _color,
            ),
            flex: 0,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: VerticalDivider(
                color: _color,
                width: 1,
              ),
            ),
            flex: 0,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Text(brandName, style: TextStyle(color: _color)),
                      Text(expiryDate, style: TextStyle(color: _color)),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
                Expanded(
                    child: Text(lastNumbers, style: TextStyle(color: _color))),
              ],
              crossAxisAlignment: CrossAxisAlignment.stretch,
            ),
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.stretch,
      ),
    );
  }
}
