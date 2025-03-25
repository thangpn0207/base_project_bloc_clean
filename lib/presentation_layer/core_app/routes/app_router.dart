import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:base_project_bloc/core/observers/go_router_observer.dart';
import 'package:base_project_bloc/core/utils/page_transitions.dart';
import 'package:base_project_bloc/core/utils/advanced_transitions.dart';

// Import your screens here
// import 'package:base_project_bloc/presentation_layer/screens/home_screen.dart';
// import 'package:base_project_bloc/presentation_layer/screens/login_screen.dart';

// Define route names as constants for easier reference
class AppRoutes {
  static const home = '/';
  static const login = '/login';
  static const profile = '/profile';
  static const settings = '/settings';
  // Add more routes as needed
}

final navigatorKey = GlobalKey<NavigatorState>();
final goRouterObserver = GoRouterObserver();

// Define a function to create a transition between routes
Page<dynamic> _buildPageWithTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  required String path,
}) {
  // Pick transition based on the path
  switch (path) {
    case AppRoutes.login:
      return PageTransitions.fadeTransition(context, state, child);
    case AppRoutes.profile:
      return PageTransitions.slideFromRightTransition(context, state, child);
    case AppRoutes.settings:
      return PageTransitions.slideFromBottomTransition(context, state, child);
    default:
      return PageTransitions.fadeTransition(context, state, child);
  }
}

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    observers: [goRouterObserver],

    // Define page transition for each route
    routes: [
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        pageBuilder: (context, state) => PageTransitions.fadeTransition(
          context,
          state,
          const Scaffold(
            body: Center(
              child: Text('Home Screen - Replace with your HomeScreen'),
            ),
          ),
        ),
        routes: [
          // Nested routes
          GoRoute(
            path: 'details/:id',
            name: 'details',
            pageBuilder: (context, state) {
              final id = state.pathParameters['id']!;
              return PageTransitions.slideFromRightTransition(
                context,
                state,
                Scaffold(
                  appBar: AppBar(title: Text('Details: $id')),
                  body: Center(child: Text('Details for item $id')),
                ),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        pageBuilder: (context, state) => _buildPageWithTransition(
          context: context,
          state: state,
          path: AppRoutes.login,
          child: const Scaffold(
            body: Center(
              child: Text('Login Screen - Replace with your LoginScreen'),
            ),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        pageBuilder: (context, state) =>
            AdvancedTransitions.sharedAxisTransition(
          context: context,
          state: state,
          type: SharedAxisTransitionType.horizontal,
          child: Scaffold(
            appBar: AppBar(title: const Text('Profile')),
            body: const Center(child: Text('Profile Screen')),
          ),
        ),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        pageBuilder: (context, state) {
          // Example of handling query parameters
          final tab = state.uri.queryParameters['tab'] ?? 'general';
          return AdvancedTransitions.bottomToTopFadeTransition(
            context: context,
            state: state,
            child: Scaffold(
              appBar: AppBar(title: const Text('Settings')),
              body: Center(child: Text('Settings Tab: $tab')),
            ),
          );
        },
      ),
    ],
    // Error handling
    errorPageBuilder: (context, state) => PageTransitions.fadeTransition(
      context,
      state,
      Scaffold(
        appBar: AppBar(title: const Text('Page Not Found')),
        body: Center(
          child: Text('No route found for ${state.uri.path}'),
        ),
      ),
    ),
    // Redirect logic
    redirect: (context, state) {
      // Example: check authentication and redirect if needed
      // final isAuthenticated = AuthService.isAuthenticated();
      // if (!isAuthenticated && state.path != AppRoutes.login) {
      //   return AppRoutes.login;
      // }
      return null; // No redirect
    },
  );
}
