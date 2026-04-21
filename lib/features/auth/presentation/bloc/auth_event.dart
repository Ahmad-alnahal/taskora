import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class AppStarted extends AuthEvent {}
class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  const LoginEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class SignupEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final double hourlyRate;
  const SignupEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.hourlyRate,
  });
  @override
  List<Object?> get props => [name, email, password, hourlyRate];
}

class LogoutEvent extends AuthEvent {}

class ForgotPasswordEvent extends AuthEvent {
  final String email;
  const ForgotPasswordEvent({required this.email});
  @override
  List<Object?> get props => [email];
}

class VerifyResetCodeEvent extends AuthEvent {
  final String email;
  final String code;
  const VerifyResetCodeEvent({required this.email, required this.code});
  @override
  List<Object?> get props => [email, code];
}

class ResetPasswordEvent extends AuthEvent {
  final String email;
  final String newPassword;
  final String confirmPassword;
  const ResetPasswordEvent({
    required this.email,
    required this.newPassword,
    required this.confirmPassword,
  });
  @override
  List<Object?> get props => [email, newPassword, confirmPassword];
}
class ClearAuthErrorsEvent extends AuthEvent {
  const ClearAuthErrorsEvent();
}

