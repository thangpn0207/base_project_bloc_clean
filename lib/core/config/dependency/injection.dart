import 'package:base_project_bloc/data_layer/remote_data/remote_services/clients/app_client.dart';
import 'package:base_project_bloc/data_layer/remote_data/remote_services/clients/dio_manager.dart';
import 'package:base_project_bloc/presentation_layer/core_app/locale/cubit/locale_cubit.dart';
import 'package:base_project_bloc/presentation_layer/theme/cubit/theme_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> init(String baseUrl) async {
  // Initialize shared preferences first
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  _configureBlocs();
  _configureRepositories();
  _configureCores(baseUrl);
}

void _configureCores(String baseUrl) {
  getIt
    ..registerLazySingleton(DioManager.new)
    ..registerLazySingleton<AppClient>(() {
      return AppClient(getIt<DioManager>().dio, baseUrl: baseUrl);
    });
}

void _configureRepositories() {
  // Register repositories here
}

void _configureBlocs() {
  // Register ThemeCubit
  getIt
    ..registerSingleton<ThemeCubit>(ThemeCubit(getIt<SharedPreferences>()))

    // Register LocaleCubit
    ..registerSingleton<LocaleCubit>(LocaleCubit(getIt<SharedPreferences>()));
}
