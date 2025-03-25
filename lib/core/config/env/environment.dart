import 'package:flutter/foundation.dart';
import 'package:base_project_bloc/core/config/flavor/flavor.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment types used throughout the app
enum EnvironmentType {
  development,
  staging,
  production,
}

/// Environment configuration that works across all platforms including web
class Environment {
  // Private constructor to prevent instantiation
  Environment._();

  /// Current environment
  static late EnvironmentType _currentEnvironment;

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
  static String get appName => dotenv.env['APP_NAME'] ?? 'Base Project';

  /// Get base URL from environment
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';

  /// Get API key from environment
  static String get apiKey => dotenv.env['API_KEY'] ?? '';

  /// Get whether analytics is enabled
  static bool get analyticsEnabled =>
      dotenv.env['ENABLE_ANALYTICS']?.toLowerCase() == 'true';

  /// Get whether debug mode is enabled
  static bool get debugModeEnabled =>
      dotenv.env['DEBUG_MODE']?.toLowerCase() == 'true';

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
      _logEnvironmentInfo();
    }
  }

  /// Load the appropriate .env file
  static Future<void> _loadEnvFile() async {
    String envFileName;

    switch (_currentEnvironment) {
      case EnvironmentType.development:
        envFileName = '.env.development';
        break;
      case EnvironmentType.staging:
        envFileName = '.env.staging';
        break;
      case EnvironmentType.production:
        envFileName = '.env.production';
        break;
    }

    try {
      await dotenv.load(fileName: envFileName);
      if (kDebugMode) {
        print('Loaded environment file: $envFileName');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to load environment file: $envFileName');
        print('Error: $e');
      }
    }
  }

  /// Set native flavor for iOS/Android
  static void _setNativeFlavor() {
    switch (_currentEnvironment) {
      case EnvironmentType.development:
        setFlavor(FlavorType.dev);
        break;
      case EnvironmentType.staging:
        setFlavor(FlavorType.stag);
        break;
      case EnvironmentType.production:
        setFlavor(FlavorType.prod);
        break;
    }
  }

  /// Log environment information in debug mode
  static void _logEnvironmentInfo() {
    print('=========== ENVIRONMENT INFO ===========');
    print('Environment: $_currentEnvironment');
    print('App Name: ${appName}');
    print('Base URL: ${baseUrl}');
    print('Analytics Enabled: ${analyticsEnabled}');
    print('Debug Mode Enabled: ${debugModeEnabled}');
    print('=======================================');
  }
}
