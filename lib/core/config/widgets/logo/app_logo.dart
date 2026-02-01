import 'package:flutter/material.dart';
import '../../constants/image_path.dart';

enum AppLogoTypes { splash, auth, custom }

class AppLogo extends StatelessWidget {
  const AppLogo.splash({super.key})
      : types = AppLogoTypes.splash,
        size = null;

  const AppLogo.auth({super.key})
      : types = AppLogoTypes.auth,
        size = null;

  const AppLogo.custom({super.key, required this.size})
      : types = AppLogoTypes.custom;

  final AppLogoTypes types;
  final double? size;

  double _resolvedSize() {
    switch (types) {
      case AppLogoTypes.splash:
        return 379;
      case AppLogoTypes.auth:
        return 226;
      case AppLogoTypes.custom:
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
