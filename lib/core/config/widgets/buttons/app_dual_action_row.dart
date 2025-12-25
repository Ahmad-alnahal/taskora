import 'package:flutter/material.dart';
import 'app_outlined_danger_button.dart';
import 'app_primary_icon_button.dart';


class AppDualActionRow extends StatelessWidget {
  const AppDualActionRow({
    super.key,
    required this.leftText,
    required this.rightText,
    required this.onLeftPressed,
    required this.onRightPressed,
  });

  final String leftText;
  final String rightText;
  final VoidCallback? onLeftPressed;
  final VoidCallback? onRightPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppOutlinedDangerButton(
            text: leftText,
            onPressed: onLeftPressed,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AppPrimaryIconButton(
            text: rightText,
            onPressed: onRightPressed,
          ),
        ),
      ],
    );
  }
}
