import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/services/local/shared_pref_service.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc({required int total})
      : super(OnboardingState(index: 0, total: total)) {
    on<OnboardingStarted>((event, emit) {
      emit(OnboardingState(index: 0, total: state.total));
    });

    on<OnboardingNextPressed>((event, emit) {
      if (state.index < state.total - 1) {
        emit(state.copyWith(index: state.index + 1));
      }
    });

    on<OnboardingDotTapped>((event, emit) {
      if (event.index >= 0 && event.index < state.total) {
        emit(state.copyWith(index: event.index));
      }
    });

    on<OnboardingFinishPressed>((event, emit) async {
      await sl<SharedPrefService>().setSeenOnboarding();
      emit(state.copyWith(finished: true));
    });
  }
}
