import 'package:dio/dio.dart';
import 'package:base_project_bloc/core/utils/log_util.dart';

/// Interceptor for handling and logging network errors
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final errorMessage = _buildErrorMessage(err);
    LogUtil.e(
      errorMessage,
      tag: 'Network',
      error: err.error,
      stackTrace: err.stackTrace,
    );
    handler.next(err);
  }

  String _buildErrorMessage(DioException err) {
    final buffer = StringBuffer()
      ..writeln('Network Error:')
      ..writeln('URL: ${err.requestOptions.uri}')
      ..writeln('Method: ${err.requestOptions.method}')
      ..writeln('Status Code: ${err.response?.statusCode}');

    if (err.response?.data != null) {
      buffer.writeln('Response Data: ${err.response?.data}');
    }

    if (err.error != null) {
      buffer.writeln('Error: ${err.error}');
    }

    if (err.message != null) {
      buffer.writeln('Message: ${err.message}');
    }

    return buffer.toString();
  }
}
