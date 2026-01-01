import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/color_manager.dart';
import '../../constants/app_sizes.dart';
import '../status_badge/AppStatusBadge.dart';

class AppTaskList extends StatelessWidget {
  const AppTaskList({
    super.key,
    required this.title,
    required this.subtitle,
    required this.stateBadge,
    this.sideColor = const Color(0xFF6C63FF),
    this.backgroundColor = const Color(0xFFEAF6F4),
    this.onTap,
  });

  final String title;
  final String subtitle;
  final TaskStateBadge stateBadge;

  final Color sideColor;
  final Color backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(BorderRadiusSize.borderRadius15),
          boxShadow: const [
            BorderRadiusSize.liteBoxShadow
          ],
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 12,
                decoration: BoxDecoration(
                  color: sideColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(BorderRadiusSize.borderRadius15),
                    bottomRight: Radius.circular(BorderRadiusSize.borderRadius15),
                  ),
                ),
              ),
            ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding:
                  AppPadding.paddingH20_V10,
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     mainAxisSize: MainAxisSize.max,
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                        Flexible(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            subtitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: ColorManager.notActiveColor,
                              height: 1,
                            ),
                          ),
                        ),
                     ],
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.paddingHorizontal),
              child: AppStatusBadge.state(state: stateBadge),
            ),
            ],
           ),
          ],
        ),
      ),
    );
  }
}
