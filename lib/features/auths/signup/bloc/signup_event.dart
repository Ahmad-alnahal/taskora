import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();
  @override
  List<Object?> get props => [];
}

class SignupNameChanged extends SignupEvent {
  const SignupNameChanged(this.name);
  final String name;
  @override
  List<Object?> get props => [name];
}

class SignupEmailChanged extends SignupEvent {
  const SignupEmailChanged(this.email);
  final String email;
  @override
  List<Object?> get props => [email];
}

class SignupPasswordChanged extends SignupEvent {
  const SignupPasswordChanged(this.password);
  final String password;
  @override
  List<Object?> get props => [password];
}

class SignupConfirmPasswordChanged extends SignupEvent {
  const SignupConfirmPasswordChanged(this.confirmPassword);
  final String confirmPassword;
  @override
  List<Object?> get props => [confirmPassword];
}

class SignupHourRateChanged extends SignupEvent {
  const SignupHourRateChanged(this.hourRate);
  final String hourRate;
  @override
  List<Object?> get props => [hourRate];
}

class SignupLoginTapped extends SignupEvent {
  const SignupLoginTapped();
}

class SignupSubmitted extends SignupEvent {
  const SignupSubmitted();
}
