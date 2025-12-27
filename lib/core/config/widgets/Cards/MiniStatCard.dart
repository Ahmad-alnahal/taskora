import 'package:flutter/material.dart';

import 'AppCustomCard.dart';

class MiniStatCard extends StatelessWidget {
  const MiniStatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
    this.width = 102,
    this.height = 87,
    this.accentColor = const Color(0xFF0F7A6B),
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  final double width;
  final double height;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: AppCustomCard(
        onTap: onTap,
        radius: 16,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), // ✅ مهم
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: accentColor),
            const SizedBox(height: 4),

            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                height: 1.0,
              ),
            ),
            const SizedBox(height: 2),

            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: accentColor,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
