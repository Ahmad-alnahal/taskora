import 'package:flutter/material.dart';
import '../../constants/image_path.dart';

enum AppLogoVariant { splash, auth, custom }

class AppLogo extends StatelessWidget {
  const AppLogo.splash({super.key})
      : variant = AppLogoVariant.splash,
        size = null;

  const AppLogo.auth({super.key})
      : variant = AppLogoVariant.auth,
        size = null;

  const AppLogo.custom({super.key, required this.size})
      : variant = AppLogoVariant.custom;

  final AppLogoVariant variant;
  final double? size;

  double _resolvedSize() {
    switch (variant) {
      case AppLogoVariant.splash:
        return 379;
      case AppLogoVariant.auth:
        return 226;
      case AppLogoVariant.custom:
        return size!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = _resolvedSize();

    return Image.asset(
      ImagePath.appLogoWithNoBackground,
      width: s,
      height: s,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
    );
  }
}
