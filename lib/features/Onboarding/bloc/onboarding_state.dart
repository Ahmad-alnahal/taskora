class OnboardingState {
  final int index;
  final int total;
  final bool finished;

  const OnboardingState({
    required this.index,
    required this.total,
    this.finished = false,
  });

  bool get isLast => index == total - 1;

  OnboardingState copyWith({int? index, bool? finished}) {
    return OnboardingState(
      index: index ?? this.index,
      total: total,
      finished: finished ?? this.finished,
    );
  }
}
