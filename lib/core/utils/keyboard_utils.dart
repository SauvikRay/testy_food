import 'package:flutter/material.dart';

class KeyboardUtils {
  static void hideKyBoard([BuildContext? context]) {
    if (context != null && context.mounted) {
      FocusScope.of(context).unfocus();
    }
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
