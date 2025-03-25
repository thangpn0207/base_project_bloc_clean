import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:base_project_bloc/core/utils/log_util.dart';

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
      route,
    );
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logEvent(
      'POP',
      'Current: ${route.settings.name}, Previous: ${previousRoute?.settings.name}',
      previousRoute,
    );
    super.didPop(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logEvent(
      'REMOVE',
      'Current: ${route.settings.name}, Previous: ${previousRoute?.settings.name}',
      previousRoute,
    );
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _logEvent(
      'REPLACE',
      'New: ${newRoute?.settings.name}, Old: ${oldRoute?.settings.name}',
      newRoute,
    );
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  void _logEvent(String event, String message, Route<dynamic>? route) {
    // Check if logging is enabled and we're in debug mode
    if (!enableLogger || !kDebugMode) {
      return;
    }

    // Extract GoRouter state if available
    final state = _extractGoRouterState(route);
    final location = state?.uri.toString() ?? route?.settings.name;
    currentLocation = location;

    final params = state?.pathParameters.isNotEmpty ?? false
        ? 'Path Params: ${state!.pathParameters}'
        : '';
    final queryParams = state?.uri.queryParameters.isNotEmpty ?? false
        ? 'Query Params: ${state!.uri.queryParameters}'
        : '';
    final extra = state?.extra != null ? 'Extra: ${state!.extra}' : '';

    // Build a more structured log message
    final StringBuilder sb = StringBuilder();
    sb.appendLine('🧭 GoRouter [$event] $message');

    if (location != null) {
      sb.appendLine('📍 Location: $location');
    }

    if (params.isNotEmpty) {
      sb.appendLine('🔑 $params');
    }

    if (queryParams.isNotEmpty) {
      sb.appendLine('🔍 $queryParams');
    }

    if (extra.isNotEmpty) {
      sb.appendLine('📦 $extra');
    }

    sb.appendLine('-----------------------------------');

    // Use our enhanced logger
    LogUtil.nav(sb.toString(), tag: 'GoRouter');
  }

  GoRouterState? _extractGoRouterState(Route<dynamic>? route) {
    if (route == null) {
      return null;
    }

    // Try to extract GoRouterState from route
    if (route.settings.name?.startsWith('/') ?? false) {
      // This might be a GoRouter route
      final arguments = route.settings.arguments;
      if (arguments is Map && arguments['state'] is GoRouterState) {
        return arguments['state'] as GoRouterState;
      }
    }
    return null;
  }
}

/// Simple string builder for creating multi-line log messages
class StringBuilder {
  final StringBuffer _buffer = StringBuffer();

  void append(String text) {
    _buffer.write(text);
  }

  void appendLine(String text) {
    _buffer.writeln(text);
  }

  @override
  String toString() {
    return _buffer.toString();
  }
}
