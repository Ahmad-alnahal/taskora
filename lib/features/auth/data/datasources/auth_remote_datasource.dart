class AuthRemoteDataSource {
  Future<String> login(String email, String password) async {
    // TODO: replace with real API call later
    await Future.delayed(const Duration(milliseconds: 500));
    return 'FAKE_TOKEN';
  }

  Future<void> signup(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<Map<String, dynamic>> forgotPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return {
      'message': 'Verification code sent',
      'code': '1234', // training mode fixed
    };
  }

  Future<void> verifyResetCode(String email, String code) async {
    await Future.delayed(const Duration(milliseconds: 400));
    if (code != '1234') throw Exception('Invalid code');
  }

  Future<void> resetPassword(String email, String pass, String confirm) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (pass != confirm) throw Exception('Passwords do not match');
  }
}
