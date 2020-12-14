
import 'package:flutter/foundation.dart';

class ProductModel {
  int id;
  int usersId;
  String name;
  double price;
  String description;
  int month;

  ProductModel({
    @required String name,
    @required double price,
    @required int month,
    String description,
    int id,
    int usersId,
  }) {
    this.id = id;
    this.usersId = usersId;
    this.name = name;
    this.price = price;
    this.description = description;
    this.month = month;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'users_id': usersId,
      'name': name,
      'price': price,
      'description': description,
      'month': month,
    };
  }
}
