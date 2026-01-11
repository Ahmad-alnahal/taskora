import 'package:equatable/equatable.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.password = '',
    this.isSubmitting = false,
    this.serverInvalid = false,
  });

  final String email;
  final String password;
  final bool isSubmitting;
  final bool serverInvalid;
  LoginState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    bool? serverInvalid,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      serverInvalid: serverInvalid ?? this.serverInvalid,
    );
  }

  @override
  List<Object?> get props => [email, password, isSubmitting,serverInvalid];
}
