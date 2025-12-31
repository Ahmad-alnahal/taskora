import 'package:flutter/material.dart';

class AppIconText extends StatelessWidget {
  const AppIconText({
    super.key,
    required this.text,
    this.icon,
    this.iconOnLeft = true,
    this.gap = 6,
    this.iconSize = 16,
    this.textStyle,
    this.iconColor,
    this.mainAxisSize = MainAxisSize.min,
  });

  final String text;
  final IconData? icon;

  /// true => [Icon][Text]  | false => [Text][Icon]
  final bool iconOnLeft;

  final double gap;
  final double iconSize;
  final TextStyle? textStyle;
  final Color? iconColor;
  final MainAxisSize mainAxisSize;

  @override
  Widget build(BuildContext context) {


    final iconWidget = icon == null
        ? null
        : Icon(icon, size: iconSize, color: iconColor);

    if (iconWidget == null) {
      return Text(text,
        style: TextStyle(
            fontSize: 16,
            height: 1,
            fontWeight: FontWeight.w400)
      );
    }

    final children = <Widget>[
      iconWidget,
      SizedBox(width: gap),
      Text(text,
        style: TextStyle(
            fontSize: 16,
            height: 1,
            fontWeight: FontWeight.w400)
      ),
    ];

    return Row(
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: iconOnLeft ? children : children.reversed.toList(),
    );
  }
}
