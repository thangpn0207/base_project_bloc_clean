import 'package:flutter/foundation.dart';
import 'package:base_project_bloc/core/utils/log_util.dart';

/// Debug configuration class for controlling debug features
class DebugConfig {
  /// Whether the app is running in debug mode
  static final bool isDebugMode = kDebugMode;

  /// Whether to show debug logs
  static bool get showLogs => LoggerUtil.shouldShowLogs;

  /// Setup debug configurations
  static void init() {
    if (isDebugMode) {
      LoggerUtil.setLoggingEnabled(true);
      logUtil
        ..debug('Debug mode enabled')
        ..debug('Logging initialized in ${LoggerUtil.currentBuildMode} mode');
    } else {
      // In release mode, ensure logs are disabled
      LoggerUtil.setLoggingEnabled(false);
    }
  }

  /// Dynamically enable or disable logging at runtime (useful for debug UI)
  static void toggleLogging(bool enabled) {
    LoggerUtil.setLoggingEnabled(enabled);
    if (enabled && isDebugMode) {
      logUtil.debug('Logging enabled');
    }
  }

  /// Dump basic app debug information
  static void logAppInfo() {
    if (!showLogs) return;

    logUtil.debug('======= APP DEBUG INFO =======');
    logUtil.debug('Build Mode: ${LoggerUtil.currentBuildMode}');
    logUtil.debug('Debug Mode: $isDebugMode');
    logUtil.debug('Logging Enabled: $showLogs');
    logUtil.debug('==============================');
  }
}
