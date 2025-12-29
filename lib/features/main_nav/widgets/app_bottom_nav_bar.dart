import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskora/core/config/constants/icon_path.dart';
import '../../../core/config/constants/app_sizes.dart';
import '../../../core/config/constants/app_strings.dart';
import '../../../core/config/constants/color_manager.dart';
import '../main_nav_bloc.dart';
import '../main_nav_event.dart';
import '../main_nav_state.dart';


class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainNavBloc, MainNavState>(
      buildWhen: (p, c) => p.currentIndex != c.currentIndex,
      builder: (context, state) {
        return SafeArea(
          top: false,
          child: Container(
            padding:  AppPadding.paddingAll10,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(color: Colors.grey.shade200, width: 1),
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(BorderRadiusSize.borderRadiusCircular22),
                topRight: Radius.circular(BorderRadiusSize.borderRadiusCircular22),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x11000000),
                  blurRadius: 18,
                  offset: Offset(0, -6),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: _NavItem(
                    label: BottomNavBarStrings.home,
                    iconAssetsPath: IconPath.homeIcon,
                    isActive: state.currentIndex == 0,
                    onTap: () => context.read<MainNavBloc>().add(const MainNavTabChanged(0)),
                  ),
                ),

                Expanded(
                  child: _NavItem(
                    label: BottomNavBarStrings.projects,
                    iconAssetsPath: IconPath.projectsIcon,
                    isActive: state.currentIndex == 1,
                    onTap: () => context.read<MainNavBloc>().add(const MainNavTabChanged(1)),
                  ),
                ),
                Expanded(
                  child: _NavItem(
                    label: BottomNavBarStrings.profile,
                    iconAssetsPath: IconPath.profileIcon,
                    isActive: state.currentIndex == 2,
                    onTap: () => context.read<MainNavBloc>().add(const MainNavTabChanged(2)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.label,
    required this.iconAssetsPath,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final String iconAssetsPath;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const activeColor =ColorManager.secondaryColor;
    final color = isActive ? activeColor :ColorManager.bNBNAColor ;

    return InkWell(
      borderRadius: BorderRadius.circular(BorderRadiusSize.borderRadius18),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset( iconAssetsPath,width: 22,height: 22, color: color),
            const SizedBox(height:SizedBoxSizes.sizedBoxSmallHeight),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w400,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
