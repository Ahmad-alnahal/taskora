import 'package:flutter/material.dart';
import '../../constants/app_sizes.dart';
import 'AppCustomCard.dart';

class AppDashboardCard extends StatelessWidget {
  const AppDashboardCard({
    super.key,
    required this.title,
    required this.amountText,
    this.onTap,
    this.accentColor = const Color(0xFF0F7A6B),
  });

  final String title;
  final String amountText;
  final VoidCallback? onTap;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return AppCustomCard(
      onTap: onTap,
      radius: 18,
      padding: const EdgeInsets.only(top: 20),
      badge: _CornerMoneyBadge(color: accentColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight,),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              height: 1.2,
            ),
          ),
          const SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),
          Text(
            amountText,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: accentColor,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}


class _CornerMoneyBadge extends StatelessWidget {
  const _CornerMoneyBadge({required this.color});

  final Color color;

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
              color: color.withValues(alpha:0.08  ),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(BorderRadiusSize.borderRadiusCircular)),
            ),
          ),
        ),


        Positioned(
          top: 10,
          right: 14,
          child: Icon(
            Icons.attach_money_rounded,
            size: 30,
            color: color,
          ),
        ),
      ],
    );
  }
}
