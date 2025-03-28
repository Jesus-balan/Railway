import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/firebase_user.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<FirebaseUserEntity> signIn(String email, String password) async {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return FirebaseUserEntity(
        uid: userCredential.user!.uid, email: userCredential.user!.email! ?? "no-email@domain.com");
  }

  @override
  Future<FirebaseUserEntity> signUp(String email, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return FirebaseUserEntity(
        uid: userCredential.user!.uid, email: userCredential.user!.email! ?? "no-email@domain.com");
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
