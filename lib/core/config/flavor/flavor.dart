import 'package:base_project_bloc/core/utils/log_util.dart';

enum FlavorType { dev, stag, pro }

class FlavorValues {
  FlavorValues({
    required this.baseImgGuideUrl,
    required this.fireBaseName,
    required this.baseUrl,
  });

  final String baseUrl;
  final String baseImgGuideUrl;
  final String fireBaseName;
//Add other flavor specific values, e.g database name
}

class FlavorConfig {
  static FlavorType flavor = FlavorType.dev;
  static String name = '';
  static FlavorValues values = FlavorValues(
    baseUrl: '',
    fireBaseName: '',
    baseImgGuideUrl: '',
  );

  static bool isProduction() => flavor == FlavorType.pro;

  static bool isDevelopment() => flavor == FlavorType.dev;

  static bool isStaging() => flavor == FlavorType.stag;
}

void setFlavorDevelopment(String? baseUrl) {
  logUtil.i('setFlavorDevelopment env');
  FlavorConfig.flavor = FlavorType.dev;
  FlavorConfig.name = 'dev';
  FlavorConfig.values = FlavorValues(
    baseUrl: baseUrl ?? "",
    fireBaseName: 'AirWater-Delivery',
    baseImgGuideUrl: "",
  );
}

void setFlavorStaging(String? baseUrl) {
  FlavorConfig.flavor = FlavorType.stag;
  FlavorConfig.name = 'stg';
  FlavorConfig.values = FlavorValues(
    baseUrl: baseUrl ?? "",
    fireBaseName: 'AirWater-Delivery-Staging',
    baseImgGuideUrl: "",
  );
}

void setFlavorProduction(String? baseUrl) {
  logUtil.i('setFlavorProduction env');
  FlavorConfig.flavor = FlavorType.pro;
  FlavorConfig.name = 'prod';
  FlavorConfig.values = FlavorValues(
    baseUrl: baseUrl ?? "",
    fireBaseName: '',
    baseImgGuideUrl: "",
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
    case FlavorType.pro:
      setFlavorProduction(overrideBaseUrl);
      break;
    default:
      break;
  }
}
