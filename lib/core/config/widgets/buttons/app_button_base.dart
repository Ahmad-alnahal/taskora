import 'package:flutter/material.dart';
import '../../constants/app_sizes.dart';

class AppButtonBase extends StatelessWidget {
  const AppButtonBase({
    super.key,
    required this.onPressed,
    required this.child,
    required this.backgroundColor,
    required this.foregroundColor,
    this.borderColor,
    this.height = AppButtonsSizes.buttonDefaultHeight,
    this.fullWidth = true,
    this.radius,
    this.padding = const EdgeInsets.symmetric(horizontal: AppButtonsSizes.buttonPaddingHorizontal),
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final Widget child;

  final Color backgroundColor;
  final Color foregroundColor;
  final Color? borderColor;

  final double height;
  final bool fullWidth;
  final double? radius;
  final EdgeInsets padding;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final r = radius ?? BorderRadiusSize.borderRadius;

    final button = ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size(50, height),
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(r),
          side: borderColor == null ? BorderSide.none : BorderSide(color: borderColor!, width: 1),
        ),
        textStyle: Theme.of(context).textTheme.labelLarge,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Center(
          child: isLoading
              ? const SizedBox(
            width: SizedBoxSizes.sizedBoxMediumWidth,
            height: SizedBoxSizes.sizedBoxMediumHeight,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
              : child,
        ),
      ),

    );

    return fullWidth ? SizedBox(width: double.infinity, child: button) : button;
  }
}
