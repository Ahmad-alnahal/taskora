import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/color_manager.dart';

import '../../../theme/app_text_theme.dart';
import '../../constants/app_sizes.dart';
import '../status_badge/AppStatusBadge.dart';

class AppTaskList extends StatelessWidget {
  const AppTaskList({
    super.key,
    required this.title,
    required this.subtitle,
    required this.stateBadge,
    this.sideColor = const Color(0xFF6C63FF), // الشريط البنفسجي يمين
    this.backgroundColor = const Color(0xFFEAF6F4), // mint
    this.onTap,
  });

  final String title;
  final String subtitle;
  final TaskStateBadge stateBadge;

  final Color sideColor;
  final Color backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(BorderRadiusSize.borderRadius15),
          boxShadow: const [
            BorderRadiusSize.liteBoxShadow
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 12,
                decoration: BoxDecoration(
                  color: sideColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(BorderRadiusSize.borderRadius15),
                    bottomRight: Radius.circular(BorderRadiusSize.borderRadius15),
                  ),
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style:Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      maxLines: 1,
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorManager.notActiveColor,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
                AppStatusBadge.state(state: stateBadge),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
