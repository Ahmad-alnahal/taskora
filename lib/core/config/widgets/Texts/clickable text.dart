import 'package:flutter/material.dart';

class ClickableText extends StatelessWidget {
  const ClickableText({
    super.key,
    required this.text,
    this.onTap,
    required this.padding,
    this.textStyle,
  });

  final String text;
  final EdgeInsetsGeometry padding;
  final TextStyle? textStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Text(
          text,
          style: textStyle
        ),
      ),
    );
  }
}
