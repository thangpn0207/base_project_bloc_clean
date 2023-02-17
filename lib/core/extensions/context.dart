import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  dynamic modalRouteSettingArguments() {
    return ModalRoute.of(this)?.settings.arguments;
  }

  T forceModalRouteSettingArguments<T>() {
    return ModalRoute.of(this)?.settings.arguments! as T;
  }
}
