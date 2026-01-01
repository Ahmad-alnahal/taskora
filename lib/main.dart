import 'package:flutter/material.dart';
import 'core/config/widgets/Cards/AppCustomCard.dart';
import 'core/config/widgets/buttons/app_soft_danger_button.dart';
import 'core/config/widgets/status_badge/AppStatusBadge.dart';
import 'core/config/widgets/tasks_list/AppTaskList.dart';
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
                SizedBox(
                    child: AppSoftDangerButton(
                      text: 'تسجيل خروج',
                      onPressed: () {  },
                      icon: Icon(Icons.logout),
                    )
                ),
                SizedBox(height: 20,),
                AppTaskList(
                  title: 'title',
                  subtitle: 'subtitlesubtitlesubtitlesubtitlesubtitlesubtitle',
                  stateBadge: TaskStateBadge.toDo,),
                SizedBox(height: 20,),

                AppCustomCard(width: double.infinity, height: 200, child: Text("subtitlesubtitlesubtitlesubtitlesubtitlesubtitlesubtitlesubtitlesubtitlesubtitlesubtitlesubtitle"),),
        

              ],
            ),
          ),
        ),
      ),
    );
  }
}
