import 'package:base_project_bloc/core/utils/log_util.dart';

/// Enum representing different app flavors/environments
enum FlavorType { dev, stag, prod }

/// Class containing flavor-specific values
class FlavorValues {
  const FlavorValues({
    required this.baseUrl,
    // Add other flavor specific values here
  });

  final String baseUrl;
}

/// Configuration class for managing app flavors
class FlavorConfig {
  static FlavorType flavor = FlavorType.dev;
  static String name = 'dev';
  static FlavorValues values = const FlavorValues(
    baseUrl: 'https://dev-api.example.com',
  );

  /// Check if current flavor is production
  static bool isProduction() => flavor == FlavorType.prod;

  /// Check if current flavor is development
  static bool isDevelopment() => flavor == FlavorType.dev;

  /// Check if current flavor is staging
  static bool isStaging() => flavor == FlavorType.stag;

  /// Set the flavor to development
  static void setFlavorDevelopment(String? baseUrl) {
    LogUtil.i('setFlavorDevelopment env', tag: 'FlavorConfig');
    flavor = FlavorType.dev;
    name = 'dev';
    values = FlavorValues(
      baseUrl: baseUrl ?? 'https://dev-api.example.com',
    );
  }

  /// Set the flavor to staging
  static void setFlavorStaging(String? baseUrl) {
    LogUtil.i('setFlavorStaging env', tag: 'FlavorConfig');
    flavor = FlavorType.stag;
    name = 'stg';
    values = FlavorValues(
      baseUrl: baseUrl ?? 'https://staging-api.example.com',
    );
  }

  /// Set the flavor to production
  static void setFlavorProduction(String? baseUrl) {
    LogUtil.i('setFlavorProduction env', tag: 'FlavorConfig');
    flavor = FlavorType.prod;
    name = 'prod';
    values = FlavorValues(
      baseUrl: baseUrl ?? 'https://api.example.com',
    );
  }

  /// Set the flavor based on the provided type
  static void setFlavor(FlavorType flavor, {String? overrideBaseUrl}) {
    switch (flavor) {
      case FlavorType.dev:
        setFlavorDevelopment(overrideBaseUrl);
        break;
      case FlavorType.stag:
        setFlavorStaging(overrideBaseUrl);
        break;
      case FlavorType.prod:
        setFlavorProduction(overrideBaseUrl);
        break;
    }
  }
}
