import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>((e, emit) => emit(state.copyWith(email: e.email, serverInvalid: false)));
    on<LoginPasswordChanged>((e, emit) => emit(state.copyWith(password: e.password, serverInvalid: false)));

    on<LoginForgotPasswordTapped>((e, emit) {
      // navigation handled from UI or via BlocListener
    });

    on<LoginCreateAccountTapped>((e, emit) {});

    on<LoginSubmitted>((e, emit) async {
      if (state.isSubmitting) return;
      emit(state.copyWith(
        isSubmitting: true,
          serverInvalid: false
      ));

      //  بدل قاعدة بيانات
      await Future.delayed(const Duration(seconds: 5));
      final okEmail = state.email.trim() == 'alnahal@gmail.com';
      final okPass = state.password == '12345678';
      // التحقق من رد قاعدة البيانات
      if (okEmail && okPass) {
        emit(state.copyWith(isSubmitting: false, serverInvalid: false));
      } else {
        emit(state.copyWith(
          isSubmitting: false,
            serverInvalid: true
        ));
      }
    });
  }
}
