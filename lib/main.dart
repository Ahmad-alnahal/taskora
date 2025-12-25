import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/color_manager.dart';
import 'core/config/widgets/buttons/app_chip_button.dart';
import 'core/config/widgets/buttons/app_dual_action_row.dart';
import 'core/config/widgets/buttons/app_outlined_danger_button.dart';
import 'core/config/widgets/buttons/app_pill_button.dart';
import 'core/config/widgets/buttons/app_primary_icon_button.dart';
import 'core/config/widgets/buttons/app_soft_danger_button.dart';
import 'core/theme/light_theme.dart' as LightTheme;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taskora',
      debugShowCheckedModeBanner: false,
      theme: LightTheme.lightTheme,
      home: const TestingScreen(),
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
          child: AppPrimaryIconButton(
            text: 'test',
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
