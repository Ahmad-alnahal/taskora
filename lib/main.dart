import 'package:flutter/material.dart';
import 'core/config/widgets/AlertDialogs/AppAlertDialog.dart';
import 'core/config/widgets/Cards/CircularProgressCard.dart';
import 'core/config/widgets/Cards/CustomInfoCard.dart';
import 'core/config/widgets/buttons/app_primary_icon_button.dart';
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
        child: Align(
          alignment: Alignment.center,
          child: CustomInfoCard(
            type: CustomInfoCardType.info,
            title: 'حالة المهمة',
            description: 'المهام الجديدة يتم ضبطها تلقائياً على قيد التنفيذ دائماً، يمكنك تحديث الحالة بعد الإنشاء من واجهة المشروع أو تفاصيل المهمة.',
          ),
        ),
      ),
    );
  }
}
