
import 'package:flutter/foundation.dart';

class ProductModel {
  int id;
  int usersId;
  String name;
  double price;
  String description;
  int purchaseMonth;
  int purchaseYear;

  ProductModel({
    @required String name,
    @required double price,
    @required int purchaseMonth,
    @required int purchaseYear,
    String description,
    int id,
    int usersId,
  }) {
    this.id = id;
    this.usersId = usersId;
    this.name = name;
    this.price = price;
    this.description = description;
    this.purchaseMonth = purchaseMonth;
    this.purchaseYear = purchaseYear;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'users_id': usersId,
      'name': name,
      'price': price,
      'description': description,
      'purchase_month': purchaseMonth,
      'purchase_year': purchaseYear,
    };
  }
}
