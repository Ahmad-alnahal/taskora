import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora/core/config/constants/app_sizes.dart';
import 'package:taskora/core/config/constants/color_manager.dart';
import 'package:taskora/core/config/constants/app_strings.dart';
import 'package:taskora/core/config/constants/image_path.dart';
import 'package:taskora/core/config/widgets/Texts/clickable%20text.dart';
import 'package:taskora/core/config/widgets/buttons/app_primary_icon_button.dart';
import 'package:taskora/core/router/routers_name.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_event.dart';
import 'package:taskora/features/auth/presentation/bloc/auth_state.dart';

class VerifyResetCodePage extends StatefulWidget {
  const VerifyResetCodePage({super.key, required this.email});
  final String email;

  @override
  State<VerifyResetCodePage> createState() => _VerifyResetCodePageState();
}

class _VerifyResetCodePageState extends State<VerifyResetCodePage> {
  static const int _otpLen = 4;
  static const int _resendSeconds = 60;

  late final List<TextEditingController> _ctrls =
  List.generate(_otpLen, (_) => TextEditingController());
  late final List<FocusNode> _nodes = List.generate(_otpLen, (_) => FocusNode());

  Timer? _timer;
  int _remaining = _resendSeconds;
  bool _hasOtpError = false;
  bool _didSubmitVerify = false;
  String? _lastSnackMsg;
  DateTime? _lastSnackAt;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _ctrls) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _remaining = _resendSeconds);

    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (!mounted) return;
      if (_remaining <= 0) {
        t.cancel();
        return;
      }
      setState(() => _remaining--);
    });
  }

  void _clearBlocErrorsIfNeeded() {
    final s = context.read<AuthBloc>().state;
    if (s is AuthError) {
      context.read<AuthBloc>().add(const ClearAuthErrorsEvent());
    }
  }

  void _showSnackOnce(String msg) {
    final now = DateTime.now();
    final recently = _lastSnackAt != null &&
        now.difference(_lastSnackAt!) < const Duration(seconds: 2);

    if (_lastSnackMsg == msg && recently) return;

    _lastSnackMsg = msg;
    _lastSnackAt = now;

    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(SnackBar(content: Text(msg)));
  }

  String _code() => _ctrls.map((c) => c.text).join();

  void _onChangedDigit(int index, String value) {
    _clearBlocErrorsIfNeeded();
    if (_hasOtpError || _didSubmitVerify) {
      setState(() {
        _hasOtpError = false;
        _didSubmitVerify = false;
      });
    }

    if (value.length > 1) {
      final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
      for (int i = 0; i < _otpLen; i++) {
        _ctrls[i].text = i < digits.length ? digits[i] : '';
      }
      if (digits.length >= _otpLen) {
        _nodes[_otpLen - 1].unfocus();
      } else {
        _nodes[digits.length].requestFocus();
      }
      setState(() {});
      return;
    }
    if (value.isNotEmpty && index < _otpLen - 1) {
      _nodes[index + 1].requestFocus();
    }

    setState(() {});
  }

  KeyEventResult _onKey(int index, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_ctrls[index].text.isEmpty && index > 0) {
        _nodes[index - 1].requestFocus();
        _ctrls[index - 1].clear();
        setState(() {});
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final email = widget.email;
    final textTheme = Theme.of(context).textTheme;

    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (prev, curr) =>
      curr is AuthError ||
          curr is ResetCodeVerified ||
          curr is ForgotPasswordCodeSent,
      listener: (context, state) {
        if (state is AuthError) {
          if (_didSubmitVerify) {
            setState(() {
              _hasOtpError = true;
              _didSubmitVerify = false;
            });
          }
          _showSnackOnce(state.message ?? 'Unknown error');
        }

        if (state is ForgotPasswordCodeSent) {
          _startTimer();
          _showSnackOnce(state.message);
        }

        if (state is ResetCodeVerified) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutersName.resetPassword,
            arguments: widget.email,
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        final canResend = _remaining <= 0;

        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: AppPadding.paddingH25,
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
                            AppRoutersName.forgotPassword,
                          );
                      },
                      child: const Icon(Icons.arrow_forward),
                    ),
                  ),

                  const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),

                  Center(
                    child: Image.asset(
                      ImagePath.verifyCodeImage,
                      height: 168,
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) =>
                      const SizedBox(height: 168),
                    ),
                  ),

                  const SizedBox(height: SizedBoxSizes.sizedBoxHeight16),

                  Text(
                    VerifyPasswordStrings.activationCode,
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge,
                  ),

                  const SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),

                  Text(
                    VerifyPasswordStrings.codeSended,
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color: ColorManager.notActiveColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),

                  Text(
                    email,
                    textAlign: TextAlign.center,
                    style: textTheme.bodySmall?.copyWith(
                      color: ColorManager.notActiveColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16
                    ),
                  ),

                  const SizedBox(height: SizedBoxSizes.sizedBoxHeight16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_otpLen, (i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: SizedBox(
                          width: 60,
                          height: 48,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(BorderRadiusSize.borderRadius15 ),
                              border: Border.all(
                                color: _hasOtpError
                                    ? Colors.red
                                    : const Color(0xFF96D2C8),
                                width: 1,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x1A000000),
                                  offset: Offset(0, 2),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                ),
                              ],
                            ),
                            alignment: Alignment.center,
                            child: KeyboardListener(
                              focusNode: FocusNode(),
                              onKeyEvent: (e) => _onKey(i, e),
                              child: TextFormField(
                                controller: _ctrls[i],
                                focusNode: _nodes[i],
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                maxLength: 1,
                                obscureText: true,
                                obscuringCharacter: '*',
                                inputFormatters:  [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: const InputDecoration(
                                  counterText: '',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  focusedErrorBorder: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                onChanged: (v) => _onChangedDigit(i, v),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  const SizedBox(height: SizedBoxSizes.sizedBoxHeight16),

                  AppPrimaryIconButton(
                    text: VerifyPasswordStrings.followUp,
                    isLoading: isLoading,
                    onPressed: isLoading
                        ? null
                        : () {
                      final code = _code();

                      if (code.length != _otpLen) {
                        setState(() => _hasOtpError = true);
                        return;
                      }

                      setState(() {
                        _hasOtpError = false;
                        _didSubmitVerify = true;
                      });

                      context.read<AuthBloc>().add(
                        VerifyResetCodeEvent(
                          email: email,
                          code: code,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: SizedBoxSizes.sizedBoxHeight16),

                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              VerifyPasswordStrings.didNotReceiveCode,
                              style: textTheme.bodySmall?.copyWith(
                                color: ColorManager.notActiveColor,
                              ),
                            ),
                            const SizedBox(
                                width: SizedBoxSizes.sizedBoxSmallHeight),
                            ClickableText(
                              padding: EdgeInsetsGeometry.zero,
                              text: VerifyPasswordStrings.resend,
                              textStyle: textTheme.bodySmall?.copyWith(
                                color: ColorManager.primaryColor,
                              ),
                              onTap: () {
                                if (isLoading) return;

                                if (!canResend) {
                                  _showSnackOnce(
                                    '${VerifyPasswordStrings.conNotBeSendWait} ${_remaining}s',
                                  );
                                  return;
                                }

                                context.read<AuthBloc>().add(
                                  ForgotPasswordEvent(email: email),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),
                        Text(
                          '${VerifyPasswordStrings.codeExpireIn} ${_remaining.toString().padLeft(4, '0')}',
                          style: textTheme.bodySmall?.copyWith(
                            color: Colors.redAccent,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
