import 'package:dart_flutter_auth_firebase/models/auth.dart';
import 'package:dart_flutter_auth_firebase/widgets/my_elevation_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    void singOut() {
      final providerAuth = Provider.of<Auth>(context, listen: false);
      providerAuth.signOut();
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Logged in!"),
            MyElevationButton(
              onPressed: singOut,
              text: "Sign out",
            )
          ],
        ),
      ),
    );
  }
}
