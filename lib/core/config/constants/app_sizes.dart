import 'package:flutter/material.dart';

class AppPadding {
  AppPadding._();
  static const double paddingHorizontal = 16;
  static const EdgeInsets paddingAll10 = EdgeInsets.all(10);
  static const EdgeInsets paddingAll16 = EdgeInsets.all(16);
  static const EdgeInsets paddingAll50 = EdgeInsets.all(50);
  static const EdgeInsets paddingH12_V6 =  EdgeInsets.symmetric(horizontal: 12,vertical: 6);
  static const EdgeInsets paddingH20_V10 =  EdgeInsets.symmetric(horizontal: 20, vertical: 10);
}
class AppButtonsSizes {
  AppButtonsSizes._();

  static const double buttonPaddingHorizontal = 16;
  static const double buttonDefaultHeight = 49;
  static const double buttonSmallHeight = 28;
  static  EdgeInsets buttonHorizontalPadding = EdgeInsets.symmetric(horizontal: buttonPaddingHorizontal);

}
class AppIconsSizes {
  AppIconsSizes._();

  static const double iconsDefaultSize = 18;
}
class SizedBoxSizes{
  SizedBoxSizes._();

  static const double sizedBoxXXLargeHeight = 100;
  static const double sizedBoxXLargeHeight = 50;
  static const double sizedBoxLargeHeight = 35;
  static const double sizedBoxMediumHeight = 22;
  static const double sizedBoxSmallHeight = 8;
  static const double sizedBoxLargeWidth = 35;
  static const double sizedBoxMediumWidth = 20;
  static const double sizedBoxSmallWidth = 8;
  static const double sizedBoxHeight16 = 16;
}
class SplashLogoSizes{
  SplashLogoSizes._();

  static const double splashLogoVertical = 379;
  static const double splashLogoHorizontal = 379;
}
class BorderRadiusSize {
  BorderRadiusSize._();
  static const double borderRadius10 = 10;
  static const double borderRadius15 = 15;
  static const double borderRadius18 = 18;
  static const double borderRadiusCircular = 25;
  static const double borderRadiusCircular22 = 22;
  static const double borderRadiusLogo = 50;
  static const double borderRadiusPill = 999;

  static const BoxShadow liteBoxShadow = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 16,
    offset: Offset(0, 10),
  );
}