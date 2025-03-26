// ignore_for_file: cascade_invocations, avoid_positional_boolean_parameters, use_setters_to_change_properties

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Enhanced logging utility that only logs in debug mode
class LogUtil {
  static final Map<String, Logger> _loggers = {};
  static bool _isInitialized = false;
  static bool _isEnabled = true;

  /// Initialize the logging system
  static void init() {
    if (_isInitialized) {
      return;
    }

    // Configure the default logger with a simple printer
    Logger.level = Level.debug;
    _isInitialized = true;
  }

  /// Enable or disable all logging
  static void setLoggingEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// Get a logger instance for the given name
  static Logger getLogger(String name) {
    if (!_isInitialized) {
      init();
    }
    return _loggers.putIfAbsent(name, () {
      return Logger(
        printer: SimplePrinter(
          colors: true,
          printTime: true,
        ),
      );
    });
  }

  /// Log a debug message
  static void d(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode || !_isEnabled) {
      return;
    }
    final logger = getLogger(tag ?? 'App');
    logger.d(message);
    if (error != null) {
      logger.e('Error: $error');
    }
    if (stackTrace != null) {
      logger.e('Stack trace: $stackTrace');
    }
  }

  /// Log an info message
  static void i(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode || !_isEnabled) {
      return;
    }
    final logger = getLogger(tag ?? 'App');
    logger.i(message);
    if (error != null) {
      logger.e('Error: $error');
    }
    if (stackTrace != null) {
      logger.e('Stack trace: $stackTrace');
    }
  }

  /// Log a warning message
  static void w(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode || !_isEnabled) {
      return;
    }
    final logger = getLogger(tag ?? 'App');
    logger.w(message);
    if (error != null) {
      logger.e('Error: $error');
    }
    if (stackTrace != null) {
      logger.e('Stack trace: $stackTrace');
    }
  }

  /// Log an error message
  static void e(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode || !_isEnabled) {
      return;
    }
    final logger = getLogger(tag ?? 'App');
    logger.e(message);
    if (error != null) {
      logger.e('Error: $error');
    }
    if (stackTrace != null) {
      logger.e('Stack trace: $stackTrace');
    }
  }

  /// Log a navigation event
  static void nav(String message, {String? tag}) {
    if (!kDebugMode || !_isEnabled) {
      return;
    }
    final logger = getLogger(tag ?? 'Navigation');
    logger.i('[NAV] $message');
  }

  /// Get current build mode
  static String get currentBuildMode {
    if (kDebugMode) {
      return 'DEBUG';
    }
    if (kProfileMode) {
      return 'PROFILE';
    }
    if (kReleaseMode) {
      return 'RELEASE';
    }
    return 'UNKNOWN';
  }

  /// Create a PrettyDioLogger instance for Dio
  static PrettyDioLogger createDioLogger() {
    return PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      compact: true,
      maxWidth: 90,
    );
  }
}
