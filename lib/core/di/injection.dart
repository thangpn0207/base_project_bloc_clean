import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:base_project_bloc/core/theme/cubit/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  final prefs = await SharedPreferences.getInstance();

  // Using cascade notation for multiple registrations
  getIt
    ..registerSingleton<SharedPreferences>(prefs)
    ..registerSingleton<ThemeCubit>(ThemeCubit(getIt()));

  // Add other dependencies here
}
