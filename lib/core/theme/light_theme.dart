import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:taskora/core/config/constants/app_sizes.dart';
import 'package:taskora/core/config/constants/color_manager.dart';

abstract class AppFontFamily {
  static const String tajawal = 'Tajawal';
}

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: AppFontFamily.tajawal,

  colorScheme: ColorScheme.light(
    primary: ColorManager.primaryColor,
    secondary: ColorManager.secondaryColor,
    surface: ColorManager.backgroundColor,
    background: ColorManager.backgroundColor,
    error: ColorManager.priorityHighColor,

    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: ColorManager.textPrimaryColor,
    onBackground: ColorManager.textPrimaryColor,
    onError: Colors.white,
  ),

  scaffoldBackgroundColor: ColorManager.backgroundColor,

  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: ColorManager.backgroundColor,
    foregroundColor: ColorManager.textPrimaryColor,
    centerTitle: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: ColorManager.backgroundColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: ColorManager.backgroundColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: ColorManager.secondaryColor,
      foregroundColor: Colors.white,
      padding: EdgeInsets.zero,
      minimumSize: const Size(double.infinity, 46),
      maximumSize: const Size(double.infinity, 49),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(BorderRadiusSize.borderRadius),
        ),
      ),
      textStyle: const TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
    ),
  ),

  dividerTheme: const DividerThemeData(
    color: ColorManager.dividerColor,
    thickness: 1,
    space: 1,
  ),
);
