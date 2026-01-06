import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/color_manager.dart';
import '../../../theme/app_text_theme.dart';
import '../../constants/app_sizes.dart';
import 'AppCustomCard.dart';

enum CustomInfoCardType { info, warning }

class CustomInfoCard extends StatelessWidget {
  const CustomInfoCard({
    super.key,
    required this.title,
    required this.description,
    this.type = CustomInfoCardType.info,
    this.onTap,
    this.margin = const EdgeInsets.symmetric(horizontal: AppPadding.padding16),
  });

  final String title;
  final String description;
  final CustomInfoCardType type;
  final VoidCallback? onTap;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    final bool isWarning = type == CustomInfoCardType.warning;

    final Color accent = isWarning ? ColorManager.priorityHighRedColor : ColorManager.secondaryColor;
    final Color border = isWarning ? ColorManager.priorityHighRedColor : ColorManager.primaryColor;




    return AppCustomCard(
      width: double.infinity,
      height: 0,
      onTap: onTap,
      margin: margin,
      radius: BorderRadiusSize.borderRadius15,

      borderColor: border,
      padding: AppPadding.paddingAll10,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accent, width: 5),
            ),
            child: Center(
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: SizedBoxSizes.sizedBoxSmallWidth),
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextTheme.lightTextTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isWarning ? accent : const Color(0xFF2B2B2B),
                      height: 1.25,
                    ),
                  ),
                  SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),
                  Text(
                    description,
                    style: AppTextTheme.lightTextTheme.bodyMedium!.copyWith(
                      color: Color(0xFF8A8A8A),
                      height: 1.25
                      )
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