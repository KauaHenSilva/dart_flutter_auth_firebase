import 'package:dart_flutter_auth_firebase/routes/home_page.dart';
import 'package:dart_flutter_auth_firebase/routes/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return snapshot.hasData ? const HomePage() : const LoginPage();
        },
      ),
    );
  }
}
