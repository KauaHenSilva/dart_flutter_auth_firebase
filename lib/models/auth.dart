// ignore_for_file: invalid_return_type_for_catch_error, null_argument_to_non_null_type

import 'package:dart_flutter_auth_firebase/widgets/my_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth extends ChangeNotifier {
  User? get user => FirebaseAuth.instance.currentUser;

  Future<UserCredential> signUp(
      String email, String password, BuildContext ctx) async {
    final auth = FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return auth;
  }

  Future<void> signIn(String email, String password, BuildContext ctx) async {
    final auth = FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    MyDialog(context: ctx, future: auth).show();
    return Future.value(null);
  }

  Future<void> resetPassword(String email, BuildContext ctx) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  void signOut(BuildContext ctx) async {
    final auth = FirebaseAuth.instance.signOut();
    MyDialog(context: ctx, future: auth).show();
    await auth;
  }
}
