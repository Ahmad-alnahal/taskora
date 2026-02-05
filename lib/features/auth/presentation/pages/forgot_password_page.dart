import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora/core/config/constants/app_sizes.dart';
import 'package:taskora/core/config/constants/color_manager.dart';
import 'package:taskora/core/config/constants/app_strings.dart';
import 'package:taskora/core/config/constants/image_path.dart';
import 'package:taskora/core/config/widgets/buttons/app_primary_icon_button.dart';
import 'package:taskora/core/config/widgets/text_fields/app_text_field.dart';
import 'package:taskora/core/router/routers_name.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_state.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  bool _isValidEmail(String v) => v.contains('@') && v.contains('.');

  void _validateNow() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formKey.currentState?.validate();
    });
  }

  void _clearErrorsIfNeeded(BuildContext context) {
    final s = context.read<AuthBloc>().state;
    if (s is AuthError) {
      context.read<AuthBloc>().add(const ClearAuthErrorsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (prev, curr) =>
      curr is AuthError || curr is ForgotPasswordCodeSent ,
      listener: (context, state) {
        if (state is AuthError) {
          _validateNow();

          final hasFieldErrors = state.emailError != null;
          if (!hasFieldErrors) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message ?? 'Unknown error in forgot password',
                ),
              ),
            );
          }
        }

        if (state is ForgotPasswordCodeSent) {
          Navigator.pushNamed(
            context,
            AppRoutersName.verifyResetCode,
            arguments: state.email,
          );
        }

      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final serverEmailError = state is AuthError ? state.emailError : null;

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
                    const SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),

                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: InkWell(
                        onTap: () {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          } else {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRoutersName.login,
                            );
                          }
                        },
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                    Center(
                      child: Image.asset(
                        ImagePath.forgotPasswordImage,
                        height: 230,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const SizedBox(height: 230),
                      ),
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxHeight16),

                    Text(
                      ForgotPasswordStrings.plzEnterEmail,
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall?.copyWith(
                        color: ColorManager.notActiveColor,
                      ),
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                    AppTextField(
                      controller: _emailCtrl,
                      hint: AuthStrings.enterEmail,
                      label: AuthStrings.email,
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: ColorManager.notActiveColor,
                      ),
                      onChanged: (_) => _clearErrorsIfNeeded(context),
                      validator: (value) {
                        final v = (value ?? '').trim();
                        if (!_isValidEmail(v)) {
                          return AuthStrings.invalidEmail;
                        }
                        if (serverEmailError != null) return serverEmailError;
                        return null;
                      },
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxHeight16),

                    AppPrimaryIconButton(
                      text: ForgotPasswordStrings.send,
                      isLoading: isLoading,
                      onPressed:  isLoading
                        ? null
                        : () {
              final ok = _formKey.currentState?.validate() ?? false;
              if (!ok) return;

              context.read<AuthBloc>().add(
              ForgotPasswordEvent(email: _emailCtrl.text.trim()),
              );
              },

              ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),
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
