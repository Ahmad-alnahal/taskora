import 'package:flutter/material.dart';
import 'core/theme/light_theme.dart' as LightTheme;
import 'features/Onboarding/pages/onboarding_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, child){
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child ?? const SizedBox.shrink(),
          );
        },
        title: 'Taskora',
        debugShowCheckedModeBanner: false,
        theme: LightTheme.lightTheme,
        home: const  OnboardingPage(),

    );
  }
}

