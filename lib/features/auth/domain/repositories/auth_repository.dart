import '../entities/auth_token.dart';
import '../entities/forgot_password_result.dart';

abstract class AuthRepository {
  Future<AuthToken> login({required String email, required String password});

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  });

  Future<ForgotPasswordResult> forgotPassword({required String email});

  Future<void> verifyResetCode({required String email, required String code});

  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  });

  Future<void> logout();

  Future<String?> getSavedToken();
}
