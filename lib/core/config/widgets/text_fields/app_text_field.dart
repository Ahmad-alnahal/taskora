import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/app_sizes.dart';



class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.inputFormatters,
    this.initialValue,

    // Icons
    this.suffixIcon,
    this.prefixIcon,

    // Password
    this.isPassword = false,
    this.enablePasswordToggle = true,

    // Optional overrides
    this.fillColor,
  });


  final String label;

  final String hint;

  final TextEditingController? controller;
  final String? initialValue;

  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;

  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;


  final bool enabled;
  final bool readOnly;

  final int maxLines;
  final int? minLines;

  final List<TextInputFormatter>? inputFormatters;


  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final bool isPassword;
  final bool enablePasswordToggle;

  final Color? fillColor;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;

  @override
  void initState() {
    super.initState();
    _obscure = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final labelStyle = theme.textTheme.titleMedium;

    final hintStyle = theme.textTheme.bodyMedium;



    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: labelStyle),
        const SizedBox(height: SizedBoxSizes.sizedBoxSmallHeight),
        TextFormField(
          controller: widget.controller,
          initialValue: widget.controller == null ? widget.initialValue : null,
          onChanged: widget.onChanged,
          validator: widget.validator,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLines: widget.isPassword ? 1 : widget.maxLines,
          minLines: widget.isPassword ? 1 : widget.minLines,
          obscureText: widget.isPassword ? _obscure : false,
          inputFormatters: widget.inputFormatters,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: hintStyle,
            suffixIcon: widget.suffixIcon,
            prefixIcon: widget.prefixIcon,
          ),
        ),
      ],
    );
  }
}
