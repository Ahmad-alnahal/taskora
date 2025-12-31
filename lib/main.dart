import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/app_strings.dart';
import 'package:taskora/core/config/constants/image_path.dart';
import 'core/config/widgets/Cards/AppCustomCard.dart';
import 'core/config/widgets/Cards/AppDashboardCard.dart';
import 'core/config/widgets/Cards/CircularProgressCard.dart';
import 'core/config/widgets/BottomSheets/AppBottomSheet.dart';
import 'core/config/widgets/Cards/CustomInfoCard.dart';
import 'core/config/widgets/Cards/MiniStatCard.dart';
import 'core/config/widgets/Cards/ProjectProgressCard.dart';
import 'core/config/widgets/ProgressIndicators/AppProgressIndicator.dart';
import 'core/config/widgets/SnackBars/app_snackbar.dart';
import 'core/config/widgets/buttons/app_primary_icon_button.dart';
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
          child: SizedBox(
            child: Column(spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProjectProgressCard(
                  title: 'تطبيق التجارة الإلكترونية',
                  company: 'شركة التقنية الحديثة',
                  progress: 50,
                  tasksText: '12/24 مهمة',
                  hoursText: '80/45 ساعة',

                ),
                AppProgressIndicator(
                  value: 90,
                  type: AppProgressType.linear,
                ),
                AppProgressIndicator(
                  value: 48,
                  type: AppProgressType.dotted,
                  dotColor: const Color(0xFF9FA0A8),

                  isRTL: false,
                ),
                AppProgressIndicator(
                  upperLimit: 50,
                  value: 5,
                  type: AppProgressType.dotted,

                  fillColor: const Color(0xFF3CCB6B),
                  dotColor: const Color(0xFF9FA0A8),
                  isRTL: false,
                )



              ],
            ),
          ),
        ),
      ),
    );
  }
}
