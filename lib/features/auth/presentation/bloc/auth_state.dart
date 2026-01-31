import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
  @override
  List<Object?> get props => [message];
}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {}

class SignupSuccess extends AuthState {}

class ResetCodeVerified extends AuthState {
  const ResetCodeVerified();
}

class ForgotPasswordCodeSent extends AuthState {
  final String email;
  final String code; // "1234"
  final String message;
  const ForgotPasswordCodeSent({
    required this.email,
    required this.code,
    required this.message,
  });
  @override
  List<Object?> get props => [email, code, message];
}

class ResetPasswordSuccess extends AuthState {}
