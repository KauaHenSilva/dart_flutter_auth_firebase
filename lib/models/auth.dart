import 'package:dart_flutter_auth_firebase/exeptions/exeptions_auth.dart';
import 'package:dart_flutter_auth_firebase/widgets/my_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  Future<void> signUp(String email, String password, BuildContext ctx) async {
    final auth = FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    showDialogUserCredential(ctx, auth);
  }

  Future<void> signIn(String email, String password, BuildContext ctx) async {
    final auth = FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    showDialogUserCredential(ctx, auth);
  }

  Future<void> resetPassword(String email, BuildContext ctx) async {
    final auth = FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    return myShowDialogConfirm(ctx, auth);
  }

  void showDialogUserCredential(BuildContext ctx, Future<UserCredential> uC) {
    showDialog(
      context: ctx,
      builder: (context) {
        return FutureBuilder<UserCredential>(
          future: uC,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                final mensageError = ExeptionsAuth(error: snapshot.error);
                myShowDialogErrorAuth(context, mensageError).then(
                  (value) => Navigator.of(context).pop(),
                );
              }
            }
            Navigator.of(context).pop();
            return const SizedBox.shrink();
          },
        );
      },
    );
  }

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }
}
