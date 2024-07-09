import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_flutter_auth_firebase/models/user_model.dart';
import 'package:flutter/material.dart';

class FirestoreDatabase extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<DocumentReference<Map<String, dynamic>>> addUser(
    UserModel user,
    BuildContext ctx,
  ) async {
    return _firestore.collection('users').add(user.toJson());
  }

  Future<UserModel> getUser(String id) async {
    final data = await _firestore.collection('users').doc(id).get();
    return UserModel.fromJson(data.data()!);
  }
}
