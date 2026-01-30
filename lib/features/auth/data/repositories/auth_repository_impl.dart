import '../../domain/entities/auth_token.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({required this.remote, required this.local});
  final AuthRemoteDataSource remote;
  final AuthLocalDataSource local;

  @override
  Future<AuthToken> login({required String email, required String password}) async {
    final token = await remote.login(email, password);
    await local.saveToken(token);
    return AuthToken(token);
  }

  @override
  Future<void> signup({required String name, required String email, required String password}) {
    return remote.signup(name, email, password);
  }

  @override
  Future<ForgotPasswordResult> forgotPassword({required String email}) async {
    final res = await remote.forgotPassword(email);
    return ForgotPasswordResult(
      email: email,
      code: res['code'] as String,
      message: res['message'] as String,
    );
  }

  @override
  Future<void> verifyResetCode({required String email, required String code}) {
    return remote.verifyResetCode(email, code);
  }

  @override
  Future<void> resetPassword({
    required String email,
    required String newPassword,
    required String confirmPassword,
  }) {
    return remote.resetPassword(email, newPassword, confirmPassword);
  }

  @override
  Future<void> logout() => local.clearToken();

  @override
  Future<String?> getSavedToken() => local.getToken();
}
