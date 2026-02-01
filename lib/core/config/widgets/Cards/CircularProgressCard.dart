import 'dart:math';
import 'package:flutter/material.dart';

import '../../constants/color_manager.dart';

class CircularProgressCard extends StatefulWidget {
  const CircularProgressCard({
    super.key,
    required this.value,
    this.label = 'الإنجاز',
    this.size = 120,
    this.duration = const Duration(milliseconds: 900),
  });

  final double value;
  final String label;
  final double size;
  final Duration duration;

  @override
  State<CircularProgressCard> createState() => _CircularProgressCardState();
}

class _CircularProgressCardState extends State<CircularProgressCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _anim;

  double _last = 0;

  @override
  void initState() {
    super.initState();

    _last = widget.value.clamp(0, 100).toDouble();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _anim = Tween<double>(begin: 0, end: _last).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    )..addListener(() => setState(() {}));

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant CircularProgressCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    final newValue = widget.value.clamp(0, 100).toDouble();
    if (newValue == _last) return;

    _anim = Tween<double>(begin: _anim.value, end: newValue).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    )..addListener(() => setState(() {}));

    _last = newValue;

    _controller
      ..reset()
      ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shownValue = _anim.value.clamp(0, 100).toDouble();

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _GradientCircularPainter(progress: shownValue / 100),
          ),


          Positioned.fill(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${shownValue.round()}%',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF4A4A4A),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.label,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6A6A6A),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientCircularPainter extends CustomPainter {
  _GradientCircularPainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 10.0;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - strokeWidth / 2;

    // Track
    final trackPaint = Paint()
      ..color = const Color(0xFFDDE7E1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    if (progress <= 0) return;

    // Progress
    final startAngle = -pi / 2;
    final sweepAngle = 2 * pi * progress;

    final gradient = SweepGradient(
      transform: const GradientRotation(-pi / 2),
      startAngle: 0,
      endAngle: sweepAngle,
      colors: const [
        ColorManager.primary100,
        ColorManager.primaryColor,
        ColorManager.secondaryColor,
      ],
      stops: const [0.0, 0.5, 1.0],
    );

    final progressPaint = Paint()
      ..shader = gradient.createShader(
        Rect.fromCircle(center: center, radius: radius),
      )
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );

    // End dot (only at end)
    final endAngle = startAngle + sweepAngle;
    final endOffset = Offset(
      center.dx + radius * cos(endAngle),
      center.dy + radius * sin(endAngle),
    );

    final endDotPaint = Paint()
      ..color =  ColorManager.secondaryColor
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(endOffset, strokeWidth * 0, endDotPaint);
  }

  @override
  bool shouldRepaint(covariant _GradientCircularPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
