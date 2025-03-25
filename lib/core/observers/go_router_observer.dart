import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Observer for logging GoRouter navigation events
class GoRouterObserver extends NavigatorObserver {
  final bool enableLogger;

  GoRouterObserver({this.enableLogger = true});

  String? currentLocation;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logEvent(
        'PUSH',
        'Current: ${route.settings.name}, Previous: ${previousRoute?.settings.name}',
        route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logEvent(
        'POP',
        'Current: ${route.settings.name}, Previous: ${previousRoute?.settings.name}',
        previousRoute);
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logEvent(
        'REMOVE',
        'Current: ${route.settings.name}, Previous: ${previousRoute?.settings.name}',
        previousRoute);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _logEvent(
        'REPLACE',
        'New: ${newRoute?.settings.name}, Old: ${oldRoute?.settings.name}',
        newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void _logEvent(String event, String message, Route<dynamic>? route) {
    if (!enableLogger) return;

    // Extract GoRouter state if available
    final state = _extractGoRouterState(route);
    final location = state?.uri.toString() ?? route?.settings.name;
    currentLocation = location;

    final params = state?.pathParameters.isNotEmpty == true
        ? 'Path Params: ${state!.pathParameters}'
        : '';
    final queryParams = state?.uri.queryParameters.isNotEmpty == true
        ? 'Query Params: ${state!.uri.queryParameters}'
        : '';
    final extra = state?.extra != null ? 'Extra: ${state!.extra}' : '';

    log('🧭 GoRouter [$event] $message');
    if (location != null) log('📍 Location: $location');
    if (params.isNotEmpty) log('🔑 $params');
    if (queryParams.isNotEmpty) log('🔍 $queryParams');
    if (extra.isNotEmpty) log('📦 $extra');
    log('-----------------------------------');
  }

  GoRouterState? _extractGoRouterState(Route<dynamic>? route) {
    if (route == null) return null;

    // Try to extract GoRouterState from route
    if (route.settings.name?.startsWith('/') == true) {
      // This might be a GoRouter route
      final arguments = route.settings.arguments;
      if (arguments is Map && arguments['state'] is GoRouterState) {
        return arguments['state'] as GoRouterState;
      }
    }
    return null;
  }
}
