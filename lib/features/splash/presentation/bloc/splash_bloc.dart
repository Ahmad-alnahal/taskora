import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora/core/services/local/shared_pref_service.dart';
import 'package:taskora/features/auth/domain/usecases/get_saved_token_usecase.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({
    required SharedPrefService sharedPrefService,
    required GetSavedTokenUseCase getSavedToken,
  })  : _sharedPrefService = sharedPrefService,
        _getSavedToken = getSavedToken,
        super(const SplashInitial()) {
    on<SplashStarted>(_onStarted);
  }

  final SharedPrefService _sharedPrefService;
  final GetSavedTokenUseCase _getSavedToken;

  /// Decision tree:
  /// 1. Wait 3 seconds (splash display).
  /// 2. First time? → OnboardingScreen.
  /// 3. Has token? → HomeScreen. Otherwise → LoginScreen.
  Future<void> _onStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 3));

    if (!_sharedPrefService.hasSeenOnboarding) {
      emit(const SplashNavigateToOnboarding());
      return;
    }

    final token = await _getSavedToken();
    if (token != null && token.isNotEmpty) {
      emit(const SplashNavigateToHome());
    } else {
      emit(const SplashNavigateToLogin());
    }
  }
}
