import 'package:base_project_bloc/core/locale/generated/l10n.dart';
import 'package:base_project_bloc/presentation_layer/core_app/locale/cubit/locale_cubit.dart';
import 'package:base_project_bloc/presentation_layer/theme/cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).homeScreenTitle),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThemeSettings(context),
            const SizedBox(height: 24),
            _buildLanguageSettings(context),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSettings(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).themeSettings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            BlocBuilder<ThemeCubit, ThemeMode>(
              builder: (context, themeMode) {
                return Column(
                  children: [
                    _buildThemeOption(
                      context,
                      title: S.of(context).lightTheme,
                      icon: Icons.light_mode,
                      isSelected: themeMode == ThemeMode.light,
                      onTap: () => themeCubit.setTheme(ThemeMode.light),
                    ),
                    const Divider(),
                    _buildThemeOption(
                      context,
                      title: S.of(context).darkTheme,
                      icon: Icons.dark_mode,
                      isSelected: themeMode == ThemeMode.dark,
                      onTap: () => themeCubit.setTheme(ThemeMode.dark),
                    ),
                    const Divider(),
                    _buildThemeOption(
                      context,
                      title: S.of(context).systemTheme,
                      icon: Icons.brightness_auto,
                      isSelected: themeMode == ThemeMode.system,
                      onTap: () => themeCubit.setTheme(ThemeMode.system),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSettings(BuildContext context) {
    final localeCubit = context.read<LocaleCubit>();

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).languageSettings,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            BlocBuilder<LocaleCubit, Locale>(
              builder: (context, currentLocale) {
                return Column(
                  children: [
                    _buildLanguageOption(
                      context,
                      title: S.of(context).english,
                      languageCode: 'en',
                      icon: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
                      isSelected: currentLocale.languageCode == 'en',
                      onTap: () => localeCubit.setLocale(const Locale('en')),
                    ),
                    const Divider(),
                    _buildLanguageOption(
                      context,
                      title: S.of(context).vietnamese,
                      languageCode: 'vi',
                      icon: const Text('🇻🇳', style: TextStyle(fontSize: 24)),
                      isSelected: currentLocale.languageCode == 'vi',
                      onTap: () => localeCubit.setLocale(const Locale('vi')),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      trailing:
          isSelected ? const Icon(Icons.check, color: Colors.green) : null,
      onTap: onTap,
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String title,
    required String languageCode,
    required Widget icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return ListTile(
      title: Text(title),
      leading: icon,
      trailing:
          isSelected ? const Icon(Icons.check, color: Colors.green) : null,
      onTap: onTap,
    );
  }
}
