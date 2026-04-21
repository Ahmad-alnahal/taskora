import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora/core/config/constants/app_sizes.dart';
import 'package:taskora/core/config/constants/color_manager.dart';
import 'package:taskora/core/config/constants/app_strings.dart';
import 'package:taskora/core/config/widgets/buttons/app_primary_icon_button.dart';
import 'package:taskora/core/config/widgets/text_fields/app_text_field.dart';
import 'package:taskora/core/extensions/validation_extension.dart';
import 'package:taskora/core/router/routers_name.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_state.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, required this.email});
  final String email;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  @override
  void dispose() {
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    super.dispose();
  }

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
      listenWhen: (prev, curr) => curr is AuthError || curr is ResetPasswordSuccess,
      listener: (context, state) {
        if (state is AuthError) {
          _validateNow();

          final hasFieldErrors = state.passwordError != null;
          if (!hasFieldErrors) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ?? 'حدث خطأ غير متوقع')),
            );
          }
        }

        if (state is ResetPasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(ResetPasswordStrings.successMessage)),
          );
          Navigator.pushReplacementNamed(context, AppRoutersName.login);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final serverPasswordError = state is AuthError ? state.passwordError : null;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: AppPadding.paddingH25,
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),

                    Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRoutersName.verifyResetCode,
                            arguments: widget.email,
                          );
                        },
                        child: const Icon(Icons.arrow_forward),
                      ),
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                    Text(
                      ResetPasswordStrings.title,
                      textAlign: TextAlign.center,
                      style: textTheme.titleLarge,
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),

                    Text(
                      ResetPasswordStrings.subtitle,
                      textAlign: TextAlign.center,
                      style: textTheme.bodySmall?.copyWith(
                        color: ColorManager.notActiveColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                    AppTextField(
                      controller: _passCtrl,
                      hint: ResetPasswordStrings.enterNewPassword,
                      label: ResetPasswordStrings.newPassword,
                      isPassword: true,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: ColorManager.notActiveColor,
                      ),
                      onChanged: (_) => _clearErrorsIfNeeded(context),
                      validator: (value) {
                        final error = AppValidators.validatePassword(value);
                        if (error != null) return error;
                        if (serverPasswordError != null) return serverPasswordError;
                        return null;
                      },
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxHeight16),

                    AppTextField(
                      controller: _confirmPassCtrl,
                      hint: ResetPasswordStrings.enterConfirmPassword,
                      label: ResetPasswordStrings.confirmPassword,
                      isPassword: true,
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: ColorManager.notActiveColor,
                      ),
                      onChanged: (_) => _clearErrorsIfNeeded(context),
                      validator: (value) =>
                          AppValidators.validateConfirmPassword(value, _passCtrl.text),
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxHeight16),

                    AppPrimaryIconButton(
                      text: ResetPasswordStrings.save,
                      isLoading: isLoading,
                      onPressed: isLoading
                          ? null
                          : () {
                              final ok = _formKey.currentState?.validate() ?? false;
                              if (!ok) return;

                              context.read<AuthBloc>().add(
                                    ResetPasswordEvent(
                                      email: widget.email,
                                      newPassword: _passCtrl.text,
                                      confirmPassword: _confirmPassCtrl.text,
                                    ),
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
