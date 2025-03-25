import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:base_project_bloc/core/config/flavor/flavor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:base_project_bloc/core/utils/log_util.dart';

/// Environment types used throughout the app
enum EnvironmentType {
  development,
  staging,
  production,
}

/// Configuration class for managing environment settings
class Environment {
  static EnvironmentType _currentEnvironment = EnvironmentType.development;
  static String? _appName;
  static String? _baseUrl;
  static const bool _analyticsEnabled = false;
  static bool _isDebugMode = false;
  static bool _isLoggingEnabled = false;

  // Private constructor to prevent instantiation
  Environment._();

  /// Get current environment type
  static EnvironmentType get currentEnvironment => _currentEnvironment;

  /// Get whether this is a development environment
  static bool get isDevelopment =>
      _currentEnvironment == EnvironmentType.development;

  /// Get whether this is a staging environment
  static bool get isStaging => _currentEnvironment == EnvironmentType.staging;

  /// Get whether this is a production environment
  static bool get isProduction =>
      _currentEnvironment == EnvironmentType.production;

  /// Get app name from environment
  static String get appName => _appName ?? '';

  /// Get base URL from environment
  static String get baseUrl => _baseUrl ?? '';

  /// Get API key from environment
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  /// Get whether analytics is enabled
  static bool get analyticsEnabled => _analyticsEnabled;

  /// Get whether debug mode is enabled
  static bool get isDebugMode => _isDebugMode;

  /// Get whether logging is enabled
  static bool get isLoggingEnabled => _isLoggingEnabled;

  /// Initialize environment configuration
  static Future<void> initialize({EnvironmentType? env}) async {
    // If environment is explicitly provided, use it
    if (env != null) {
      _currentEnvironment = env;
    } else {
      // Default to development in debug mode, production in release mode
      _currentEnvironment =
          kDebugMode ? EnvironmentType.development : EnvironmentType.production;
    }

    // Load the appropriate .env file
    await _loadEnvFile();

    // Set native flavor if on mobile platforms
    if (!kIsWeb) {
      _setNativeFlavor();
    }

    // Log environment info in debug mode
    if (kDebugMode) {
      _printEnvironmentInfo();
    }
  }

  /// Load the appropriate .env file
  static Future<void> _loadEnvFile() async {
    final envFileName = _getEnvFileName();
    try {
      await dotenv.load(fileName: envFileName);
      _parseEnvFile();
      LogUtil.i('Loaded environment file: $envFileName', tag: 'Environment');
    } catch (e) {
      LogUtil.e(
        'Failed to load environment file: $envFileName',
        tag: 'Environment',
        error: e,
      );
      rethrow;
    }
  }

  /// Set native flavor for iOS/Android
  static void _setNativeFlavor() {
    if (isDebugMode) {
      FlavorConfig.setFlavor(FlavorType.dev);
    } else if (isLoggingEnabled) {
      FlavorConfig.setFlavor(FlavorType.stag);
    } else {
      FlavorConfig.setFlavor(FlavorType.prod);
    }
  }

  /// Log environment information in debug mode
  static void _printEnvironmentInfo() {
    LogUtil.i('=========== ENVIRONMENT INFO ===========', tag: 'Environment');
    LogUtil.i('Environment: $_currentEnvironment', tag: 'Environment');
    LogUtil.i('App Name: $appName', tag: 'Environment');
    LogUtil.i('Base URL: $baseUrl', tag: 'Environment');
    LogUtil.i('Analytics Enabled: $analyticsEnabled', tag: 'Environment');
    LogUtil.i('Debug Mode Enabled: $isDebugMode', tag: 'Environment');
    LogUtil.i('Logging Enabled: $isLoggingEnabled', tag: 'Environment');
    LogUtil.i('=======================================', tag: 'Environment');
  }

  static String _getEnvFileName() {
    switch (_currentEnvironment) {
      case EnvironmentType.development:
        return '.env.development';
      case EnvironmentType.staging:
        return '.env.staging';
      case EnvironmentType.production:
        return '.env.production';
    }
  }

  static void _parseEnvFile() {
    _appName = dotenv.env['APP_NAME'];
    _baseUrl = dotenv.env['BASE_URL'];
    _isDebugMode = dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';
    _isLoggingEnabled = dotenv.env['LOGGING_ENABLED']?.toLowerCase() == 'true';
  }

  /// Reset all environment settings
  static void reset() {
    _baseUrl = null;
    _appName = null;
    _isDebugMode = false;
    _isLoggingEnabled = false;
  }
}
