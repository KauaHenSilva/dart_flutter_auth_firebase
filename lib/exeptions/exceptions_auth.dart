import 'package:firebase_auth/firebase_auth.dart';

class ExceptionsAuth implements Exception {
  final Object? error;
  ExceptionsAuth({required this.error});

  String get getErrorMessage {
    if (error is FirebaseAuthException) {
      switch ((error as FirebaseAuthException).code) {
        case 'invalid-credential':
          return 'The credential is malformed or has expired.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-disabled':
          return 'The user corresponding to the given email has been disabled.';
        case 'user-not-found':
          return 'There is no user corresponding to the given email.';
        case 'wrong-password':
          return 'The password is invalid.';
        case 'email-already-in-use':
          return 'The email address is already in use by another account.';
        case 'operation-not-allowed':
          return 'Email/password accounts are not enabled.';
        case 'weak-password':
          return 'The password is too weak.';
        case 'too-many-requests':
          return 'There were too many requests from your device.';
        default:
          return 'An unknown error occurred.';
      }
    } else {
      return 'An unknown error occurred.';
    }
  }

  String get getErrorTitle {
    if (error is FirebaseAuthException) {
      switch ((error as FirebaseAuthException).code) {
        case 'invalid-credential':
          return 'Invalid credential';
        case 'invalid-email':
          return 'Invalid email';
        case 'user-disabled':
          return 'User disabled';
        case 'user-not-found':
          return 'User not found';
        case 'wrong-password':
          return 'Wrong password';
        case 'email-already-in-use':
          return 'Email already in use';
        case 'operation-not-allowed':
          return 'Operation not allowed';
        case 'weak-password':
          return 'Weak password';
        case 'too-many-requests':
          return 'Too many requests';
        default:
          return 'An unknown error occurred.';
      }
    } else {
      return 'An unknown error occurred.';
    }
  }
}
