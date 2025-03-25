import 'package:base_project_bloc/presentation_layer/core_app/routes/app_router.dart';

/// Utility class for accessing route information from anywhere in the app
class RouteUtils {
  /// Get the current location in the app
  static String? get currentLocation => goRouterObserver.currentLocation;

  /// Check if we're currently on a specific route
  static bool isCurrentRoute(String route) {
    final current = currentLocation;
    if (current == null) {
      return false;
    }

    return current == route ||
        current.startsWith('$route?') ||
        current.startsWith('$route/');
  }

  /// Extract the route name without query parameters
  static String? get currentRouteName {
    final location = currentLocation;
    if (location == null) {
      return null;
    }

    final uri = Uri.parse(location);
    return uri.path;
  }

  /// Navigate to a route programmatically from anywhere
  static void navigateTo(String route) {
    AppRouter.router.go(route);
  }

  /// Navigate to a named route programmatically from anywhere
  static void navigateToNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    AppRouter.router.goNamed(
      name,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }
}
