import 'package:equatable/equatable.dart';

class SignupState extends Equatable {
  const SignupState({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.hourRate = '',
    this.isSubmitting = false,
    this.serverInvalid = false,
  });

  final String name;
  final String email;
  final String password;
  final String confirmPassword;
  final String hourRate;

  final bool isSubmitting;
  final bool serverInvalid;

  SignupState copyWith({
    String? name,
    String? email,
    String? password,
    String? confirmPassword,
    String? hourRate,
    bool? isSubmitting,
    bool? serverInvalid,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      hourRate: hourRate ?? this.hourRate,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      serverInvalid: serverInvalid ?? this.serverInvalid,
    );
  }

  @override
  List<Object?> get props => [
    name,
    email,
    password,
    confirmPassword,
    hourRate,
    isSubmitting,
    serverInvalid,
  ];
}
