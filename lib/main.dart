import 'package:flutter/material.dart';
import 'core/config/widgets/Cards/ProjectProgressCard.dart';
import 'core/config/widgets/status_badge/AppStatusBadge.dart';
import 'core/config/widgets/tasks_list/AppTaskList.dart';
import 'core/config/widgets/tasks_list/AppTaskListTile.dart';
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTaskListTile(
              title: 'المهام القادمة',
              type: TaskTileType.alert,
            ),
            SizedBox(height: 10,),
            AppTaskList(
              title: 'تصميم واجهة المستخدم',
              subtitle: 'تطبيق التجارة',
              stateBadge: TaskStateBadge.inProgress,
              sideColor: const Color(0xFF6C63FF),
            )
          ],

        ),
      ),
    );
  }
}
