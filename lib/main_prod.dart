import 'package:base_project_bloc/core/config/debug/debug_config.dart';
import 'package:base_project_bloc/core/config/dependency/injection.dart'
    as inject;
import 'package:base_project_bloc/core/config/env/environment.dart';
import 'package:base_project_bloc/core/observers/bloc_observer.dart';
import 'package:base_project_bloc/presentation_layer/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project_bloc/core/utils/log_util.dart';

/// Main entry point for production environment (both web and native)
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize logging
  LogUtil.init();

  // Initialize environment
  await Environment.initialize(env: EnvironmentType.production);

  // Initialize debug configuration - should be disabled in production anyway
  DebugConfig.init();

  // Log environment info
  LogUtil.i('App running in PRODUCTION environment', tag: 'MainProd');
  LogUtil.i('App Name: ${Environment.appName}', tag: 'MainProd');
  LogUtil.i('Base URL: ${Environment.baseUrl}', tag: 'MainProd');

  // Initialize dependencies
  await inject.init(Environment.baseUrl);

  // Set bloc observer
  Bloc.observer = ObserverBloc();

  runApp(const MyApp());
}
