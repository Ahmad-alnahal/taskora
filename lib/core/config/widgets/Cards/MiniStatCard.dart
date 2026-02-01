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
        padding: EdgeInsets.zero,
        width: 0,
        height: 0,
        onTap: onTap,
        radius: 16,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 24, color: accentColor),
              SizedBox(height: 8,),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  height: 1
                ),
              ),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: accentColor,
                  height: 1
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
