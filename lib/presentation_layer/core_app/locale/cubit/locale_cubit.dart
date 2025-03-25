import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleCubit extends Cubit<Locale> {
  final SharedPreferences prefs;
  static const String _localeKey = 'app_locale';
  static const Locale _defaultLocale = Locale('en');

  LocaleCubit(this.prefs) : super(_loadLocale(prefs));

  static Locale _loadLocale(SharedPreferences prefs) {
    final String? languageCode = prefs.getString(_localeKey);
    if (languageCode == null) {
      return _defaultLocale;
    }
    return Locale(languageCode);
  }

  Future<void> setLocale(Locale locale) async {
    await prefs.setString(_localeKey, locale.languageCode);
    emit(locale);
  }

  Future<void> resetToDefault() async {
    await prefs.remove(_localeKey);
    emit(_defaultLocale);
  }

  bool isCurrentLocale(String languageCode) {
    return state.languageCode == languageCode;
  }
}
