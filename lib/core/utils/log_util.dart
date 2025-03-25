import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

/// Enhanced logging utility that only logs in debug mode
class LogUtil {
  static final Map<String, Logger> _loggers = {};
  static bool _isInitialized = false;
  static bool _isEnabled = true;

  /// Initialize the logging system
  static void init() {
    if (_isInitialized) return;

    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((record) {
      if (kDebugMode && _isEnabled) {
        final time = record.time.toIso8601String().split('T')[1].split('.')[0];
        final level = record.level.name.padRight(8);
        final logger = record.loggerName.padRight(20);
        final message = record.message;

        if (record.level >= Level.SEVERE) {
          print('[$time] $level $logger: $message');
          if (record.error != null) {
            print('Error: ${record.error}');
          }
          if (record.stackTrace != null) {
            print('Stack trace: ${record.stackTrace}');
          }
        } else {
          print('[$time] $level $logger: $message');
        }
      }
    });

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
    return _loggers.putIfAbsent(name, () => Logger(name));
  }

  /// Log a debug message
  static void d(String message,
      {String? tag, Object? error, StackTrace? stackTrace,}) {
    final logger = getLogger(tag ?? 'App');
    logger.fine(message, error, stackTrace);
  }

  /// Log an info message
  static void i(String message,
      {String? tag, Object? error, StackTrace? stackTrace,}) {
    final logger = getLogger(tag ?? 'App');
    logger.info(message, error, stackTrace);
  }

  /// Log a warning message
  static void w(String message,
      {String? tag, Object? error, StackTrace? stackTrace,}) {
    final logger = getLogger(tag ?? 'App');
    logger.warning(message, error, stackTrace);
  }

  /// Log an error message
  static void e(String message,
      {String? tag, Object? error, StackTrace? stackTrace,}) {
    final logger = getLogger(tag ?? 'App');
    logger.severe(message, error, stackTrace);
  }

  /// Log a navigation event
  static void nav(String message, {String? tag}) {
    final logger = getLogger(tag ?? 'Navigation');
    logger.info('[NAV] $message');
  }

  /// Get current build mode
  static String get currentBuildMode {
    if (kDebugMode) return 'DEBUG';
    if (kProfileMode) return 'PROFILE';
    if (kReleaseMode) return 'RELEASE';
    return 'UNKNOWN';
  }
}
