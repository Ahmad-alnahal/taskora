import 'package:flutter/material.dart';

import '../../constants/app_sizes.dart';
import '../../constants/color_manager.dart';

class AppCustomCard extends StatelessWidget {
  const AppCustomCard({
    super.key,
    required this.child,
    this.onTap,
    this.radius = BorderRadiusSize.borderRadius15,
    this.padding = AppPadding.paddingAll16,
    this.margin = EdgeInsets.zero,
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFEDEDED),
    this.shadowColor = ColorManager.statusColor,
    this.shadowBlur = 18,
    this.shadowOffset = const Offset(0, 8),
    this.badge,
    this.badgeAlignment = Alignment.topRight,
    this.clipBehavior = Clip.antiAlias,
    required this.width,
    required this.height,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double radius;
  final EdgeInsets padding;

  final Color backgroundColor;
  final Color borderColor;

  final Color shadowColor;
  final double shadowBlur;
  final Offset shadowOffset;
  final Widget? badge;
  final Alignment badgeAlignment;
  final EdgeInsets margin;
  final Clip clipBehavior;
  final double width;
  final double height;


  @override
  Widget build(BuildContext context) {
    final r = BorderRadius.circular(radius);

    return Container(

      width: width == 0 ? null :width,
      height:height == 0 ? null : height,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: r,
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: shadowBlur,
            offset: shadowOffset,
          ),
        ],
      ),
      child: Material(
        color: backgroundColor,
        borderRadius: r,
        clipBehavior: clipBehavior,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: r,
              border: Border.all(color: borderColor, width: 1),
            ),
            child: Stack(
              clipBehavior: clipBehavior,
              children: [
                Padding(
                  padding: padding,
                  child: child,
                ),

                if (badge != null)
                  Align(
                    alignment: badgeAlignment,
                    child: badge!,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
