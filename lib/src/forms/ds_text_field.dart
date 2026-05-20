import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Tokenized filled text field with floating label, error state, and all
/// focus/disabled/error borders sourced from design-system tokens.
///
/// Wraps Flutter's [TextFormField] — all interaction logic is delegated to the
/// standard controller/validator API.
class DsTextField extends StatelessWidget {
  const DsTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.labelText,
    this.hintText,
    this.errorText,
    this.helperText,
    this.prefixIcon,
    this.suffix,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.validator,
    this.autofocus = false,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? labelText;
  final String? hintText;
  final String? errorText;
  final String? helperText;
  final Widget? prefixIcon;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;
  final FormFieldValidator<String>? validator;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;

    const defaultBorder = OutlineInputBorder(
      borderRadius: AppRadius.soft,
      borderSide: BorderSide.none,
    );

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      obscureText: obscureText,
      enabled: enabled,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      onTap: onTap,
      validator: validator,
      autofocus: autofocus,
      style: AppTextStyles.body.copyWith(
        color: enabled ? c.contentPrimary : c.disabled,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
        helperText: helperText,
        prefixIcon: prefixIcon,
        suffix: suffix,
        filled: true,
        fillColor: enabled ? c.inputFill : c.surfaceOverlay,
        labelStyle: AppTextStyles.body.copyWith(color: c.contentSecondary),
        hintStyle: AppTextStyles.body.copyWith(color: c.contentSecondary),
        errorStyle: AppTextStyles.caption.copyWith(color: c.stateError),
        helperStyle: AppTextStyles.caption.copyWith(color: c.contentSecondary),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.md.w,
          vertical: AppSpacing.sm.h + AppSpacing.xs.h,
        ),
        border: defaultBorder,
        enabledBorder: defaultBorder,
        disabledBorder: defaultBorder,
        focusedBorder: OutlineInputBorder(
          borderRadius: AppRadius.soft,
          borderSide: BorderSide(color: c.accent, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppRadius.soft,
          borderSide: BorderSide(color: c.stateError, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppRadius.soft,
          borderSide: BorderSide(color: c.stateError, width: 1.5),
        ),
      ),
    );
  }
}
