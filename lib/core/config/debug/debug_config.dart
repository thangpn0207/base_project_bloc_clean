import 'package:flutter/foundation.dart';
import 'package:base_project_bloc/core/utils/log_util.dart';

/// Configuration class for debug settings
class DebugConfig {
  static bool _showLogs = false;
  static bool _showNetworkLogs = false;
  static bool _showBlocLogs = false;
  static bool _showRouteLogs = false;

  /// Check if logs should be shown
  static bool get showLogs => _showLogs;

  /// Check if network logs should be shown
  static bool get showNetworkLogs => _showNetworkLogs;

  /// Check if BLoC logs should be shown
  static bool get showBlocLogs => _showBlocLogs;

  /// Check if route logs should be shown
  static bool get showRouteLogs => _showRouteLogs;

  /// Initialize debug configuration
  static void init({
    bool showLogs = false,
    bool showNetworkLogs = false,
    bool showBlocLogs = false,
    bool showRouteLogs = false,
  }) {
    _showLogs = showLogs;
    _showNetworkLogs = showNetworkLogs;
    _showBlocLogs = showBlocLogs;
    _showRouteLogs = showRouteLogs;

    LogUtil.i(
      'Debug Configuration:\n'
      'Show Logs: $showLogs\n'
      'Show Network Logs: $showNetworkLogs\n'
      'Show BLoC Logs: $showBlocLogs\n'
      'Show Route Logs: $showRouteLogs',
      tag: 'DebugConfig',
    );
  }

  /// Reset all debug settings
  static void reset() {
    _showLogs = false;
    _showNetworkLogs = false;
    _showBlocLogs = false;
    _showRouteLogs = false;
  }
}
