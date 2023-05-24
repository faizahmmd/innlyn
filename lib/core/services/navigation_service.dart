import 'package:flutter/material.dart';
import 'package:innlyn/core/services/service_locator.dart';
final NavigationService navigationService = locator.get<NavigationService>();

class NavigationService {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  get currentContext => _navigatorKey.currentContext;

  Future<dynamic>? navigateTo(String routeName, Object? argument) {
    return _navigatorKey.currentState
        ?.pushNamed(routeName, arguments: argument);
  }

  Future<dynamic>? navigatePushReplacementNamedTo(
      String routeName, Object? argument) {
    return _navigatorKey.currentState
        ?.pushReplacementNamed(routeName, arguments: argument);
  }

  Future<dynamic>? navigatePushNamedAndRemoveUntilTo(
      String routeName, Object? argument) {
    return _navigatorKey.currentState?.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: argument);
  }

  void navigatePop() {
    return _navigatorKey.currentState?.pop();
  }
}
