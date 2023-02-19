import 'dart:developer';

import 'package:base_project_bloc/core/extensions/list_extension.dart';
import 'package:flutter/material.dart';

String? currentRoute;
typedef OnRouteChange<R extends Route<dynamic>> = void Function(
  R? route,
  R? previousRoute,
);

class NavigatorMiddleware<R extends Route<dynamic>> extends RouteObserver<R> {
  NavigatorMiddleware({
    this.enableLogger = true,
    this.onPush,
    this.onPop,
    this.onReplace,
    this.onRemove,
  }) : _stack = [];

  final List<Route<dynamic>?> _stack;
  final bool enableLogger;

  final OnRouteChange<Route<dynamic>>? onPush;
  final OnRouteChange<Route<dynamic>>? onPop;
  final OnRouteChange<Route<dynamic>>? onReplace;
  final OnRouteChange<Route<dynamic>>? onRemove;

  //create clone list from stack
  List<R> get stack => List<R>.from(_stack);

  @override
  void didPush(Route route, Route? previousRoute) {
    _logget('{didPush} \n route: $route \n previousRoute: $previousRoute');
    _stack.add(route);
    _logStack();
    if (onPush != null) {
      onPush!(route, previousRoute);
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _logget('{didPop} \n route: $route \n previousRoute: $previousRoute');
    _stack.remove(route);
    _logStack();
    if (onPop != null) {
      onPop!(route, previousRoute);
    }
    super.didPop(route, previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _logget('{didReplace} \n newRoute: $newRoute \n oldRoute: $oldRoute');
    if (_stack.contains(oldRoute)) {
      final oldItemIndex = _stack.indexOf(oldRoute);
      _stack[oldItemIndex] = newRoute;
    }
    _logStack();
    if (onReplace != null) {
      onReplace!(newRoute, oldRoute);
    }
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _logget('{didRemove} \n route: $route \n previousRoute: $previousRoute');
    _stack.remove(route);
    _logStack();
    if (onRemove != null) {
      onRemove!(route, previousRoute);
    }
    super.didRemove(route, previousRoute);
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    _logget(
      '{didStartUserGesture} \n route: $route \n previousRoute: $previousRoute',
    );
    super.didStartUserGesture(route, previousRoute);
  }

  @override
  void didStopUserGesture() {
    _logget('{didStopUserGesture}');
    super.didStopUserGesture();
  }

  void _logStack() {
    final mappedStack =
        _stack.map((Route? route) => route?.settings.name).toList();
    _logget('Navigator stack: $mappedStack');
    currentRoute = stack.lastOrNull?.settings.name;
  }

  void _logget(String content) {
    if (enableLogger) {
      log(content);
    }
  }
}
