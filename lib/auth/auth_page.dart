import 'package:dart_flutter_auth_firebase/auth/login_page.dart';
import 'package:dart_flutter_auth_firebase/auth/register_page.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _showLoginPage = true;

  void togleView() {
    setState(() {
      _showLoginPage = !_showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showLoginPage
        ? LoginPage(onSignUp: togleView)
        : RegisterPage(onSignIn: togleView);
  }
}
