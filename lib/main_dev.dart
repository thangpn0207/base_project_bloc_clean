import 'package:base_project_bloc/core/config/debug/debug_config.dart';
import 'package:base_project_bloc/core/config/flavor/flavor.dart';
import 'package:base_project_bloc/core/observers/bloc_observer.dart';
import 'package:base_project_bloc/presentation_layer/app.dart';
import 'package:flutter/material.dart';
import 'package:base_project_bloc/core/config/dependency/injection.dart'
    as inject;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize debug configuration
  DebugConfig.init();
  DebugConfig.logAppInfo();

  setFlavor(FlavorType.dev);
  await inject.init(FlavorConfig.values.baseUrl);
  Bloc.observer = ObserverBloc();
  runApp(const MyApp());
}
