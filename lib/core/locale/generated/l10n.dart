// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Base Project`
  String get appTitle {
    return Intl.message(
      'Base Project',
      name: 'appTitle',
      desc: 'The title of the application',
      args: [],
    );
  }

  /// `Home Screen`
  String get homeScreenTitle {
    return Intl.message(
      'Home Screen',
      name: 'homeScreenTitle',
      desc: 'Title for the home screen',
      args: [],
    );
  }

  /// `Theme Settings`
  String get themeSettings {
    return Intl.message(
      'Theme Settings',
      name: 'themeSettings',
      desc: 'Title for theme settings section',
      args: [],
    );
  }

  /// `Light Theme`
  String get lightTheme {
    return Intl.message(
      'Light Theme',
      name: 'lightTheme',
      desc: 'Light theme option',
      args: [],
    );
  }

  /// `Dark Theme`
  String get darkTheme {
    return Intl.message(
      'Dark Theme',
      name: 'darkTheme',
      desc: 'Dark theme option',
      args: [],
    );
  }

  /// `System Theme`
  String get systemTheme {
    return Intl.message(
      'System Theme',
      name: 'systemTheme',
      desc: 'System theme option',
      args: [],
    );
  }

  /// `Language Settings`
  String get languageSettings {
    return Intl.message(
      'Language Settings',
      name: 'languageSettings',
      desc: 'Title for language settings section',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: 'English language option',
      args: [],
    );
  }

  /// `Vietnamese`
  String get vietnamese {
    return Intl.message(
      'Vietnamese',
      name: 'vietnamese',
      desc: 'Vietnamese language option',
      args: [],
    );
  }

  /// `Settings`
  String get settingsLabel {
    return Intl.message(
      'Settings',
      name: 'settingsLabel',
      desc: 'Label for settings',
      args: [],
    );
  }

  /// `Welcome to {appName}!`
  String welcomeMessage(String appName) {
    return Intl.message(
      'Welcome to $appName!',
      name: 'welcomeMessage',
      desc: 'Welcome message with app name',
      args: [appName],
    );
  }

  /// `An error occurred: {error}`
  String errorMessage(String error) {
    return Intl.message(
      'An error occurred: $error',
      name: 'errorMessage',
      desc: 'Error message with error details',
      args: [error],
    );
  }

  /// `Operation completed successfully`
  String get successMessage {
    return Intl.message(
      'Operation completed successfully',
      name: 'successMessage',
      desc: 'Success message',
      args: [],
    );
  }

  /// `Loading...`
  String get loadingMessage {
    return Intl.message(
      'Loading...',
      name: 'loadingMessage',
      desc: 'Loading message',
      args: [],
    );
  }

  /// `Retry`
  String get retryButton {
    return Intl.message(
      'Retry',
      name: 'retryButton',
      desc: 'Retry button text',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelButton {
    return Intl.message(
      'Cancel',
      name: 'cancelButton',
      desc: 'Cancel button text',
      args: [],
    );
  }

  /// `Save`
  String get saveButton {
    return Intl.message(
      'Save',
      name: 'saveButton',
      desc: 'Save button text',
      args: [],
    );
  }

  /// `Delete`
  String get deleteButton {
    return Intl.message(
      'Delete',
      name: 'deleteButton',
      desc: 'Delete button text',
      args: [],
    );
  }

  /// `Edit`
  String get editButton {
    return Intl.message(
      'Edit',
      name: 'editButton',
      desc: 'Edit button text',
      args: [],
    );
  }

  /// `Search...`
  String get searchHint {
    return Intl.message(
      'Search...',
      name: 'searchHint',
      desc: 'Search field hint text',
      args: [],
    );
  }

  /// `No results found`
  String get noResultsFound {
    return Intl.message(
      'No results found',
      name: 'noResultsFound',
      desc: 'Message shown when no search results are found',
      args: [],
    );
  }

  /// `Network error occurred`
  String get networkError {
    return Intl.message(
      'Network error occurred',
      name: 'networkError',
      desc: 'Message shown when a network error occurs',
      args: [],
    );
  }

  /// `Server error occurred`
  String get serverError {
    return Intl.message(
      'Server error occurred',
      name: 'serverError',
      desc: 'Message shown when a server error occurs',
      args: [],
    );
  }

  /// `Connection error occurred`
  String get connectionError {
    return Intl.message(
      'Connection error occurred',
      name: 'connectionError',
      desc: 'Message shown when a connection error occurs',
      args: [],
    );
  }

  /// `Request timed out`
  String get timeoutError {
    return Intl.message(
      'Request timed out',
      name: 'timeoutError',
      desc: 'Message shown when a request times out',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
