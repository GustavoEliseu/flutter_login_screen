import 'package:flutter/material.dart';

extension SimpleSnackbar on ScaffoldMessengerState {
  void snackBar(String text,
      {SnackBarAction? click, bool? addClose, Duration? duration}) {
    SnackBarAction? action = click;
    action ??= addClose == true ? _hideSnackBar() : null;
    showSnackBar(SnackBar(
        content: Text(text),
        action: action,
        duration: duration ?? const Duration(milliseconds: 1000)));
  }

  SnackBarAction _hideSnackBar() {
    return SnackBarAction(label: "Close", onPressed: hideCurrentSnackBar);
  }
}
