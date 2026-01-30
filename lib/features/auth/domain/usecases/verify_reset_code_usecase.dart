import '../repositories/auth_repository.dart';

class VerifyResetCodeUseCase {
  final AuthRepository repo;
  VerifyResetCodeUseCase(this.repo);

  Future<void> call({required String email, required String code}) {
    return repo.verifyResetCode(email: email, code: code);
  }
}
