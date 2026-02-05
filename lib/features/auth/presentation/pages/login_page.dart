import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora/core/config/constants/app_sizes.dart';
import 'package:taskora/core/config/constants/app_strings.dart';
import 'package:taskora/core/config/constants/color_manager.dart';
import 'package:taskora/core/config/widgets/Texts/clickable%20text.dart';
import 'package:taskora/core/config/widgets/buttons/app_primary_icon_button.dart';
import 'package:taskora/core/config/widgets/logo/auth_header.dart';
import 'package:taskora/core/config/widgets/text_fields/app_text_field.dart';
import 'package:taskora/core/router/routers_name.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _validateNow() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formKey.currentState?.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => curr is AuthError || curr is Authenticated,
      listener: (context, state) {
        if (state is AuthError) {
          _validateNow();
          final hasFieldErrors =
              state.emailError != null || state.passwordError != null;
          if (!hasFieldErrors) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? 'unknown error in login')),
            );
          }
        }
        if (state is Authenticated) {
           Navigator.pushReplacementNamed(context, AppRoutersName.mainPage);
        }
      },
      // buildWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final serverEmailError =
        state is AuthError ? state.emailError : null;
        final serverPasswordError =
        state is AuthError ? state.passwordError : null;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: AppPadding.paddingH25,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthHeader(),
                    const SizedBox(height: AppPadding.padding16),

                    AppTextField(
                      controller: _emailCtrl,
                      hint: AuthStrings.enterEmail,
                      label: AuthStrings.email,
                      onChanged: (_) {
                        final s = context.read<AuthBloc>().state;
                        if (s is AuthError) {
                          context.read<AuthBloc>().add(const ClearAuthErrorsEvent());
                        }
                      },
                      validator: (value) {
                        final v = (value ?? '').trim();
                        if (!v.contains('@') || !v.contains('.')) {
                          return AuthStrings.invalidEmail;
                        }
                        if (serverEmailError != null) return serverEmailError;
                        return null;
                      },
                    ),

                    const SizedBox(height: AppPadding.padding16),

                    AppTextField(
                      controller: _passwordCtrl,
                      hint: AuthStrings.enterPassword,
                      label: AuthStrings.password,
                      onChanged: (_) {
                        final s = context.read<AuthBloc>().state;
                        if (s is AuthError) {
                          context.read<AuthBloc>().add(const ClearAuthErrorsEvent());
                        }
                      },

                      isPassword: true,
                      validator: (value) {
                        final v = (value ?? '');
                        if (v.length < 8) return AuthStrings.invalidPassword;
                        if (serverPasswordError != null) {
                          return serverPasswordError;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: AppPadding.padding16),

                    Row(
                      children: [
                        const Spacer(),
                        ClickableText(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutersName.forgotPassword,
                          ),
                          text: LoginStrings.forgetPassword,
                          padding: EdgeInsetsGeometry.zero,
                        ),
                      ],
                    ),

                    const SizedBox(height: AppPadding.padding16),

                    AppPrimaryIconButton(
                      text: LoginStrings.login,
                      isLoading: isLoading,
                      onPressed: isLoading
                          ? null
                          : () {
                        final ok =
                            _formKey.currentState?.validate() ?? false;
                        if (!ok) return;

                        context.read<AuthBloc>().add(
                          LoginEvent(
                            email: _emailCtrl.text.trim(),
                            password: _passwordCtrl.text,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: AppPadding.padding16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          LoginStrings.doNotHaveAccount,
                          style: TextStyle(
                            color: ColorManager.secondary500,
                            fontSize: 11,
                          ),
                        ),
                        ClickableText(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutersName.signup,
                          ),
                          text: LoginStrings.createAccount,
                          padding: EdgeInsetsGeometry.zero,
                          textStyle: TextStyle(
                            color: ColorManager.primaryColor,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

