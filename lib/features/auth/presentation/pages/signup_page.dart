import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora/core/config/constants/app_sizes.dart';
import 'package:taskora/core/config/constants/color_manager.dart';
import 'package:taskora/core/config/constants/app_strings.dart';
import 'package:taskora/core/config/widgets/Texts/clickable text.dart';
import 'package:taskora/core/config/widgets/buttons/app_primary_icon_button.dart';
import 'package:taskora/core/config/widgets/text_fields/app_text_field.dart';
import 'package:taskora/core/extensions/validation_extension.dart';
import 'package:taskora/core/router/routers_name.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_state.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _hourRateCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    _hourRateCtrl.dispose();
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
      listenWhen: (prev, curr) => curr is AuthError || curr is SignupSuccess,
      listener: (context, state) {
        if (state is AuthError) {
          _validateNow();

          final hasFieldErrors =
              state.emailError != null || state.passwordError != null;

          if (!hasFieldErrors) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message ??'unknown error in signup')),
            );
          }
        }

        if (state is SignupSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutersName.login);
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;

        final serverEmailError = state is AuthError ? state.emailError : null;
        final serverPasswordError =
        state is AuthError ? state.passwordError : null;

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
                    SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),
                    Align(
                      alignment: AlignmentDirectional.topStart,
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
                        child: const Icon(Icons.arrow_back),
                      ),
                    ),

                    SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),

                    Column(
                      children: [
                        Text(
                          SignupStrings.signupApp,
                          textAlign: TextAlign.center,
                          style: textTheme.headlineSmall,
                        ),
                        const SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),
                        Text(
                          SignupStrings.welcomeToSignupApp,
                          textAlign: TextAlign.center,
                          style: textTheme.bodySmall,
                        ),
                      ],
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                    AppTextField(
                      prefixIcon: Icon(Icons.person_outline,
                          color: ColorManager.notActiveColor),
                      controller: _nameCtrl,
                      hint: SignupStrings.enterName,
                      label: SignupStrings.name,
                      onChanged: (_) => _clearErrorsIfNeeded(context),
                      validator: AppValidators.validateName,
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                    AppTextField(
                      prefixIcon: Icon(Icons.email_outlined,
                          color: ColorManager.notActiveColor),
                      controller: _emailCtrl,
                      hint: AuthStrings.enterEmail,
                      label: AuthStrings.email,
                      onChanged: (_) => _clearErrorsIfNeeded(context),
                      validator: (value) {
                        final clientError = AppValidators.validateEmail(value);
                        if (clientError != null) return clientError;
                        if (serverEmailError != null) return serverEmailError;
                        return null;
                      },
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                    AppTextField(
                      prefixIcon: Icon(Icons.lock_outline,
                          color: ColorManager.notActiveColor),
                      controller: _passwordCtrl,
                      hint: AuthStrings.enterPassword,
                      label: AuthStrings.password,
                      isPassword: true,
                      onChanged: (_) => _clearErrorsIfNeeded(context),
                      validator: (value) {
                        final clientError = AppValidators.validatePassword(value);
                        if (clientError != null) return clientError;
                        if (serverPasswordError != null) return serverPasswordError;
                        return null;
                      },
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                    AppTextField(
                      prefixIcon: Icon(Icons.lock_outline,
                          color: ColorManager.notActiveColor),
                      controller: _confirmCtrl,
                      hint: SignupStrings.enterConfirmPassword,
                      label: SignupStrings.confirmPassword,
                      isPassword: true,
                      onChanged: (_) => _clearErrorsIfNeeded(context),
                      validator: (value) =>
                          AppValidators.validateConfirmPassword(value, _passwordCtrl.text),
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                    AppTextField(
                      prefixIcon: Icon(Icons.attach_money_outlined,
                          color: ColorManager.notActiveColor),
                      controller: _hourRateCtrl,
                      hint: SignupStrings.enterHourRate,
                      label: SignupStrings.hourRate,
                      keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}$'),
                        ),
                      ],
                      onChanged: (_) => _clearErrorsIfNeeded(context),
                      validator: AppValidators.validateHourlyRate,
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                    Text(
                      SignupStrings.hourRateNote,
                      style: TextStyle(
                        color: ColorManager.notActiveColor,
                        fontSize: 12,
                      ),
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                    AppPrimaryIconButton(
                      text: SignupStrings.createAccount,
                      isLoading: isLoading,
                      onPressed: isLoading
                          ? null
                          : () {
                        final ok =
                            _formKey.currentState?.validate() ?? false;
                        if (!ok) return;

                        context.read<AuthBloc>().add(
                          SignupEvent(
                            name: _nameCtrl.text.trim(),
                            email: _emailCtrl.text.trim(),
                            password: _passwordCtrl.text,
                            hourlyRate: double.tryParse(_hourRateCtrl.text.trim()) ?? 0,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          SignupStrings.haveAccount,
                          style: TextStyle(
                            color: ColorManager.secondary500,
                            fontSize: 11,
                          ),
                        ),
                        ClickableText(
                          onTap: () => Navigator.pushReplacementNamed(
                            context,
                            AppRoutersName.login,
                          ),
                          text: SignupStrings.login,
                          padding: EdgeInsetsGeometry.zero,
                          textStyle: TextStyle(
                            color: ColorManager.primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ],
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
