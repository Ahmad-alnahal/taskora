import 'package:flutter/material.dart';
import '../../constants/app_sizes.dart';
import 'AppCustomCard.dart';

class ProjectProgressCard extends StatelessWidget {
  const ProjectProgressCard({
    super.key,
    required this.title,
    required this.company,
    required this.progress,
    required this.tasksText,
    required this.hoursText,
    this.onCardTap,
    this.accentColor = const Color(0xFF0F7A6B),
  });

  final String title;
  final String company;
  final double progress;
  final String tasksText;
  final String hoursText;

  final VoidCallback? onCardTap;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 341,
      height: 148,
      child: AppCustomCard(
        radius: 18,
        child: InkWell(
          onTap: onCardTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        company,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          height: 1.2,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                 Icon(
                   Icons.arrow_forward_ios,
                        size: 18,
                        color: Colors.grey.shade600,
                 ),
                ],
              ),

              const SizedBox(height: 21),

              // Progress bar
              _ProgressPill(
                value: progress.clamp(0.0, 1.0),
                color: accentColor,
              ),

              const SizedBox(height: 12),

              // Bottom info row (tasks + hours)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _InfoItem(
                    icon: Icons.access_time_rounded,
                    text: hoursText,
                    iconBg: const Color(0xFFEFEFEF),
                    iconColor: Colors.grey.shade700,
                    textColor: Colors.grey.shade700,
                  ),
                  _InfoItem(
                    icon: Icons.check_circle_rounded,
                    text: tasksText,
                    iconBg: const Color(0xFFEFEFEF),
                    iconColor: Colors.grey.shade700,
                    textColor: Colors.grey.shade700,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class _ProgressPill extends StatelessWidget {
  const _ProgressPill({
    required this.value,
    required this.color,
  });

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(999),
      child: SizedBox(
        height: 8,
        child: LinearProgressIndicator(
          value: value,
          backgroundColor: const Color(0xFFEFEFEF),
          color: color,
        ),
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.icon,
    required this.text,
    required this.iconBg,
    required this.iconColor,
    required this.textColor,
  });

  final IconData icon;
  final String text;
  final Color iconBg;
  final Color iconColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 14, color: iconColor),
        ),
        const SizedBox(width: SizedBoxSizes.sizedBoxSmallWidth),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
