import 'package:dart_flutter_auth_firebase/models/auth.dart';
import 'package:dart_flutter_auth_firebase/models/firestore_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<void> tesk;
  late FirestoreDatabase pFireData;
  late Auth providerAuth;

  @override
  void initState() {
    super.initState();
    pFireData = Provider.of<FirestoreDatabase>(context, listen: false);
    providerAuth = Provider.of<Auth>(context, listen: false);
    tesk = pFireData.getUsers();
  }

  @override
  Widget build(BuildContext context) {
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
              setState(() {
                tesk = pFireData.getUsers();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Center(
        child: Consumer<FirestoreDatabase>(
          builder: (context, consumerFireData, child) {
            return FutureBuilder(
              future: tesk,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: consumerFireData.dataUserLen,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(consumerFireData.dataUserKeys[index]),
                            subtitle: Text(consumerFireData.dataUser[
                                consumerFireData.dataUserKeys[index]]['email']),
                          );
                        },
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
            );
          },
        ),
      ),
    );
  }
}
