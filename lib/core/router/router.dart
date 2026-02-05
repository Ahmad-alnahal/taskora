import 'package:flutter/material.dart';
import 'package:taskora/core/router/routers_name.dart';
import 'package:taskora/features/Onboarding/pages/onboarding_page.dart';
import 'package:taskora/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:taskora/features/auth/presentation/pages/login_page.dart';
import 'package:taskora/features/auth/presentation/pages/signup_page.dart';
import 'package:taskora/features/auth/presentation/pages/auth_gate_page.dart';
import 'package:taskora/features/auth/presentation/pages/verify_reset_code_page.dart';
import 'package:taskora/features/main_nav/pages/main_page.dart';

class AppRoutes {
  AppRoutes._();
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutersName.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());

      case AppRoutersName.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

        case AppRoutersName.signup:
        return MaterialPageRoute(builder: (_) => const SignupPage());

      case AppRoutersName.authGate:
        return MaterialPageRoute(builder: (_) => const AuthGatePage());

      case AppRoutersName.mainPage:
        return MaterialPageRoute(builder: (_) => const MainPage());

        case AppRoutersName.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());

      case AppRoutersName.verifyResetCode:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => VerifyResetCodePage(email: email),
        );


      default:
        return MaterialPageRoute(
          builder: (_) => const _UndefinedRoutePage(),
        );
    }
  }
}

class _UndefinedRoutePage extends StatelessWidget {
  const _UndefinedRoutePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 60),
              const SizedBox(height: 20),
              const Text(
                'Oops! The page you were looking for doesn\'t exist.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if(Navigator.of(context).canPop()) Navigator.of(context).pop();
                },
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
