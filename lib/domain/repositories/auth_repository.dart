import '../entities/firebase_user.dart';

abstract class AuthRepository {
  Future<FirebaseUserEntity> signIn(String email, String password);
  Future<FirebaseUserEntity> signUp(String email, String password);
  Future<void> signOut();
}
