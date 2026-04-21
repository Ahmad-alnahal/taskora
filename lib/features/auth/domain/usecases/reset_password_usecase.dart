import '../repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repo;
  ResetPasswordUseCase(this.repo);

  Future<void> call({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) {
    return repo.resetPassword(
      email: email,
      newPassword: newPassword,
      confirmPassword: confirmPassword,
    );
  }
}
