import 'package:flutter/material.dart';
import '../../constants/app_sizes.dart';
import '../../constants/color_manager.dart';
import 'app_button_base.dart';
import 'app_icon_text.dart';

class AppSoftDangerButton extends StatelessWidget {
  const AppSoftDangerButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isIconOnLeft = true,
    this.isWithBorderColor = false,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final Icon? icon;
  final bool isIconOnLeft;
  final bool isWithBorderColor;

  @override
  Widget build(BuildContext context) {
    return AppButtonBase(
      onPressed: onPressed,
      backgroundColor: ColorManager.priorityHighColor.withValues(alpha: 0.2),
      foregroundColor: ColorManager.priorityHighColor,
      borderColor:isWithBorderColor ?  ColorManager.priorityHighColor : null,
      child: AppIconText(
        text: text,
        icon: icon?.icon,
        iconOnLeft: isIconOnLeft,
        gap: SizedBoxSizes.sizedBoxSmallWidth,
        iconSize: AppIconsSizes.iconsDefaultSize,
      ),

    );
  }
}
