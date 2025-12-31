import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/color_manager.dart';

import '../../constants/app_sizes.dart';

enum AppProgressType { linear, dotted }

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({
    super.key,
    required this.value,
    this.type = AppProgressType.linear,
    this.isRTL = true,
    this.height = 10,
    this.radius = BorderRadiusSize.borderRadiusPill,
    this.trackColor = ColorManager.dividerColor,
    this.fillColor = ColorManager.secondaryColor,

    this.gradient,
    this.dotSize = 3,
    this.dotSpacing = 12,
    this.dotColor = ColorManager.dotColor,
    this.upperLimit = 100.0,
  });

  final double value;
  final AppProgressType type;
  final bool isRTL;
  final double height;
  final double radius;
  final Color trackColor;
  final Color fillColor;
  final Gradient? gradient;
  final double dotSize;
  final double dotSpacing;
  final Color dotColor;
  final  double? upperLimit ;

  @override
  Widget build(BuildContext context) {
    final v = value.isNaN ? 0.0 : value.clamp(0.0, upperLimit!);
    final fill = _resolveFillGradientOrNull();
    return LayoutBuilder(
      builder: (context, c) {
        return CustomPaint(
          size: Size(c.maxWidth, height),
          painter: _AppProgressPainter(
            value: v,
            type: type,
            isRTL: isRTL,
            height: height,
            radius: radius,
            trackColor: trackColor,
            fillColor: fillColor,
            fillGradient: fill,
            dotSize: dotSize,
            dotSpacing: dotSpacing,
            dotColor: dotColor,
            upperLimit : upperLimit!,
          ),
        );
      },
    );
  }
  Gradient? _resolveFillGradientOrNull() {

    return gradient ??
        const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorManager.secondaryColor,
            ColorManager.primaryColor,
          ],
        );
  }
}

class _AppProgressPainter extends CustomPainter {
  _AppProgressPainter({
    required this.value,
    required this.type,
    required this.isRTL,
    required this.height,
    required this.radius,
    required this.trackColor,
    required this.fillColor,
    required this.fillGradient,
    required this.dotSize,
    required this.dotSpacing,
    required this.dotColor,
    required this.upperLimit,
  });
  final double value;
  final AppProgressType type;
  final bool isRTL;
  final double height;
  final double radius;
  final Color trackColor;
  final Color fillColor;
  final Gradient? fillGradient;
  final double dotSize;
  final double dotSpacing;
  final Color dotColor;
  final  double upperLimit;
  @override
  void paint(Canvas canvas, Size size) {
    final r = Radius.circular(math.min(radius, height / 2));
    final trackRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, height),
      r,
    );
    final trackPaint = Paint()..color = trackColor;
    canvas.drawRRect(trackRect, trackPaint);
    final progressW = (size.width * (value / upperLimit)).clamp(0.0, size.width);
    final double fillLeft = isRTL ? (size.width - progressW) : 0.0;
    if (progressW > 0) {
      final fillRect = RRect.fromRectAndRadius(
        Rect.fromLTWH(fillLeft, 0, progressW, height),
        r,
      );
      final fillPaint = Paint()
        ..color = fillColor
        ..isAntiAlias = true;
      if (fillGradient != null) {
        final Gradient g =  fillGradient!;
        fillPaint.shader = g.createShader(
          Rect.fromLTWH(fillLeft, 0, progressW, height),
        );
      }
      canvas.drawRRect(fillRect, fillPaint);
    }
    if (type == AppProgressType.dotted) {
      _paintDots(canvas, size, progressW);
    }
  }
  void _paintDots(Canvas canvas, Size size, double progressW) {
    final cy = height / 2;
    final dotR = dotSize ;
    final paint = Paint()
      ..color = dotColor
      ..isAntiAlias = true;
    double x = height ;
    final maxX = size.width - height / 3;
    final fillStartX = isRTL ? (size.width - progressW) : 0.0;
    final fillEndX = isRTL ? size.width : progressW;

    while (x <= maxX) {
      final bool insideFill = x >= fillStartX && x <= fillEndX;
      if (!insideFill) {
        canvas.drawCircle(Offset(x, cy), dotR, paint);
      }
      x += dotSpacing;
    }
  }
  @override
  bool shouldRepaint(covariant _AppProgressPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.type != type ||
        oldDelegate.isRTL != isRTL ||
        oldDelegate.height != height ||
        oldDelegate.radius != radius ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.fillGradient != fillGradient ||
        oldDelegate.dotSize != dotSize ||
        oldDelegate.dotSpacing != dotSpacing ||
        oldDelegate.dotColor != dotColor;
  }
}
