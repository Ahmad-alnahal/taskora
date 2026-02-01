class OnboardingEvent {
  const OnboardingEvent();
}

final class OnboardingStarted extends OnboardingEvent {
  const OnboardingStarted();
}

final class OnboardingNextPressed extends OnboardingEvent {
  const OnboardingNextPressed();
}

final class OnboardingDotTapped extends OnboardingEvent {
  final int index;
  const OnboardingDotTapped(this.index);
}

final class OnboardingFinishPressed extends OnboardingEvent {
  const OnboardingFinishPressed();
}
