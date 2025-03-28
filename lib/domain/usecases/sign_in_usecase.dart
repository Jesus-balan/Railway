import '../repositories/auth_repository.dart';
import '../entities/firebase_user.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<FirebaseUserEntity> call(String email, String password) {
    return repository.signIn(email, password);
  }
}
