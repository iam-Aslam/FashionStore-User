import 'package:flutter/material.dart';

void alertSnackbar(BuildContext context, String message) {
  final snackBar = SnackBar(
    backgroundColor: Colors.black,
    content: Text(message),
    action: SnackBarAction(
      textColor: Colors.black,
      backgroundColor: Colors.white,
      label: 'Dismiss',
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
