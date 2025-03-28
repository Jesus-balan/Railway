import '../repositories/auth_repository.dart';
import '../entities/firebase_user.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<FirebaseUserEntity> call(String email, String password) {
  return repository.signUp(email, password); // ✅ Correct method
}
}
