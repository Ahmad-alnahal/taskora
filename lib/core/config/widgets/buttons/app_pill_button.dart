import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/app_sizes.dart';
import '../../constants/color_manager.dart';
import 'app_button_base.dart';

class AppPillButton extends StatelessWidget {
  const AppPillButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AppButtonBase(
      onPressed: onPressed,
      isLoading: isLoading,
      radius: BorderRadiusSize.borderRadiusPill,
      padding: AppButtonsSizes.buttonHorizontalPadding,
      backgroundColor: ColorManager.secondaryColor,
      foregroundColor: Colors.white,
      child: Text(text),
    );
  }
}
