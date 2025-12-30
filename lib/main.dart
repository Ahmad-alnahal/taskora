import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/app_strings.dart';
import 'package:taskora/core/config/constants/image_path.dart';
import 'core/config/widgets/Cards/CircularProgressCard.dart';
import 'core/config/widgets/BottomSheets/AppBottomSheet.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircularProgressCard(
                value: 65,
                label: 'الإنجاز',
                size: 120,
                ),
                SizedBox(height: 20,),
                AppPrimaryIconButton(text: 'showSnackBar', onPressed: () {
                  AppBottomSheet.show(
                    context,
                    type: AppBottomSheetTypes.error,
                    message: AppBottomSheetStrings.uncompletedProcessTryAgain,
                    showBackButtons: true,
                    onBack: () => (){},
                    onRetry: () => (){},
                    errorImageAsset: ImagePath.errorImage
                  );
                },)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
