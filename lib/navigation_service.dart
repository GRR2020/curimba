import 'package:curimba/screens/cards_list.dart';
import 'package:curimba/screens/create_card.dart';
import 'package:curimba/screens/home.dart';
import 'package:curimba/screens/recomended_cards.dart';
import 'package:curimba/screens/sign_in.dart';
import 'package:curimba/screens/sign_up.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
  new GlobalKey<NavigatorState>();  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }
  Widget widgetForRoute(RouteSettings routeSettings) {
    var params = routeSettings.name.split('?');
    final route = params.removeAt(0);

    switch (route) {
      case '/home':
        return Home();
      case '/register-card':
        return CreateCard();
      case '/list-cards':
        return ListCards();
      case '/recommended-cards':
        return RecommendedCards();
      case '/sign-in':
        return SignIn();
      case '/sign-up':
        return SignUp();
      default:
        return SignIn();
    }
  }
}
