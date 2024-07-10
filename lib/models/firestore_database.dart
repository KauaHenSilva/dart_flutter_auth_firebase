import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_flutter_auth_firebase/models/user_model.dart';
import 'package:flutter/material.dart';

class FirestoreDatabase extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Map<String, dynamic> _dataUser = {};
  bool _isLoading = false;

  Map<String, dynamic> get dataUser => _dataUser;
  List<String> get dataUserKeys => _dataUser.keys.toList();

  int get dataUserLen => _dataUser.length;
  bool get isLoading => _isLoading;

  Future<DocumentReference<Map<String, dynamic>>> addUser(
    UserModel user,
    BuildContext ctx,
  ) async {
    return _firestore.collection('users').add(user.toJson());
  }

  void getUsers() async {
    _isLoading = true;
    notifyListeners();

    _dataUser.clear();
    final snapshot = await _firestore.collection('users').get();
    for (final doc in snapshot.docs) {
      _dataUser[doc.id] = doc.data();
    }

    _isLoading = false;
    notifyListeners();
  }

  void printDebug() {
    debugPrint(_dataUser.toString());
  }
}
