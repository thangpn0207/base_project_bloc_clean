import 'package:base_project_bloc/core/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late ThemeCubit themeCubit;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    themeCubit = ThemeCubit(mockSharedPreferences);
  });

  tearDown(() {
    themeCubit.close();
  });

  test('initial state should be system theme', () {
    when(mockSharedPreferences.getString('theme_mode')).thenReturn(null);
    expect(themeCubit.state, equals(ThemeMode.system));
  });

  group('setTheme', () {
    test('should emit dark theme when set to dark mode', () async {
      when(
        mockSharedPreferences.setString(
          'theme_mode',
          ThemeMode.dark.toString(),
        ),
      ).thenAnswer((_) async => true);

      await themeCubit.setTheme(ThemeMode.dark);
      expect(themeCubit.state, equals(ThemeMode.dark));
      verify(
        mockSharedPreferences.setString(
          'theme_mode',
          ThemeMode.dark.toString(),
        ),
      ).called(1);
    });

    test('should emit light theme when set to light mode', () async {
      when(
        mockSharedPreferences.setString(
          'theme_mode',
          ThemeMode.light.toString(),
        ),
      ).thenAnswer((_) async => true);

      await themeCubit.setTheme(ThemeMode.light);
      expect(themeCubit.state, equals(ThemeMode.light));
      verify(
        mockSharedPreferences.setString(
          'theme_mode',
          ThemeMode.light.toString(),
        ),
      ).called(1);
    });
  });

  group('theme getters', () {
    test('isDarkMode should return true when in dark mode', () async {
      await themeCubit.setTheme(ThemeMode.dark);
      expect(themeCubit.isDarkMode, isTrue);
    });

    test('isLightMode should return true when in light mode', () async {
      await themeCubit.setTheme(ThemeMode.light);
      expect(themeCubit.isLightMode, isTrue);
    });

    test('isSystemMode should return true when in system mode', () async {
      await themeCubit.setTheme(ThemeMode.system);
      expect(themeCubit.isSystemMode, isTrue);
    });
  });
}
