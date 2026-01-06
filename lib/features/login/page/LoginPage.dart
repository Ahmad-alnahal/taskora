import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora/core/config/constants/color_manager.dart';
import '../../../core/config/constants/app_sizes.dart';
import '../../../core/config/constants/app_strings.dart';
import '../../../core/config/widgets/Texts/clickable text.dart';
import '../../../core/config/widgets/buttons/app_primary_icon_button.dart';
import '../../../core/config/widgets/logo/auth_header.dart';
import '../../../core/config/widgets/text_fields/app_text_field.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_event.dart';
import '../bloc/login_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(),
      child: const _LoginBody(),
    );
  }
}
class _LoginBody extends StatefulWidget {
  const _LoginBody();

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.paddingH25,
          child: BlocListener<LoginBloc, LoginState>(
            listenWhen: (prev, curr) =>
            prev.isSubmitting != curr.isSubmitting ||
                prev.serverInvalid != curr.serverInvalid,
            listener: (context, state) {

              if (!state.isSubmitting && state.serverInvalid) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _formKey.currentState?.validate();
                });
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Form(
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
                        onChanged: (v) =>
                            context.read<LoginBloc>().add(LoginEmailChanged(v)),
                        validator: (value) {
                          if (value == null || !value.contains('@') || !value.contains('.')) {
                            return LoginStrings.invalidEmail;
                          }if (state.serverInvalid) {
                            return LoginStrings.invalidEmail;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: AppPadding.padding16),

                      AppTextField(
                        controller: _passwordCtrl,
                        hint: LoginStrings.enterPassword,
                        label:LoginStrings.password,
                        isPassword: true,
                        onChanged: (v) =>
                            context.read<LoginBloc>().add(LoginPasswordChanged(v)),
                        validator: (value) {
                          if (value == null || value.length < 8) {
                            return LoginStrings.invalidPassword;
                          } if (state.serverInvalid) {
                            return LoginStrings.invalidPassword;
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: AppPadding.padding16),

                      Row(
                        children: [
                          Spacer(),
                          ClickableText(
                            onTap: (){},
                            text: LoginStrings.forgetPassword,
                            padding: EdgeInsetsGeometry.zero,),
                        ],
                      ),

                      const SizedBox(height: AppPadding.padding16),

                      AppPrimaryIconButton(
                        text: LoginStrings.login,
                        isLoading: state.isSubmitting,
                        onPressed: state.isSubmitting
                            ? null
                            : () {
                          final isValid = _formKey.currentState?.validate() ?? false;
                          if (isValid) {
                            context
                                .read<LoginBloc>()
                                .add(const LoginSubmitted());
                          }
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
                            onTap: (){},
                            text: LoginStrings.createAccount,
                            padding: EdgeInsetsGeometry.zero,
                            textStyle: TextStyle(
                                color: ColorManager.primaryColor,
                                fontSize: 11
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  );
            },
          ),
        ),
      ),
      ),
    );
  }
}
