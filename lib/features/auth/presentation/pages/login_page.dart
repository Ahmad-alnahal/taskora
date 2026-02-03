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

  bool _serverInvalid = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  void _revalidate() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _formKey.currentState?.validate();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => curr is AuthError || curr is Authenticated,
      listener: (context, state) {
        if (state is AuthError) {
          _serverInvalid = true;
          _revalidate();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }

        if (state is Authenticated) {
          // Navigator.pushReplacementNamed(context, AppRoutersName.mainNav);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        buildWhen: (prev, curr) => curr is AuthLoading || curr is! AuthLoading,
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
                      AuthHeader(),
                      const SizedBox(height: AppPadding.padding16),

                      AppTextField(
                        controller: _emailCtrl,
                        hint: LoginStrings.enterEmail,
                        label: LoginStrings.email,
                        onChanged: (_) => _serverInvalid = false,
                        validator: (value) {
                          final v = (value ?? '').trim();
                          if (!v.contains('@') || !v.contains('.')) {
                            return LoginStrings.invalidEmail;
                          }
                          if (_serverInvalid) return LoginStrings.invalidEmail;
                          return null;
                        },
                      ),

                      const SizedBox(height: AppPadding.padding16),

                      AppTextField(
                        controller: _passwordCtrl,
                        hint: LoginStrings.enterPassword,
                        label: LoginStrings.password,
                        isPassword: true,
                        onChanged: (_) => _serverInvalid = false,
                        validator: (value) {
                          final v = (value ?? '');
                          if (v.length < 8) return LoginStrings.invalidPassword;
                          if (_serverInvalid) return LoginStrings.invalidPassword;
                          return null;
                        },
                      ),

                      const SizedBox(height: AppPadding.padding16),

                      Row(
                        children: [
                          const Spacer(),
                          ClickableText(
                            onTap: () {
                              // لاحقًا: dispatch ForgotPasswordEvent
                            },
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
                          final ok = _formKey.currentState?.validate() ?? false;
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
                            onTap: () => Navigator.pushNamed(context, AppRoutersName.signup),
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
      ),
    );
  }
}
