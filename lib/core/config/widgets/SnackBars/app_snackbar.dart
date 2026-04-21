import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/app_sizes.dart';
import 'package:taskora/core/theme/app_text_theme.dart';
import '../../constants/color_manager.dart';


enum AppSnackBarType { success, error, warning, info }

class AppSnackBar {
  AppSnackBar._();

  static void show(
      BuildContext context, {
        required String message,
        AppSnackBarType type = AppSnackBarType.success,
        Duration duration = const Duration(seconds: 2),
        bool clearPrevious = true,
      }) {
    final style = _SnackStyle.from(type);

    final messenger = ScaffoldMessenger.of(context);
    if (clearPrevious) messenger.clearSnackBars();

    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        duration: duration,
        content: _SnackContent(
          message: message,
          bgColor: style.bg,
          icon: style.icon,
        ),
      ),
    );
  }
}

class _SnackContent extends StatelessWidget {
  const _SnackContent({
    required this.message,
    required this.bgColor,
    required this.icon,
  });

  final String message;
  final Color bgColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(BorderRadiusSize.borderRadius15),
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(BorderRadiusSize.borderRadiusPill),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: bgColor,
                size: 20,
              ),
            ),
            const SizedBox(width: SizedBoxSizes.sizedBoxSmallWidth),
            Expanded(
              child: Text(
                message,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: SnackBarTextTheme.messageStyle
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SnackStyle {
  final Color bg;
  final IconData icon;
  const _SnackStyle({required this.bg, required this.icon});

  factory _SnackStyle.from(AppSnackBarType type) {
    switch (type) {
      case AppSnackBarType.success:
        return const _SnackStyle(
          bg: ColorManager.secondaryColor,
          icon: Icons.check_rounded,
        );

      case AppSnackBarType.error:
        return const _SnackStyle(
          bg: ColorManager.priorityHighRedColor,
          icon: Icons.close_rounded,
        );

      case AppSnackBarType.warning:
        return const _SnackStyle(
          bg: ColorManager.priorityMediumColor,
          icon: Icons.warning_rounded,
        );

      case AppSnackBarType.info:
        return const _SnackStyle(
          bg: ColorManager.priorityLowColor,
          icon: Icons.info_rounded,
        );
    }
  }
}
