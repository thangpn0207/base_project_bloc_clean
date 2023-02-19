import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Routes {
  Routes._();

  static Map<String, Widget Function(BuildContext context)> routes = {};
}
