import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:taskora/core/config/constants/app_sizes.dart';
import 'package:taskora/core/config/constants/color_manager.dart';

import 'app_text_theme.dart';

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

  textTheme: AppTextTheme.applyTextColors(AppTextTheme.lightTextTheme),

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
      textStyle: AppTextTheme.lightTextTheme.labelLarge,
    ),
  ),

  dividerTheme: const DividerThemeData(
    color: ColorManager.dividerColor,
    thickness: 1,
    space: 1,
  ),

  ///  Dashboard Cards
  cardTheme: CardThemeData(
    elevation: 0,
    color: Colors.white,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(BorderRadiusSize.borderRadiusCircular),
  ),),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    hintStyle: AppTextTheme.lightTextTheme.bodyMedium?.copyWith(
      color: ColorManager.statusColor,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(BorderRadiusSize.borderRadius),
      borderSide: const BorderSide(color: ColorManager.dividerColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(BorderRadiusSize.borderRadius),
      borderSide: const BorderSide(color: ColorManager.dividerColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(BorderRadiusSize.borderRadius),
      borderSide: const BorderSide(color: ColorManager.secondaryColor, width: 1.4),
    ),
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: ColorManager.backgroundColor,
    elevation: 0,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: ColorManager.secondaryColor,
    unselectedItemColor: ColorManager.statusColor,
  ),

);
