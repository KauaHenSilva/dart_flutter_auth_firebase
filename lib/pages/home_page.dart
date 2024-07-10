import 'package:dart_flutter_auth_firebase/models/auth.dart';
import 'package:dart_flutter_auth_firebase/models/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final pFireData = Provider.of<FirestoreDatabase>(context, listen: false);
    final providerAuth = Provider.of<Auth>(context, listen: false);

    Future.microtask(() {
      pFireData.getUsers();
    });

    void signOut() {
      providerAuth.signOut(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: Consumer<Auth>(
          builder: (context, consumerAuth, child) {
            return Text(consumerAuth.user!.email.toString());
          },
        ),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.exit_to_app),
          ),
          IconButton(
            onPressed: () {
              pFireData.getUsers();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Consumer<FirestoreDatabase>(
          builder: (context, consumerFireData, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (consumerFireData.isLoading) const LinearProgressIndicator(),
                Expanded(
                  child: ListView.builder(
                    itemCount: consumerFireData.dataUserLen,
                    itemBuilder: (context, index) {
                      final userKey = consumerFireData.dataUserKeys[index];
                      final user = consumerFireData.dataUser[userKey];
                      return ListTile(
                        title: Text("${user['fistName']} ${user['lastName']}"),
                        subtitle: Text(user['email'].toString()),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
