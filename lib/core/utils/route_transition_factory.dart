import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:base_project_bloc/core/utils/page_transitions.dart';
import 'package:base_project_bloc/presentation_layer/core_app/routes/app_router.dart';

/// Type definition for page builder functions
typedef TransitionBuilder = Page<dynamic> Function(
  BuildContext context,
  GoRouterState state,
  Widget child,
);

/// Factory class to determine the transition based on route combinations
class RouteTransitionFactory {
  /// Map that defines what transition to use between route paths
  static final Map<String, Map<String, TransitionBuilder>> _transitions = {
    // From home to various destinations
    AppRoutes.home: {
      AppRoutes.login: PageTransitions.fadeTransition,
      AppRoutes.profile: PageTransitions.slideFromRightTransition,
      AppRoutes.settings: PageTransitions.slideFromBottomTransition,
      'default': PageTransitions.fadeTransition,
    },

    // From login to various destinations
    AppRoutes.login: {
      AppRoutes.home: PageTransitions.slideFromLeftTransition,
      AppRoutes.profile: PageTransitions.slideFromRightTransition,
      'default': PageTransitions.fadeTransition,
    },

    // From profile to various destinations
    AppRoutes.profile: {
      AppRoutes.home: PageTransitions.slideFromLeftTransition,
      AppRoutes.settings: PageTransitions.slideFromBottomTransition,
      'default': PageTransitions.slideFromRightTransition,
    },

    // From settings to various destinations
    AppRoutes.settings: {
      AppRoutes.home: PageTransitions.fadeTransition,
      AppRoutes.profile: PageTransitions.scaleTransition,
      'default': PageTransitions.slideFromBottomTransition,
    },

    // Default transition if source route is not defined
    'default': {
      'default': PageTransitions.fadeTransition,
    }
  };

  /// Get the appropriate transition between routes
  static Page<dynamic> getTransition(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    // Get source route (previous route) and destination route (current route)
    final String? sourceRoute = state.extra is Map
        ? (state.extra as Map)['previousRoute'] as String?
        : null;
    final String destinationRoute = state.matchedLocation;

    // Determine the transition based on route combination
    if (sourceRoute != null && _transitions.containsKey(sourceRoute)) {
      final transitions = _transitions[sourceRoute]!;

      if (transitions.containsKey(destinationRoute)) {
        return transitions[destinationRoute]!(context, state, child);
      } else {
        return transitions['default']!(context, state, child);
      }
    }

    // Fall back to default transition
    return _transitions['default']!['default']!(context, state, child);
  }

  /// Method to add previous route info to extra data
  static Map<String, dynamic> withPreviousRoute(
    String previousRoute, [
    Map<String, dynamic>? extraData,
  ]) {
    final result = <String, dynamic>{
      'previousRoute': previousRoute,
    };

    if (extraData != null) {
      result.addAll(extraData);
    }

    return result;
  }
}
