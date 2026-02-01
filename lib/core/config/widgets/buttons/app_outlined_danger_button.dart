import 'package:flutter/material.dart';
import '../../constants/color_manager.dart';
import 'app_button_base.dart';

class AppOutlinedDangerButton extends StatelessWidget {
  const AppOutlinedDangerButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppButtonBase(
      onPressed: onPressed,
      backgroundColor: Colors.transparent,
      foregroundColor: ColorManager.priorityHighColor,
      borderColor: ColorManager.priorityHighColor,
      child: Text(text),
    );
  }
}
