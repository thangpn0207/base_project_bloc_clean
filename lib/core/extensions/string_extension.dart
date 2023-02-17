import 'dart:core';

extension StringNullableExt on String? {
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }
}

extension StringExt on String {
  bool isValidEmail() {
    return RegExp(
      r"^[a-zA-Z0-9.]+@[a-zA-Z0-9-]+\.[a-zA-Z]+",
    ).hasMatch(this);
  }
}

extension StringToInt on String? {
  int tryParseDynamicToInt() {
    try {
      if (this != null) {
        return int.tryParse(this!) ?? -1;
      }
      return -1;
    } catch (e) {
      return -1;
    }
  }
}
