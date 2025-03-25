import 'package:base_project_bloc/core/utils/log_util.dart';

enum FlavorType { dev, stag, prod }

class FlavorValues {
  const FlavorValues({
    required this.baseUrl,
    // Add other flavor specific values here
  });

  final String baseUrl;

  // Removing this method since FlavorConfig.flavor should be used directly
  // and to avoid circular dependency issues
}

class FlavorConfig {
  static FlavorType flavor = FlavorType.dev;
  static String name = '';
  static FlavorValues values = const FlavorValues(
    baseUrl: '',
  );

  static bool isProduction() => flavor == FlavorType.prod;

  static bool isDevelopment() => flavor == FlavorType.dev;

  static bool isStaging() => flavor == FlavorType.stag;
}

void setFlavorDevelopment(String? baseUrl) {
  logUtil.i('setFlavorDevelopment env');
  FlavorConfig.flavor = FlavorType.dev;
  FlavorConfig.name = 'dev';
  FlavorConfig.values = FlavorValues(
    baseUrl: baseUrl ?? "",
  );
}

void setFlavorStaging(String? baseUrl) {
  FlavorConfig.flavor = FlavorType.stag;
  FlavorConfig.name = 'stg';
  FlavorConfig.values = FlavorValues(
    baseUrl: baseUrl ?? "",
  );
}

void setFlavorProduction(String? baseUrl) {
  logUtil.i('setFlavorProduction env');
  FlavorConfig.flavor = FlavorType.prod;
  FlavorConfig.name = 'prod';
  FlavorConfig.values = FlavorValues(
    baseUrl: baseUrl ?? "",
  );
}

void setFlavor(FlavorType flavor, {String? overrideBaseUrl}) {
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
    // Removed default case since all enum values are covered
  }
}
