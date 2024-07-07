// ignore_for_file: invalid_return_type_for_catch_error, null_argument_to_non_null_type

import 'package:dart_flutter_auth_firebase/exeptions/exeptions_auth.dart';
import 'package:dart_flutter_auth_firebase/widgets/my_dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  void signUp(String email, String password, BuildContext ctx) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .onError((error, stackTrace) {
      final mensageError = ExeptionsAuth(error: error);
      myShowDialogErrorAuth(ctx, mensageError);
      return Future<UserCredential>.value(null);
    });
  }

  void signIn(String email, String password, BuildContext ctx) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      final mensageError = ExeptionsAuth(error: e);
      myShowDialogErrorAuth(ctx, mensageError);
      return null;
    });
  }

  Future<void> resetPassword(String email, BuildContext ctx) async {
    FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
      myShowDialog(ctx, "Success", "Check your email to reset your password");
    }).catchError((e) {
      final mensageError = ExeptionsAuth(error: e);
      myShowDialogErrorAuth(ctx, mensageError);
    });
  }

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }
}
