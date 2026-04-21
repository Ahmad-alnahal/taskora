import 'package:equatable/equatable.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object?> get props => [];
}

final class SplashInitial extends SplashState {
  const SplashInitial();
}

final class SplashNavigateToOnboarding extends SplashState {
  const SplashNavigateToOnboarding();
}

final class SplashNavigateToLogin extends SplashState {
  const SplashNavigateToLogin();
}

final class SplashNavigateToHome extends SplashState {
  const SplashNavigateToHome();
}
