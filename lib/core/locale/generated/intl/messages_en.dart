// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(error) => "An error occurred: ${error}";

  static String m1(appName) => "Welcome to ${appName}!";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appTitle": MessageLookupByLibrary.simpleMessage("Base Project"),
        "cancelButton": MessageLookupByLibrary.simpleMessage("Cancel"),
        "connectionError":
            MessageLookupByLibrary.simpleMessage("Connection error occurred"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Dark Theme"),
        "deleteButton": MessageLookupByLibrary.simpleMessage("Delete"),
        "editButton": MessageLookupByLibrary.simpleMessage("Edit"),
        "english": MessageLookupByLibrary.simpleMessage("English"),
        "errorMessage": m0,
        "homeScreenTitle": MessageLookupByLibrary.simpleMessage("Home Screen"),
        "languageSettings":
            MessageLookupByLibrary.simpleMessage("Language Settings"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Light Theme"),
        "loadingMessage": MessageLookupByLibrary.simpleMessage("Loading..."),
        "networkError":
            MessageLookupByLibrary.simpleMessage("Network error occurred"),
        "noResultsFound":
            MessageLookupByLibrary.simpleMessage("No results found"),
        "retryButton": MessageLookupByLibrary.simpleMessage("Retry"),
        "saveButton": MessageLookupByLibrary.simpleMessage("Save"),
        "searchHint": MessageLookupByLibrary.simpleMessage("Search..."),
        "serverError":
            MessageLookupByLibrary.simpleMessage("Server error occurred"),
        "settingsLabel": MessageLookupByLibrary.simpleMessage("Settings"),
        "successMessage": MessageLookupByLibrary.simpleMessage(
            "Operation completed successfully"),
        "systemTheme": MessageLookupByLibrary.simpleMessage("System Theme"),
        "themeSettings": MessageLookupByLibrary.simpleMessage("Theme Settings"),
        "timeoutError":
            MessageLookupByLibrary.simpleMessage("Request timed out"),
        "vietnamese": MessageLookupByLibrary.simpleMessage("Vietnamese"),
        "welcomeMessage": m1
      };
}
