import 'package:base_project_bloc/core/utils/log_util.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    LogUtil.e('Dio err raw data: ${err.response?.data}', tag: 'DioError');

    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        LogUtil.e('Dio err type: ${err.response?.statusCode}', tag: 'DioError');
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.sendTimeout:
        LogUtil.e('Dio err type: ${err.response?.statusCode}', tag: 'DioError');
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.receiveTimeout:
        LogUtil.e('Dio err type: ${err.response?.statusCode}', tag: 'DioError');
        throw DeadlineExceededException(err.requestOptions);
      case DioExceptionType.badResponse:
        switch (err.response?.statusCode) {
          case 400:
            LogUtil.e('Bad request', tag: 'DioError');
            throw BadRequestException(err.requestOptions);
          case 401:
            LogUtil.e('401', tag: 'DioError');
            throw UnauthorizedException(err.requestOptions);
          case 403:
            LogUtil.e('Forbidden', tag: 'DioError');
            throw ForbiddenException(err.requestOptions);
          case 404:
            LogUtil.e('Not found', tag: 'DioError');
            throw NotFoundException(err.requestOptions, err.response);
          case 409:
            LogUtil.e('Conflict', tag: 'DioError');
            throw ConflictException(err.requestOptions);
          case 500:
            LogUtil.e('Server error', tag: 'DioError');
            throw InternalServerErrorException(err.requestOptions);
          default:
            LogUtil.e('Something went wrong', tag: 'DioError');
            throw UnknownException(err.requestOptions);
        }
      case DioExceptionType.cancel:
        LogUtil.e('Request cancelled', tag: 'DioError');
        break;
      case DioExceptionType.badCertificate:
        throw NoInternetConnectionException(err.requestOptions);
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(err.requestOptions);
      case DioExceptionType.unknown:
        throw NoInternetConnectionException(err.requestOptions);
    }
    handler.next(err);
  }
}

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);
  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioException {
  NotFoundException(
    RequestOptions r,
    Response<dynamic>? response,
  ) : super(requestOptions: r, response: response);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioException {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}

class ForbiddenException extends DioException {
  ForbiddenException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access forbidden';
  }
}

class UnknownException extends DioException {
  UnknownException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'An unknown error occurred';
  }
}
