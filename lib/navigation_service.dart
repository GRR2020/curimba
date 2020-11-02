import 'package:curimba/screens/create_card.dart';
import 'package:curimba/screens/home.dart';
import 'package:curimba/screens/list_cards.dart';
import 'package:curimba/screens/recomended_cards.dart';
import 'package:curimba/screens/root.dart';
import 'package:curimba/screens/sign_in.dart';
import 'package:curimba/screens/sign_up.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateToAndReplace(String routeName) {
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => Home());
      case '/register-card':
        return MaterialPageRoute(builder: (_) => CreateCard());
      case '/list-cards':
        return MaterialPageRoute(builder: (_) => ListCards());
      case '/recommended-cards':
        return MaterialPageRoute(builder: (_) => RecommendedCards());
      case '/sign-in':
        return MaterialPageRoute(builder: (_) => SignIn());
      case '/sign-up':
        return MaterialPageRoute(builder: (_) => SignUp());
      default:
        return MaterialPageRoute(builder: (_) => Root());
    }
  }
}
