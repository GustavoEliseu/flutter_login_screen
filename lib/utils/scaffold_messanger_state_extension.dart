import 'package:flutter/material.dart';

extension SimpleSnackbar on ScaffoldMessengerState {
  void snackBar(String text, SnackBarAction? click) {
    showSnackBar(SnackBar(
      content: Text(text),
      action: click,
    ));
  }
}
