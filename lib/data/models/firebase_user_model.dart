import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserModel {
  final String uid;
  final String email;

  FirebaseUserModel({required this.uid, required this.email});

  factory FirebaseUserModel.fromFirebaseUser(User user) {
    return FirebaseUserModel(uid: user.uid, email: user.email ?? "");
  }
}
