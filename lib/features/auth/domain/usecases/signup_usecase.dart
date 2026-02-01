import '../repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repo;
  SignupUseCase(this.repo);

  Future<void> call({
    required String name,
    required String email,
    required String password,
  }) {
    return repo.signup(name: name, email: email, password: password);
  }
}
