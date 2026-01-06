import 'package:flutter/material.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_strings.dart';
import 'app_logo.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
  });



  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [

          const Positioned(
            top: 0,
            child: AppLogo.auth(),
          ),

          Positioned(
            top: 190,
            child: Column(
              children: [
                Text(
                  LoginStrings.loginApp,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),
                Text(
                  LoginStrings.welcomeToLoginApp,
                  textAlign: TextAlign.center,
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
