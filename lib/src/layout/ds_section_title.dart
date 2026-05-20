import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../tokens/color_tokens.dart';
import '../tokens/radius.dart';
import '../tokens/spacing.dart';
import '../tokens/typography.dart';

/// Icon + label section title row.
///
/// Used as a visual section header within forms or settings screens.
/// Optionally shows a required-field asterisk.
///
/// Example:
/// ```dart
/// DsSectionTitle(
///   icon: LucideIcons.user,
///   label: 'Personal Information',
///   required: true,
/// )
/// ```
class DsSectionTitle extends StatelessWidget {
  const DsSectionTitle({
    super.key,
    required this.label,
    this.icon,
    this.required = false,
    this.padding,
  });

  final String label;
  final IconData? icon;
  final bool required;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final c = context.colorTokens;
    return Padding(
      padding: padding ??
          EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding.w,
            vertical: AppSpacing.sm.h,
          ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Container(
              width: 22.w,
              height: 22.w,
              decoration: BoxDecoration(
                color: c.accentMuted,
                borderRadius: AppRadius.sharp,
              ),
              child: Icon(icon, size: 13.w, color: c.accent),
            ),
            SizedBox(width: AppSpacing.sm.w),
          ],
          Text(
            label,
            style: AppTextStyles.label.copyWith(color: c.contentPrimary),
          ),
          if (required) ...[
            SizedBox(width: 2.w),
            Text(
              '*',
              style: AppTextStyles.label.copyWith(color: c.stateError),
            ),
          ],
        ],
      ),
    );
  }
}
