import 'package:flutter/material.dart';

class AppIconText extends StatelessWidget {
  const AppIconText({
    super.key,
    required this.text,
    this.icon,
    this.iconOnLeft = true,
    this.gap = 8,
    this.iconSize = 18,
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

    if (iconWidget == null) return Text(text);

    final children = <Widget>[
      iconWidget,
      SizedBox(width: gap),
      Text(text),
    ];

    return Row(
      mainAxisSize: mainAxisSize,
      children: iconOnLeft ? children : children.reversed.toList(),
    );
  }
}
