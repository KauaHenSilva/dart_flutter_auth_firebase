import 'package:dart_flutter_auth_firebase/exeptions/exeptions_auth.dart';
import 'package:flutter/material.dart';

Future<void> myShowDialogErrorAuth(
    BuildContext context, ExeptionsAuth mensageError) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(mensageError.errorTitle),
        content: Text(mensageError.getErrorMessage),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Close"),
          ),
        ],
      );
    },
  );
}

void myShowDialog(BuildContext ctx, String title, String content) {
  showDialog(
    context: ctx,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Close"),
          ),
        ],
      );
    },
  );
}
