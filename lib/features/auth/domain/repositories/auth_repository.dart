import '../entities/auth_token.dart';

class ForgotPasswordResult {
  final String email;
  final String code; // training mode => "1234"
  final String message;
  const ForgotPasswordResult({
    required this.email,
    required this.code,
    required this.message,
  });
}

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
