import 'package:flutter/material.dart';
import '../config/constants/color_manager.dart';

class AppTextTheme {
  AppTextTheme._();


  static TextTheme lightTextTheme = const TextTheme(

    /// Header 1
    headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700, height: 1.25),

    /// Header 2
    headlineMedium: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, height: 1.23),

    /// Header 3
    headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, height: 1.40),

    /// Subtitle
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, height: 1.44),

    /// Body
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, height: 1.625),

    /// Optional secondary body
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, height: 1.50),

    /// Caption
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, height: 1.67),

    /// Button Text
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, height: 1.25),
  );

  static TextTheme applyTextColors(TextTheme base) {
    return base.apply(
      bodyColor: ColorManager.textPrimaryColor,
      displayColor: ColorManager.textPrimaryColor,
    );
  }
}
class AppButtonTextStyles {
  AppButtonTextStyles._();
  static const primary = TextStyle(fontSize: 16, fontWeight: FontWeight.w700, height: 1.25);
  static const small   = TextStyle(fontSize: 14, fontWeight: FontWeight.w700, height: 1.25);
}
class OnboardingTextTheme {
  OnboardingTextTheme._();
  static const title = TextStyle(color: ColorManager.primaryColor,fontSize: 20,fontWeight: FontWeight.w700);
  static const description = TextStyle(fontSize: 18,fontWeight: FontWeight.w400);

}
class BottomSheetTextTheme {
  BottomSheetTextTheme._();
  static const message = TextStyle(
    fontSize: 22,
    fontStyle: FontStyle.italic,
    fontWeight: FontWeight.w500,
  );
  static const description = TextStyle(fontSize: 18,fontWeight: FontWeight.w400);

}