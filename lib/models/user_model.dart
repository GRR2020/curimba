import 'package:flutter/foundation.dart';

class UserModel {
  int id;
  String name;
  String username;
  String password;

  UserModel({
    @required String name,
    @required String username,
    @required String password,
    int id,
  }) {
    this.id = id;
    this.name = name;
    this.username = username;
    this.password = password;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'password': password,
    };
  }
}
