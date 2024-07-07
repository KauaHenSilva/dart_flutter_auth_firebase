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

Future<void> myShowDialogConfirm(BuildContext ctx, Future<void> future) {
  return future.then((value) {
    return showDialog(
      context: ctx,
      builder: (context) {
        return AlertDialog(
          title: const Text("Success"),
          content: const Text("Check your email to reset your password"),
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
  }).onError((error, stackTrace) {
    final mensageError = ExeptionsAuth(error: error);
    return myShowDialogErrorAuth(ctx, mensageError);
  });
}
