import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora/core/extensions/exception_message.dart';
import 'package:taskora/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:taskora/features/auth/domain/usecases/get_saved_token_usecase.dart';
import 'package:taskora/features/auth/domain/usecases/login_usecase.dart';
import 'package:taskora/features/auth/domain/usecases/logout_usecase.dart';
import 'package:taskora/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:taskora/features/auth/domain/usecases/signup_usecase.dart';
import 'package:taskora/features/auth/domain/usecases/verify_reset_code_usecase.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_state.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required this.login,
    required this.signup,
    required this.logout,
    required this.forgotPassword,
    required this.verifyResetCode,
    required this.resetPassword,
    required this.getSavedTokenUseCase,
  }) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoginEvent>(_onLogin, transformer: droppable());
    on<SignupEvent>(_onSignup, transformer: droppable());
    on<ForgotPasswordEvent>(_onForgotPassword, transformer: droppable());
    on<VerifyResetCodeEvent>(_onVerifyCode, transformer: droppable());
    on<ResetPasswordEvent>(_onResetPassword, transformer: droppable());
    on<LogoutEvent>(_onLogout, transformer: droppable());
    on<ClearAuthErrorsEvent>((event, emit) => emit(Unauthenticated()));
  }

  final LoginUseCase login;
  final SignupUseCase signup;
  final LogoutUseCase logout;
  final ForgotPasswordUseCase forgotPassword;
  final VerifyResetCodeUseCase verifyResetCode;
  final ResetPasswordUseCase resetPassword;
  final GetSavedTokenUseCase getSavedTokenUseCase;


  Future<void> _onAppStarted(AppStarted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final token = await getSavedTokenUseCase();
      if (token != null && token.isNotEmpty) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    await _run(emit, () async {
      await login(email: event.email, password: event.password);
      emit(Authenticated());
    });
  }

  Future<void> _onSignup(SignupEvent event, Emitter<AuthState> emit) async {
    await _run(emit, () async {
      await signup(
        name: event.name,
        email: event.email,
        password: event.password,
        hourlyRate: event.hourlyRate,
      );
      emit(SignupSuccess());
    });
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await _run(emit, () async {
      await logout();
      emit(Unauthenticated());
    });
  }

  Future<void> _onForgotPassword(ForgotPasswordEvent event, Emitter<AuthState> emit) async {
    await _run(emit, () async {
      final result = await forgotPassword(email: event.email);
      emit(ForgotPasswordCodeSent(
        email: result.email,
        code: result.code,
        message: result.message,
      ));
    });
  }

  Future<void> _onVerifyCode(VerifyResetCodeEvent event, Emitter<AuthState> emit) async {
    await _run(emit, () async {
      await verifyResetCode(email: event.email, code: event.code);
      emit(const ResetCodeVerified());
    });
  }

  Future<void> _onResetPassword(ResetPasswordEvent event, Emitter<AuthState> emit) async {
    await _run(emit, () async {
      await resetPassword(
        email: event.email,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      );
      emit(ResetPasswordSuccess());
    });
  }

  Future<void> _run(Emitter<AuthState> emit, Future<void> Function() action) async {
    emit(AuthLoading());
    try {
      await action();
    } catch (e) {
      emit(AuthError(message:e.userMessage));
    }
  }
}

