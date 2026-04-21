import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora/core/config/widgets/logo/app_logo.dart';
import 'package:taskora/core/router/routers_name.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<SplashBloc>().add(const SplashStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        switch (state) {
          case SplashNavigateToOnboarding():
            Navigator.pushReplacementNamed(
              context,
              AppRoutersName.onboarding,
            );
          case SplashNavigateToLogin():
            Navigator.pushReplacementNamed(
              context,
              AppRoutersName.login,
            );
          case SplashNavigateToHome():
            Navigator.pushReplacementNamed(
              context,
              AppRoutersName.mainPage,
            );
          default:
            break;
        }
      },
      child: const Scaffold(
        body: Center(
          child: AppLogo.splash(),
        ),
      ),
    );
  }
}
