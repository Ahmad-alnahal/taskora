import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/app_sizes.dart';
import '../../constants/color_manager.dart';
import 'app_button_base.dart';
import '../Texts/app_icon_text.dart';

class AppChipButton extends StatelessWidget {
  const AppChipButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isIconOnLeft = true,
    this.icon,
  });

  final String text;
  final VoidCallback? onPressed;
  final Icon? icon;
  final bool isIconOnLeft;


  @override
  Widget build(BuildContext context) {
    return AppButtonBase(
      onPressed: onPressed,
      fullWidth: false,
      height: AppButtonsSizes.buttonSmallHeight,
      radius: BorderRadiusSize.borderRadiusPill,
      padding:EdgeInsets.zero,
      backgroundColor: ColorManager.secondaryColor,
      foregroundColor: Colors.white,
      child:  AppIconText(
      text: text,
      icon: icon?.icon,          
      iconOnLeft: isIconOnLeft,
      iconSize: AppIconsSizes.iconsDefaultSize,

    ),

    );
  }
}
