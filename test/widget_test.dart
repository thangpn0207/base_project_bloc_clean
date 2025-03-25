// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:base_project_bloc/core/config/env/environment.dart';
import 'package:base_project_bloc/core/config/debug/debug_config.dart';
import 'package:base_project_bloc/core/config/dependency/injection.dart'
    as inject;
import 'package:base_project_bloc/presentation_layer/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() async {
    // Initialize environment and dependencies for testing
    await Environment.initialize(env: EnvironmentType.development);
    DebugConfig.init();
    await inject.init(Environment.baseUrl);
  });

  testWidgets('App initialization test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify basic app rendering
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
