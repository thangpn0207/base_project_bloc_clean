import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Enhanced logging utility that only logs in debug mode
class LoggerUtil extends Logger {
  LogPrinter? printer;
  Level? level;

  /// Controls whether logging is enabled globally
  static bool _isEnabled = true;

  /// Current build mode (debug, profile, release)
  static final bool _isDebugMode = kDebugMode;
  static final bool _isReleaseMode = kReleaseMode;
  static final bool _isProfileMode = kProfileMode;

  LoggerUtil({
    required this.printer,
    required this.level,
  }) : super(
          printer: printer,
          level: level,
        );

  /// Enable or disable all logging
  static void setLoggingEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// Returns whether logs should be shown based on current settings
  static bool get shouldShowLogs => _isEnabled && _isDebugMode;

  /// Current build mode as string
  static String get currentBuildMode {
    if (_isDebugMode) return 'DEBUG';
    if (_isProfileMode) return 'PROFILE';
    if (_isReleaseMode) return 'RELEASE';
    return 'UNKNOWN';
  }

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (shouldShowLogs) {
      e('[ERROR] $message', error, stackTrace);
    }
  }

  void warn(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (shouldShowLogs) {
      w('[WARN] $message', error, stackTrace);
    }
  }

  void info(dynamic message) {
    if (shouldShowLogs) {
      i('[INFO] $message');
    }
  }

  void debug(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (shouldShowLogs) {
      d('[DEBUG] $message', error, stackTrace);
    }
  }

  void verbose(dynamic message) {
    if (shouldShowLogs) {
      v('[VERBOSE]\n$message');
    }
  }

  /// Log navigation events from GoRouter
  void nav(dynamic message) {
    if (shouldShowLogs) {
      i('[NAVIGATION] $message');
    }
  }

  static Level logLevel() {
    if (kReleaseMode) {
      return Level.nothing;
    }
    return Level.verbose;
  }
}

/// Global logger instance for use throughout the app
final LoggerUtil logUtil = LoggerUtil(
  printer: PrettyPrinter(
    methodCount: 0,
    lineLength: 150,
    printTime: true,
    printEmojis: true,
  ),
  level: LoggerUtil.logLevel(),
);
