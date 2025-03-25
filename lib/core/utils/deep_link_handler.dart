import 'package:flutter/services.dart';
import 'package:base_project_bloc/presentation_layer/core_app/routes/app_router.dart';
import 'package:base_project_bloc/core/utils/log_util.dart';

class DeepLinkHandler {
  static const platform = MethodChannel('app/deep_link');

  static Future<void> handleDeepLink(String link) async {
    try {
      final uri = Uri.parse(link);

      // Navigate using GoRouter
      AppRouter.router.go(uri.path, extra: uri.queryParameters);
    } catch (e) {
      LogUtil.e('Deep link error: $e', tag: 'DeepLinkHandler');
    }
  }

  static Future<void> initDeepLinks() async {
    // Listen to platform messages
    platform.setMethodCallHandler((call) async {
      if (call.method == 'deepLink') {
        final String link = call.arguments as String;
        await handleDeepLink(link);
      }
    });
  }
}
