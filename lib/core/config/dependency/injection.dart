import 'package:base_project_bloc/data_layer/remote_data/remote_services/clients/app_client.dart';
import 'package:base_project_bloc/data_layer/remote_data/remote_services/clients/dio_manager.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init(String baseUrl) async {
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

void _configureRepositories() {}

void _configureBlocs() {}
