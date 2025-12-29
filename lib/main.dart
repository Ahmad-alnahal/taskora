import 'package:flutter/material.dart';
import 'core/config/widgets/Cards/CircularProgressCard.dart';
import 'core/theme/light_theme.dart' as LightTheme;
import 'features/main_nav/pages/main_page.dart';

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
        home: const MainPage(),

    );
  }
}


class TestingScreen extends StatelessWidget {
  const TestingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Testing Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Center(
          child: SizedBox(
            child: const CircularProgressCard(
            value: 65,
            label: 'الإنجاز',
            size: 120,
            ),
          ),
        ),
      ),
    );
  }
}
