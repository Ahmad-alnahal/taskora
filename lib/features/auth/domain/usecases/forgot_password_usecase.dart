import '../repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository repo;
  ForgotPasswordUseCase(this.repo);

  Future<ForgotPasswordResult> call({required String email}) {
    return repo.forgotPassword(email: email);
  }
}
  