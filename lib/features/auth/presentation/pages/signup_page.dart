import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora/core/config/constants/app_sizes.dart';
import 'package:taskora/core/config/constants/color_manager.dart';
import 'package:taskora/core/config/constants/app_strings.dart';
import 'package:taskora/core/config/widgets/Texts/clickable text.dart';
import 'package:taskora/core/config/widgets/buttons/app_primary_icon_button.dart';
import 'package:taskora/core/config/widgets/text_fields/app_text_field.dart';
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

  bool _serverInvalid = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    _hourRateCtrl.dispose();
    super.dispose();
  }

  bool _isValidEmail(String v) => v.contains('@') && v.contains('.');

  void _revalidate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formKey.currentState?.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => curr is AuthError || curr is SignupSuccess,
      listener: (context, state) {
        if (state is AuthError) {
          _serverInvalid = true;
          _revalidate();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }

        if (state is SignupSuccess) {
          Navigator.pushReplacementNamed(context, AppRoutersName.login);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: AppPadding.paddingH25,
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
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
                              Navigator.pushReplacementNamed(context, AppRoutersName.login);
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
                        prefixIcon: Icon(Icons.person_outline, color: ColorManager.notActiveColor),
                        controller: _nameCtrl,
                        hint: SignupStrings.enterName,
                        label: SignupStrings.name,
                        onChanged: (_) => _serverInvalid = false,
                        validator: (value) {
                          final v = (value ?? '').trim();
                          if (v.length < 3) return SignupStrings.invalidName;
                          if (_serverInvalid) return SignupStrings.invalidName;
                          return null;
                        },
                      ),

                      const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                      AppTextField(
                        prefixIcon: Icon(Icons.email_outlined, color: ColorManager.notActiveColor),
                        controller: _emailCtrl,
                        hint: SignupStrings.enterEmail,
                        label: SignupStrings.email,
                        onChanged: (_) => _serverInvalid = false,
                        validator: (value) {
                          final v = (value ?? '').trim();
                          if (!_isValidEmail(v)) return SignupStrings.invalidEmail;
                          if (_serverInvalid) return SignupStrings.invalidEmail;
                          return null;
                        },
                      ),

                      const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                      AppTextField(
                        prefixIcon: Icon(Icons.lock_outline, color: ColorManager.notActiveColor),
                        controller: _passwordCtrl,
                        hint: SignupStrings.enterPassword,
                        label: SignupStrings.password,
                        isPassword: true,
                        onChanged: (_) => _serverInvalid = false,
                        validator: (value) {
                          final v = (value ?? '');
                          if (v.length < 8) return SignupStrings.invalidPassword;
                          if (_serverInvalid) return SignupStrings.invalidPassword;
                          return null;
                        },
                      ),

                      const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                      AppTextField(
                        prefixIcon: Icon(Icons.lock_outline, color: ColorManager.notActiveColor),
                        controller: _confirmCtrl,
                        hint: SignupStrings.enterConfirmPassword,
                        label: SignupStrings.confirmPassword,
                        isPassword: true,
                        onChanged: (_) => _serverInvalid = false,
                        validator: (value) {
                          final v = (value ?? '');
                          if (v.isEmpty) return SignupStrings.invalidConfirmPassword;
                          if (v != _passwordCtrl.text) return SignupStrings.passwordNotMatch;
                          if (_serverInvalid) return SignupStrings.invalidConfirmPassword;
                          return null;
                        },
                      ),

                      const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                      AppTextField(
                        prefixIcon: Icon(Icons.attach_money_outlined, color: ColorManager.notActiveColor),
                        controller: _hourRateCtrl,
                        hint: SignupStrings.enterHourRate,
                        label: SignupStrings.hourRate,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                        ],
                        onChanged: (_) => _serverInvalid = false,
                        validator: (value) {
                          final v = (value ?? '').trim();
                          final n = double.tryParse(v);
                          if (n == null || n <= 0) return SignupStrings.invalidHourRate;
                          if (_serverInvalid) return SignupStrings.invalidHourRate;
                          return null;
                        },
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
                          final ok = _formKey.currentState?.validate() ?? false;
                          if (!ok) return;

                          context.read<AuthBloc>().add(
                            SignupEvent(
                              name: _nameCtrl.text.trim(),
                              email: _emailCtrl.text.trim(),
                              password: _passwordCtrl.text,
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
                            onTap: () => Navigator.pushReplacementNamed(context, AppRoutersName.login),
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
      ),
    );
  }
}
