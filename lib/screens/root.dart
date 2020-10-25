import 'package:curimba/screens/home.dart';
import 'package:curimba/screens/sign_in.dart';
import 'package:curimba/view_models/card_view_model.dart';
import 'package:curimba/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    return userViewModel.loggedUser != null ? Home() : SignIn();
  }
}
