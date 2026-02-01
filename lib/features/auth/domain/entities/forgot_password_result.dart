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
