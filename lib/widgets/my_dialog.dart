import 'package:dart_flutter_auth_firebase/exeptions/exceptions_auth.dart';
import 'package:dart_flutter_auth_firebase/widgets/my_elevated_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDialog {
  final Future<void> future;
  final BuildContext context;
  final bool showSuccessDialog;
  final String titleSuccess;
  final String messageSuccess;

  MyDialog({
    required this.future,
    required this.context,
    this.showSuccessDialog = false,
    this.titleSuccess = "Success",
    this.messageSuccess = "Operation successful!",
  });

  Future<void> show() {
    return showDialog(
      context: context,
      useSafeArea: true,
      barrierDismissible: false,
      builder: (context) => FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const DialogLoading();
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              String errorTitle = "An unknown error occurred.";
              String errorMessage = snapshot.error.toString();

              if (snapshot.error is FirebaseAuthException) {
                final error = ExceptionsAuth(error: snapshot.error);
                errorTitle = error.getErrorTitle;
                errorMessage = error.getErrorMessage;
              } else {
                errorMessage = snapshot.error.toString();
              }

              return DialogError(
                errorTitle: errorTitle,
                errorMessage: errorMessage,
              );
            } else if (showSuccessDialog) {
              return DialogSucess(
                titleSuccess: titleSuccess,
                messageSuccess: messageSuccess,
              );
            } else {
              Navigator.of(context).pop();
              return const SizedBox.shrink();
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class DialogSucess extends StatelessWidget {
  const DialogSucess({
    super.key,
    required this.titleSuccess,
    required this.messageSuccess,
  });

  final String titleSuccess;
  final String messageSuccess;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titleSuccess,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Text(messageSuccess),
            const SizedBox(height: 20),
            MyElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              text: 'Ok',
            ),
          ],
        ),
      ),
    );
  }
}

class DialogError extends StatelessWidget {
  const DialogError({
    super.key,
    required this.errorTitle,
    required this.errorMessage,
  });

  final String errorTitle;
  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              errorTitle,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium!
                  .copyWith(color: Colors.black87),
            ),
            const SizedBox(height: 10),
            Text(errorMessage),
            const SizedBox(height: 20),
            MyElevatedButton(
              text: "OK",
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class DialogLoading extends StatelessWidget {
  const DialogLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 20),
            Text("Loading..."),
          ],
        ),
      ),
    );
  }
}
