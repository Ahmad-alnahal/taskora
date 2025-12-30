import 'package:flutter/material.dart';
import 'package:taskora/core/config/constants/color_manager.dart';
import 'package:taskora/core/config/constants/image_path.dart';
import '../../../theme/app_text_theme.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_strings.dart';
import '../buttons/app_primary_icon_button.dart';

enum AppBottomSheetTypes { success, error }

class AppBottomSheet {
  static Future<T?> show<T>(
      BuildContext context, {
        required String message,
        AppBottomSheetTypes type = AppBottomSheetTypes.success,
        Duration autoCloseAfter = const Duration(seconds: 1),
        bool dismissible = false,
        String? title,
        String? description,
        String retryText = AppBottomSheetStrings.retry,
        String backText = AppBottomSheetStrings.back,
        VoidCallback? onRetry,
        VoidCallback? onBack,
        String? errorImageAsset,
        bool showButtonsOnError = true,
        bool showBackButtons = false,
      }) async {
    final Color accent = switch (type) {
      AppBottomSheetTypes.success => ColorManager.secondaryColor,
      AppBottomSheetTypes.error => ColorManager.priorityHighRedColor,
    };


    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: switch (type) {
        AppBottomSheetTypes.success => false,
        AppBottomSheetTypes.error => true,
      },
      useSafeArea: true,
      isDismissible: dismissible,
      enableDrag: dismissible,
      backgroundColor: Colors.transparent,
      barrierColor: const Color(0x99000000),
        builder: (context) {
          if (type == AppBottomSheetTypes.success) {
            final nav = Navigator.of(context, rootNavigator: true);
            Future.delayed(autoCloseAfter, () {
              if (nav.canPop()) nav.pop();
            });
          }

          final h = MediaQuery.sizeOf(context).height;
          if (type == AppBottomSheetTypes.success) {
          return _AppBottomSheetBody(
            showBackButtons: showBackButtons,
            type: type,
            accent: accent,
            message: message,
            title: title,
            description: description,
            retryText: retryText,
            backText: backText,
            onRetry: onRetry,
            onBack: onBack,
            showButtonsOnError: showButtonsOnError,
            errorImageAsset: errorImageAsset,
          );}
          else{
            return SizedBox(
              height: h,
              child: _AppBottomSheetBody(
                showBackButtons: showBackButtons,
                type: type,
                accent: accent,
                message: message,
                title: title,
                description: description,
                retryText: retryText,
                backText: backText,
                onRetry: onRetry,
                onBack: onBack,
                showButtonsOnError: showButtonsOnError,
                errorImageAsset: errorImageAsset,
              ),
            );

          }
        }

    );

  }
}

class _AppBottomSheetBody extends StatelessWidget {
  const _AppBottomSheetBody({
    required this.type,
    required this.accent,
    required this.message,
    required this.title,
    required this.description,
    required this.retryText,
    required this.backText,
    required this.onRetry,
    required this.onBack,
    required this.showButtonsOnError,
    required this.errorImageAsset,
    required this.showBackButtons,
  });

  final AppBottomSheetTypes type;
  final Color accent;


  final String message;


  final String? title;
  final String? description;

  final String retryText;
  final String backText;
  final VoidCallback? onRetry;
  final VoidCallback? onBack;

  final bool showButtonsOnError;
  final bool showBackButtons;


  final String? errorImageAsset;

  @override
  Widget build(BuildContext context) {
    final isError = type == AppBottomSheetTypes.error;

    return Material(
      color: Colors.white,
        child: Padding(
          padding: AppPadding.paddingAll50,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isError) ...[
                _SuccessStackedIcon(accent: accent),
                const SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: BottomSheetTextTheme.message.copyWith(
                      color: accent,
                    ),
                  ),
                ),
              ] else ...[
                SizedBox(height: SizedBoxSizes.sizedBoxXXLargeHeight,),
                Image.asset(
                  errorImageAsset ?? ImagePath.errorImage,
                  width: 180,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height:SizedBoxSizes.sizedBoxMediumHeight),
                Text(
                  title ?? AppBottomSheetStrings.unexpectedError,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),
                Text(
                  description ?? message,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    color: ColorManager.notActiveColor,
                  ),
                ),
              ],
              const SizedBox(height: SizedBoxSizes.sizedBoxHeight16),
              if (isError && showButtonsOnError) ...[
                AppPrimaryIconButton(text: retryText,  onPressed: () {
                  Navigator.of(context).pop();
                  onBack?.call();
                }),
                const SizedBox(height: SizedBoxSizes.sizedBoxHeight16),
                if(showBackButtons)
                AppPrimaryIconButton(
                  buttonColor: Colors.white,
                  text: backText,
                  onPressed: () {
                    Navigator.of(context).pop();
                    onBack?.call();
                  },
                ),
              ],
            ],
          ),
        ),

    );
  }
}

class _SuccessStackedIcon extends StatelessWidget {
  const _SuccessStackedIcon({required this.accent});

  final Color accent;

  @override
  Widget build(BuildContext context) {
    final soft = accent.withValues(alpha: 0.2);
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            right: -12,
            top: -5,
            child: Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(color: soft),
            ),
          ),
          Container(
            width: 51,
            height: 51,
            decoration: BoxDecoration(color: accent),
            child: const Icon(Icons.check_rounded, color: Colors.white, size: 30),
          ),
        ],
      ),
    );
  }
}
