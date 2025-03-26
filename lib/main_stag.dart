import 'package:base_project_bloc/core/config/debug/debug_config.dart';
import 'package:base_project_bloc/core/config/dependency/injection.dart'
    as inject;
import 'package:base_project_bloc/core/config/env/environment.dart';
import 'package:base_project_bloc/core/observers/bloc_observer.dart';
import 'package:base_project_bloc/presentation_layer/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project_bloc/core/utils/log_util.dart';

/// Main entry point for staging environment (both web and native)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging
  LogUtil.init();

  // Initialize environment
  await Environment.initialize(env: EnvironmentType.staging);

  // Initialize debug configuration
  DebugConfig.init();

  // Log environment info
  LogUtil.i('App running in STAGING environment', tag: 'MainStag');
  LogUtil.i('App Name: ${Environment.appName}', tag: 'MainStag');
  LogUtil.i('Base URL: ${Environment.baseUrl}', tag: 'MainStag');

  // Initialize dependencies
  await inject.init(Environment.baseUrl);

  // Set bloc observer
  Bloc.observer = ObserverBloc();

  runApp(const MyApp());
}
