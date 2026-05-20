import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Primary / secondary / text button variants using token styling.
class DsButton extends StatelessWidget {
  const DsButton.primary({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width,
  })  : _variant = _BtnVariant.primary,
        icon = null;

  const DsButton.secondary({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width,
  })  : _variant = _BtnVariant.secondary,
        icon = null;

  const DsButton.destructive({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width,
  })  : _variant = _BtnVariant.destructive,
        icon = null;

  const DsButton.text({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.icon,
  }) : _variant = _BtnVariant.text;

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final Widget? icon;
  final _BtnVariant _variant;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    final bool disabled = onPressed == null || isLoading;

    Color bgColor, fgColor;
    Border? border;

    switch (_variant) {
      case _BtnVariant.primary:
        bgColor = disabled ? c.disabled : c.accent;
        fgColor = c.onAccent;
        border = null;
      case _BtnVariant.secondary:
        bgColor = c.surfaceRaised;
        fgColor = disabled ? c.disabled : c.accent;
        border = Border.all(color: disabled ? c.disabled : c.accent);
      case _BtnVariant.destructive:
        bgColor = disabled ? c.disabled : c.stateError;
        fgColor = c.onAccent;
        border = null;
      case _BtnVariant.text:
        bgColor = Colors.transparent;
        fgColor = disabled ? c.disabled : c.accent;
        border = null;
    }

    Widget child = isLoading
        ? SizedBox(
            width: 18.w,
            height: 18.w,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: fgColor,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon!,
                SizedBox(width: AppSpacing.xs.w),
              ],
              Text(
                label,
                style: AppTextStyles.subheading.copyWith(color: fgColor),
              ),
            ],
          );

    return GestureDetector(
      onTap: disabled ? null : onPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: width,
        height: 48.h,
        padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg.w),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppRadius.soft,
          border: border,
        ),
        child: Center(child: child),
      ),
    );
  }
}

enum _BtnVariant { primary, secondary, destructive, text }
