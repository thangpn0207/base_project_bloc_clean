import 'package:base_project_bloc/core/config/debug/debug_config.dart';
import 'package:base_project_bloc/core/config/dependency/injection.dart'
    as inject;
import 'package:base_project_bloc/core/config/env/environment.dart';
import 'package:base_project_bloc/core/observers/bloc_observer.dart';
import 'package:base_project_bloc/presentation_layer/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Main entry point for development environment (both web and native)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize environment
  await Environment.initialize(env: EnvironmentType.development);

  // Initialize debug configuration
  DebugConfig.init();

  // Log app info if debug mode is enabled in .env
  if (Environment.debugModeEnabled) {
    DebugConfig.logAppInfo();
    print('App running in DEVELOPMENT environment');
    print('App Name: ${Environment.appName}');
    print('Base URL: ${Environment.baseUrl}');
  }

  // Initialize dependencies
  await inject.init(Environment.baseUrl);

  // Set bloc observer
  Bloc.observer = ObserverBloc();

  runApp(const MyApp());
}
