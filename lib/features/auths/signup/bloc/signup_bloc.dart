import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_event.dart';
import 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(const SignupState()) {
    on<SignupNameChanged>((e, emit) => emit(state.copyWith(name: e.name, serverInvalid: false)));
    on<SignupEmailChanged>((e, emit) => emit(state.copyWith(email: e.email, serverInvalid: false)));
    on<SignupPasswordChanged>((e, emit) => emit(state.copyWith(password: e.password, serverInvalid: false)));
    on<SignupConfirmPasswordChanged>((e, emit) => emit(state.copyWith(confirmPassword: e.confirmPassword, serverInvalid: false)));
    on<SignupHourRateChanged>((e, emit) => emit(state.copyWith(hourRate: e.hourRate, serverInvalid: false)));

    on<SignupLoginTapped>((e, emit) {
    });

    on<SignupSubmitted>((e, emit) async {
      if (state.isSubmitting) return;

      emit(state.copyWith(
        isSubmitting: true,
        serverInvalid: false,
      ));


      await Future.delayed(const Duration(seconds: 3));

      // مثال تحقق "سيرفر" بسيط
      final okEmail = state.email.trim().contains('@') && state.email.trim().contains('.');
      final okPass = state.password.length >= 8;
      final okMatch = state.password == state.confirmPassword;
      final okName = state.name.trim().length >= 3;


      final rate = double.tryParse(state.hourRate.trim());
      final okRate = rate != null && rate > 0;

      if (okEmail && okPass && okMatch && okName && okRate) {
        emit(state.copyWith(isSubmitting: false, serverInvalid: false));
      } else {
        emit(state.copyWith(isSubmitting: false, serverInvalid: true));
      }
    });
  }
}
