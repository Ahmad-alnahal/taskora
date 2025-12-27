import 'package:flutter/material.dart';
import 'core/config/widgets/Cards/ProjectProgressCard.dart';
import 'core/theme/light_theme.dart' as LightTheme;

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
          child:SizedBox(
            child: ProjectProgressCard(
              title: 'تطبيق التجارة الإلكترونية',
              company: 'شركة التقنية الحديثة',
              progress: 0.6, // مثال
              tasksText: '12/24 مهمة',
              hoursText: '80/45 ساعة',

            )
          ),
        ),
      ),
    );
  }
}
