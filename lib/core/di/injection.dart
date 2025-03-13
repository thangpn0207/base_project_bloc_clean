import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:base_project_bloc/core/theme/cubit/theme_cubit.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Theme
  getIt.registerSingleton<ThemeCubit>(ThemeCubit(getIt()));

  // Add other dependencies here
}
