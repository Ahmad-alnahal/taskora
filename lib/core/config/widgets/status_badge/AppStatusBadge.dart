import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/color_manager.dart';

import '../../constants/app_sizes.dart';
import '../../constants/app_strings.dart';



enum TaskStateBadge { inProgress, toDo }
enum TaskPriorityBadge { high, medium, low }

class AppStatusBadge extends StatelessWidget {
  const AppStatusBadge.state({
    super.key,
    required this.state,
    this.padding = AppPadding.paddingH12_V6,
  }) : priority = null;

  const AppStatusBadge.priority({
    super.key,
    required this.priority,
    this.padding = AppPadding.paddingH12_V6,
  }) : state = null;

  final TaskStateBadge? state;
  final TaskPriorityBadge? priority;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final config = _config();

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: ColorManager.stateBadgeColor,
        borderRadius: BorderRadius.circular(BorderRadiusSize.borderRadiusPill),
      ),
      child: Text(
        config.text,
        style: TextStyle(
          color: config.tC,
          fontSize: 13,
          fontWeight: FontWeight.w500,
          height: 1,
        ),
      ),
    );
  }
  _BadgeConfig _config() {
    if (state != null) {
      switch (state!) {
        case TaskStateBadge.inProgress:
          return _BadgeConfig(
            text: StatusBadgeStrings.inProgress,
            tC: ColorManager.priorityHighRedColor,
          );
        case TaskStateBadge.toDo:
          return _BadgeConfig(
            text: StatusBadgeStrings.toDo,
            tC: ColorManager.priorityHighRedColor,
          );
      }
    }
    switch (priority!) {
      case TaskPriorityBadge.high:
        return _BadgeConfig(
          text: StatusBadgeStrings.high,
          tC: ColorManager.priorityHighRedColor,
        );
      case TaskPriorityBadge.medium:
        return _BadgeConfig(
          text: StatusBadgeStrings.medium,
          tC: ColorManager.priorityBadgeMedium,
        );
      case TaskPriorityBadge.low:
        return _BadgeConfig(
          text: StatusBadgeStrings.low,
          tC: ColorManager.priorityBadgeLow,
        );
    }
  }
}

class _BadgeConfig {
  final String text;
  final Color tC;
  _BadgeConfig({required this.text, required this.tC});
}
