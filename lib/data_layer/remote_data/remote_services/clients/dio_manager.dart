import 'package:base_project_bloc/core/config/network_config/configs_network.dart';
import 'package:base_project_bloc/data_layer/remote_data/remote_services/interceptors/token_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioManager {
  final Dio dio = createDio();
  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        receiveTimeout:
            const Duration(milliseconds: ConfigNetwork.receiveTimeout),
        connectTimeout:
            const Duration(milliseconds: ConfigNetwork.connectTimeout),
        sendTimeout: const Duration(milliseconds: ConfigNetwork.sendTimeout),
      ),
    );
    //add interceptors debug
    //add interceptors
    dio.interceptors.addAll({
      //logging interceptor
      TokenInterceptor(),
      //error interceptor
      ErrorInterceptors(),
    });
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        compact: false,
        maxWidth: 120,
      ),
    );

    //_enableMock(dio);

    return dio;
  }
}
