import 'package:dart_flutter_auth_firebase/exeptions/exeptions_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  Future<void> signUp(
    String email,
    String password,
    BuildContext ctx,
  ) async {
    final auth = FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    showDialogUserCredential(ctx, auth);
  }

  Future<void> signIn(
    String email,
    String password,
    BuildContext ctx,
  ) async {
    final auth = FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    showDialogUserCredential(ctx, auth);
  }

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  void showDialogUserCredential(
    BuildContext ctx,
    Future<UserCredential> userCredential,
  ) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FutureBuilder<UserCredential>(
          future: userCredential,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                final mensageError = ExeptionsAuth(error: snapshot.error);
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
              }
              Navigator.of(context).pop();
            }
            return const SizedBox.shrink();
          },
        );
      },
    );
  }
}
