import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get fileName {
    if (const String.fromEnvironment('FLAVOR') == 'development') {
      return '.env.development';
    } else if (const String.fromEnvironment('FLAVOR') == 'staging') {
      return '.env.staging';
    } else {
      return '.env.production';
    }
  }

  static String get appName => dotenv.env['APP_NAME'] ?? 'Base Project';
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
