import 'package:base_project_bloc/data_layer/local_data/session_cache.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Key {
  static const String token = 'token';
  static const String userId = 'userId';
  static const String locale = 'locale';
}

class LocalStoreService {
  static final LocalStoreService _instance = LocalStoreService._internal();

  factory LocalStoreService() {
    return _instance;
  }
  LocalStoreService._internal();

  Future<void> cacheTokenAuth({
    required String token,
    required int userId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Key.token, token);
    await prefs.setInt(Key.userId, userId);
  }

  Future<void> cacheLocale({required String locale}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Key.locale, locale);
  }

  Future<String?> getLocale() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(Key.locale);
  }

  Future<String?> getTokenAuth() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(Key.token);
  }

  Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getInt(Key.userId);
  }

  Future<bool> clearTokenAuth() async {
    final prefs = await SharedPreferences.getInstance();
    SessionCache.token = null;
    SessionCache.userId = null;
    await prefs.remove(Key.userId);

    return prefs.remove(Key.token);
  }
}
