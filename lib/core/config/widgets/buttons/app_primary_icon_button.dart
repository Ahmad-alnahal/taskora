import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/app_sizes.dart';
import '../../constants/color_manager.dart';
import 'app_button_base.dart';

class AppPrimaryIconButton extends StatelessWidget {
  const AppPrimaryIconButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.buttonColor,
  });

  final String text;
  final VoidCallback? onPressed;
  final Icon? icon;
  final bool isLoading;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return AppButtonBase(

      onPressed: onPressed,
      isLoading: isLoading,
      backgroundColor:buttonColor != null ? buttonColor!: ColorManager.secondaryColor,
      foregroundColor: buttonColor != null ? ColorManager.secondaryColor: Colors.white,
      borderColor: buttonColor != null ? ColorManager.notActiveColor : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(text),
          if (icon != null) ...[
            Icon(icon!.icon, size: AppIconsSizes.iconsDefaultSize),
            const SizedBox(width: SizedBoxSizes.sizedBoxSmallWidth),
          ],
        ],
      ),
    );
  }
}
