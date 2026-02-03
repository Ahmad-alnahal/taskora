import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/service_locator.dart';
import 'core/router/router.dart';
import 'core/router/routers_name.dart';
import 'core/services/local/shared_pref_service.dart';
import 'core/theme/light_theme.dart' as LightTheme;
import 'features/Onboarding/pages/onboarding_page.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  final sharedPref = sl<SharedPrefService>();

  final String initialRoute = sharedPref.hasSeenOnboarding
      ? AppRoutersName.authGate
      : AppRoutersName.onboarding;


  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => sl<AuthBloc>()),
      ],
      child: MyApp(initialRoute: initialRoute),
    ),
  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initialRoute,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      builder: (context, child){
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child ?? const SizedBox.shrink(),
        );
      },
      title: 'Taskora',
      theme: LightTheme.lightTheme,
    );
  }
}

