import 'package:flutter/cupertino.dart';

class UserModel {
  int id;
  String name;
  String username;
  String password;
  int receiveNotifications;

  UserModel({
    @required String name,
    @required String username,
    @required String password,
    @required int receiveNotifications,
    int id,
  }) {
    this.id = id;
    this.name = name;
    this.username = username;
    this.password = password;
    this.receiveNotifications = receiveNotifications;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'password': password,
      'receive_notifications': receiveNotifications
    };
  }
}
