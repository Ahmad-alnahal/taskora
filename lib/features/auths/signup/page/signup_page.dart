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
import '../bloc/signup_bloc.dart';
import '../bloc/signup_event.dart';
import '../bloc/signup_state.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupBloc(),
      child: const _SignupBody(),
    );
  }
}

class _SignupBody extends StatefulWidget {
  const _SignupBody();

  @override
  State<_SignupBody> createState() => _SignupBodyState();
}

class _SignupBodyState extends State<_SignupBody> {
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

  bool _isValidEmail(String v) => v.contains('@') && v.contains('.');

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppPadding.paddingH25,
          child: BlocListener<SignupBloc, SignupState>(
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
            child: BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                return Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height:SizedBoxSizes.sizedBoxMediumHeight),
                      Align(
                          alignment:AlignmentGeometry.topRight,
                          child: InkWell(
                            onTap: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }else{
                                Navigator.pushReplacementNamed(context, AppRoutersName.login);
                              }
                            },
                              child: Icon(
                                  Icons.arrow_back
                              )
                          )
                      ),
                      SizedBox(height:SizedBoxSizes.sizedBoxSmallHeight),
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
                        prefixIcon: Icon(Icons.person_outline,color: ColorManager.notActiveColor,),
                        controller: _nameCtrl,
                        hint: SignupStrings.enterName,
                        label: SignupStrings.name,
                        onChanged: (v) => context.read<SignupBloc>().add(SignupNameChanged(v)),
                        validator: (value) {
                          final v = (value ?? '').trim();
                          if (v.length < 3) return SignupStrings.invalidName;
                          if (state.serverInvalid && v.length < 3) return SignupStrings.invalidName;
                          return null;
                        },
                      ),

                      const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                      AppTextField(
                        prefixIcon: Icon(Icons.email_outlined,color: ColorManager.notActiveColor,),
                        controller: _emailCtrl,
                        hint: SignupStrings.enterEmail,
                        label: SignupStrings.email,
                        onChanged: (v) => context.read<SignupBloc>().add(SignupEmailChanged(v)),
                        validator: (value) {
                          final v = (value ?? '').trim();
                          if (!_isValidEmail(v)) return SignupStrings.invalidEmail;
                          if (state.serverInvalid) return SignupStrings.invalidEmail;
                          return null;
                        },
                      ),

                      const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                      AppTextField(
                        prefixIcon: Icon(Icons.lock_outline,color: ColorManager.notActiveColor,),
                        controller: _passwordCtrl,
                        hint: SignupStrings.enterPassword,
                        label: SignupStrings.password,
                        isPassword: true,
                        onChanged: (v) => context.read<SignupBloc>().add(SignupPasswordChanged(v)),
                        validator: (value) {
                          final v = (value ?? '');
                          if (v.length < 8) return SignupStrings.invalidPassword;
                          if (state.serverInvalid) return SignupStrings.invalidPassword;
                          return null;
                        },
                      ),

                      const SizedBox(height:SizedBoxSizes.sizedBoxMediumHeight),

                      AppTextField(
                        prefixIcon: Icon(Icons.lock_outline,color: ColorManager.notActiveColor,),
                        controller: _confirmCtrl,
                        hint: SignupStrings.enterConfirmPassword,
                        label: SignupStrings.confirmPassword,
                        isPassword: true,
                        onChanged: (v) => context.read<SignupBloc>().add(SignupConfirmPasswordChanged(v)),
                        validator: (value) {
                          final v = (value ?? '');
                          if (v.isEmpty) return SignupStrings.invalidConfirmPassword;
                          if (v != _passwordCtrl.text) return SignupStrings.passwordNotMatch;
                          if (state.serverInvalid) return SignupStrings.invalidConfirmPassword;
                          return null;
                        },
                      ),

                      const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                      AppTextField(
                        prefixIcon: Icon(Icons.attach_money_outlined,color: ColorManager.notActiveColor,),
                        controller: _hourRateCtrl,
                        hint: SignupStrings.enterHourRate,
                        label: SignupStrings.hourRate,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}$')),
                        ],
                        onChanged: (v) => context.read<SignupBloc>().add(SignupHourRateChanged(v)),
                        validator: (value) {
                          final v = (value ?? '').trim();
                          final n = double.tryParse(v);
                          if (n == null || n <= 0) return SignupStrings.invalidHourRate;
                          if (state.serverInvalid) return SignupStrings.invalidHourRate;
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
                        isLoading: state.isSubmitting,
                        onPressed: state.isSubmitting
                            ? null
                            : () {
                          final isValid = _formKey.currentState?.validate() ?? false;
                          if (isValid) {
                            context.read<SignupBloc>().add(const SignupSubmitted());
                          }
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
                            onTap: () {
                              Navigator.pushReplacementNamed(context, AppRoutersName.login);
                            },
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            SignupStrings.termsNote1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorManager.notActiveColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            SignupStrings.termsNote2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

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
