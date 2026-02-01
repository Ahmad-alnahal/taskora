import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/color_manager.dart';
import '../../constants/app_sizes.dart';
import 'AppCustomCard.dart';

class AppDashboardCard extends StatelessWidget {
  const AppDashboardCard({
    super.key,
    required this.title,
    required this.amountText,
    this.onTap,
    this.accentColor = const Color(0xFF0F7A6B),
    required this.icon,
  });

  final String title;
  final String amountText;
  final VoidCallback? onTap;
  final Color accentColor;
  final IconData icon;


  @override
  Widget build(BuildContext context) {
    return AppCustomCard(
      height: 126,
      width: 160,
      onTap: onTap,
      radius: 18,
      padding: const EdgeInsets.only(top: 20),
      badge: _CornerMoneyBadge(color: accentColor, icon: icon,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight,),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            amountText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: accentColor,
            ),
          ),
        ],
      ),
    );
  }
}


class _CornerMoneyBadge extends StatelessWidget {
  const _CornerMoneyBadge({required this.color, required this.icon});

  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -1,
          right: -1,
          child: Container(
            width: 69,
            height: 46,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Color(0xFFD1EFEA),
                    Color(0xFF96D2C8),
                   ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).withOpacity(0.2),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(BorderRadiusSize.borderRadiusCircular)),
            boxShadow: [
              BoxShadow(
              color: ColorManager.notActiveColor.withValues(alpha: 0.2),
              offset: Offset(0, 8),
              blurRadius: 8,
            )],
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 14,
          child: Icon(icon,
            size: 30,
            color: color,
          ),
        ),
      ],
    );
  }
}
