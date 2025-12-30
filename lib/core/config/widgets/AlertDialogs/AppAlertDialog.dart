import 'package:flutter/material.dart';
import '../../../theme/app_text_theme.dart';
import '../../constants/app_sizes.dart';
import '../../constants/app_strings.dart';
import '../../constants/color_manager.dart';
import '../buttons/app_button_base.dart';

class AppAlertDialog extends StatelessWidget {
  const AppAlertDialog({
    super.key,
    required this.message,
    this.icon = Icons.power_settings_new_rounded,
    this.confirmText = AlertDialogStrings.confirmText,
    this.cancelText = AlertDialogStrings.cancelText,
    this.onConfirm,
    this.onCancel,
    this.width = 320,
    this.height = 306,
  });

  final String message;

  final IconData icon;
  final String confirmText;
  final String cancelText;

  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;

  final double width;
  final double height;

  static Future<T?> show<T>(
      BuildContext context, {
        required String message,
        IconData icon = Icons.power_settings_new_rounded,
        String confirmText =AlertDialogStrings.confirmText,
        String cancelText = AlertDialogStrings.cancelText,
        bool barrierDismissible = false,
        VoidCallback? onConfirm,
        VoidCallback? onCancel,
      }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) => AppAlertDialog(
        message: message,
        icon: icon,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
        height: 306,
        width: 320,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: width,
          height: height,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(BorderRadiusSize.borderRadius18),
            ),
            padding: AppPadding.paddingAll50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Icon(icon, size: 50, color: ColorManager.priorityHighRedColor),

                const SizedBox(height: SizedBoxSizes.sizedBoxMediumHeight),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextTheme.lightTextTheme.bodyLarge,
                ),
              const SizedBox(height: SizedBoxSizes.sizedBoxLargeHeight),
                Row(
                  children: [
                    Expanded(
                      child: _DialogButton(
                        text: cancelText,
                        filled: false,
                        onTap: () {
                          Navigator.of(context).pop(false);
                          onCancel?.call();
                        },
                      ),
                    ),
                    const SizedBox(width: SizedBoxSizes.sizedBoxSmallHeight),
                    Expanded(
                      child: _DialogButton(
                        text: confirmText,
                        filled: true,
                        onTap: () {
                          Navigator.of(context).pop(true);
                          onConfirm?.call();
                        },
                      ),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.text,
    required this.filled,
    required this.onTap,
  });

  final String text;
  final bool filled;
  final VoidCallback onTap;

  static const _primary = Color(0xFF0F7A69);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 33,
      child: AppButtonBase(
        radius:  BorderRadiusSize.borderRadius10,
        onPressed:onTap,
        backgroundColor: filled ? _primary : Colors.white,
        foregroundColor: filled ? Colors.white : Colors.black,
        borderColor: filled ? null : ColorManager.alertDialogNotActiveButtonColor,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.w500
          ),
        ),
      ),

    );
  }
}