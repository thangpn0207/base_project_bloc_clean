// This is a guide file with examples on how to use GoRouter
// You can delete this file once you're familiar with GoRouter

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouterExamples extends StatelessWidget {
  const GoRouterExamples({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GoRouter Examples')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildExampleCard(
            title: 'Basic Navigation',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Navigate to a named route:'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => context.goNamed('login'),
                  child: const Text('Go to Login'),
                ),
                const SizedBox(height: 16),
                const Text('Navigate to a path:'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => context.go('/profile'),
                  child: const Text('Go to Profile'),
                ),
              ],
            ),
          ),
          _buildExampleCard(
            title: 'Navigation with Parameters',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Navigate with path parameters:'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => context.go('/details/123'),
                  child: const Text('Go to Details with ID 123'),
                ),
                const SizedBox(height: 16),
                const Text('Navigate with query parameters:'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => context.go('/settings?tab=notifications'),
                  child: const Text('Go to Settings with tab=notifications'),
                ),
              ],
            ),
          ),
          _buildExampleCard(
            title: 'Navigation with Extra Data',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Navigate with extra data (not in URL):'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // The extra data isn't part of the URL and is only available in the destination
                    context.goNamed(
                      'profile',
                      extra: {'userId': 456, 'premium': true},
                    );
                  },
                  child: const Text('Go to Profile with extra data'),
                ),
              ],
            ),
          ),
          _buildExampleCard(
            title: 'Navigation with Replacement',
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Replace current route (can\'t go back):'),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => context.pushReplacementNamed('login'),
                  child: const Text('Replace with Login'),
                ),
              ],
            ),
          ),
          _buildExampleCard(
            title: 'Accessing Route Parameters',
            content: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''
// Inside your page widget:
final String id = GoRouterState.of(context).pathParameters['id'] ?? '';

// Or in the route definition:
GoRoute(
  path: 'details/:id',
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    return DetailsScreen(id: id);
  },
),

// Accessing query parameters:
final String tab = GoRouterState.of(context).uri.queryParameters['tab'] ?? 'default';

// Accessing extra data:
final Map<String, dynamic>? extra = GoRouterState.of(context).extra as Map<String, dynamic>?;
final userId = extra?['userId'];
''',
                  style: TextStyle(fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
          _buildExampleCard(
            title: 'Using Programmatically (outside of Widget context)',
            content: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '''
// In service or bloc:
import 'package:base_project_bloc/presentation_layer/core_app/routes/app_router.dart';

void navigateToLogin() {
  AppRouter.router.go('/login');
}

void navigateWithParams() {
  AppRouter.router.goNamed(
    'details',
    pathParameters: {'id': '789'},
  );
}
''',
                  style: TextStyle(fontFamily: 'monospace'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExampleCard({
    required String title,
    required Widget content,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Divider(),
            const SizedBox(height: 8),
            content,
          ],
        ),
      ),
    );
  }
}
